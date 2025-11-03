/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.request;

import Controller.iam.BaseRequiredAuthenticationController;
import dal.RequestDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.TextStyle;
import java.util.*;
import model.RequestForLeave;
import model.iam.User;

@WebServlet(urlPatterns = "/request/dashboard")
public class DashboardController extends BaseRequiredAuthenticationController {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        
        RequestDBContext db = new RequestDBContext();
        ArrayList<RequestForLeave> requests = new ArrayList<>();
        
        // ✅ Lấy data theo role
        String role = getUserRole(user);
        if (role.contains("head") || role.contains("leader")) {
            int divisionId = user.getEmployee().getDivision().getId();
            requests = db.getRequestsOfDivision(divisionId);
        } else if (role.contains("pm") || role.contains("manager")) {
            requests = db.getRequestsOfManager(user.getEmployee().getId());
        } else {
            requests = db.getRequestsOfEmployee(user.getEmployee().getId());
        }

        // ✅ Lấy lựa chọn quý
        String quarterParam = req.getParameter("quarter");
        int quarter = quarterParam != null && !quarterParam.isEmpty() ? Integer.parseInt(quarterParam) : 0;

        Map<String, Integer> stats = calculateStatistics(requests);
        Map<String, Integer> monthlyStats = calculateQuarterlyStats(requests, quarter);
        ArrayList<RequestForLeave> upcomingLeaves = getUpcomingLeaves(requests);
        ArrayList<RequestForLeave> pendingRequests = getPendingRequests(requests);
        Map<String, Integer> employeeLeaveCount = getEmployeeLeaveDays(requests);

        // ✅ Gửi data sang JSP
        req.setAttribute("stats", stats);
        req.setAttribute("monthlyStats", monthlyStats);
        req.setAttribute("upcomingLeaves", upcomingLeaves);
        req.setAttribute("pendingRequests", pendingRequests);
        req.setAttribute("employeeLeaveCount", employeeLeaveCount);
        req.setAttribute("role", role);
        req.setAttribute("selectedQuarter", quarter);

        req.getRequestDispatcher("../view/request/dashboard.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        doGet(req, resp, user);
    }

    // ✅ Tổng quan
    private Map<String, Integer> calculateStatistics(ArrayList<RequestForLeave> requests) {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("total", requests.size());
        stats.put("pending", countByStatus(requests, 1));
        stats.put("approved", countByStatus(requests, 2));
        stats.put("rejected", countByStatus(requests, 3));

        // Tính số ngày nghỉ approved trong tháng này
        int approvedDays = 0;
        LocalDate now = LocalDate.now();
        for (RequestForLeave r : requests) {
            if (r.getStatus() == 2) {
                LocalDate from = r.getFrom().toLocalDate();
                LocalDate to = r.getTo().toLocalDate();
                if (from.getMonthValue() == now.getMonthValue() && from.getYear() == now.getYear()) {
                    approvedDays += (int) (to.toEpochDay() - from.toEpochDay() + 1);
                }
            }
        }
        stats.put("approvedDays", approvedDays);
        
        return stats;
    }

    // ✅ Theo quý (Quarter)
    private Map<String, Integer> calculateQuarterlyStats(ArrayList<RequestForLeave> requests, int quarter) {
        Map<String, Integer> stats = new LinkedHashMap<>();
        LocalDate now = LocalDate.now();
        int year = now.getYear();

        List<Month> months = switch (quarter) {
            case 1 -> List.of(Month.JANUARY, Month.FEBRUARY, Month.MARCH);
            case 2 -> List.of(Month.APRIL, Month.MAY, Month.JUNE);
            case 3 -> List.of(Month.JULY, Month.AUGUST, Month.SEPTEMBER);
            case 4 -> List.of(Month.OCTOBER, Month.NOVEMBER, Month.DECEMBER);
            default -> Arrays.asList(Month.values()); // All months
        };

        for (Month m : months) {
            int count = 0;
            for (RequestForLeave r : requests) {
                if (r.getStatus() == 2) {
                    LocalDate from = r.getFrom().toLocalDate();
                    if (from.getMonthValue() == m.getValue() && from.getYear() == year) {
                        count++;
                    }
                }
            }
            stats.put(m.getDisplayName(TextStyle.SHORT, Locale.ENGLISH), count);
        }

        return stats;
    }

    private ArrayList<RequestForLeave> getUpcomingLeaves(ArrayList<RequestForLeave> requests) {
        ArrayList<RequestForLeave> upcoming = new ArrayList<>();
        LocalDate now = LocalDate.now();
        LocalDate weekLater = now.plusDays(7);
        
        for (RequestForLeave r : requests) {
            if (r.getStatus() == 2) {
                LocalDate from = r.getFrom().toLocalDate();
                if (!from.isBefore(now) && !from.isAfter(weekLater)) {
                    upcoming.add(r);
                }
            }
        }
        return upcoming;
    }

    // ✅ Lấy pending requests cần xử lý
    private ArrayList<RequestForLeave> getPendingRequests(ArrayList<RequestForLeave> requests) {
        ArrayList<RequestForLeave> pending = new ArrayList<>();
        for (RequestForLeave r : requests) {
            if (r.getStatus() == 1) pending.add(r);
        }
        pending.sort((r1, r2) -> r2.getCreatedTime().compareTo(r1.getCreatedTime()));
        return pending;
    }

    // ✅ Employee Leave Count — đếm theo số ngày nghỉ (int)
    private Map<String, Integer> getEmployeeLeaveDays(ArrayList<RequestForLeave> requests) {
        Map<String, Integer> count = new LinkedHashMap<>();
        for (RequestForLeave r : requests) {
            if (r.getStatus() == 2) {
                String name = r.getCreatedBy().getName();
                LocalDate from = r.getFrom().toLocalDate();
                LocalDate to = r.getTo().toLocalDate();
                int days = (int) (to.toEpochDay() - from.toEpochDay() + 1);
                count.put(name, count.getOrDefault(name, 0) + days);
            }
        }
        return count;
    }

    private int countByStatus(ArrayList<RequestForLeave> requests, int status) {
        int c = 0;
        for (RequestForLeave r : requests)
            if (r.getStatus() == status) c++;
        return c;
    }

    private String getUserRole(User user) {
        if (user.getRoles() != null && !user.getRoles().isEmpty()) {
            return user.getRoles().get(0).getRname().toLowerCase();
        }
        return "employee";
    }
}
