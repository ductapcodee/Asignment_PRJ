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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
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
        
        // ✅ Tính toán statistics
        Map<String, Integer> stats = calculateStatistics(requests);
        Map<String, Integer> monthlyStats = calculateMonthlyStats(requests);
        ArrayList<RequestForLeave> upcomingLeaves = getUpcomingLeaves(requests);
        ArrayList<RequestForLeave> pendingRequests = getPendingRequests(requests);
        Map<String, Integer> employeeLeaveCount = getEmployeeLeaveCount(requests);
        
        // ✅ Gửi data sang JSP
        req.setAttribute("stats", stats);
        req.setAttribute("monthlyStats", monthlyStats);
        req.setAttribute("upcomingLeaves", upcomingLeaves);
        req.setAttribute("pendingRequests", pendingRequests);
        req.setAttribute("employeeLeaveCount", employeeLeaveCount);
        req.setAttribute("role", role);
        
        req.getRequestDispatcher("../view/request/dashboard.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        doGet(req, resp, user);
    }
    
    // ✅ Tính thống kê tổng quan
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
    
    // ✅ Thống kê theo tháng
    private Map<String, Integer> calculateMonthlyStats(ArrayList<RequestForLeave> requests) {
        Map<String, Integer> monthlyStats = new HashMap<>();
        LocalDate now = LocalDate.now();
        
        for (int i = 0; i < 6; i++) {
            LocalDate month = now.minusMonths(i);
            int count = 0;
            for (RequestForLeave r : requests) {
                LocalDate from = r.getFrom().toLocalDate();
                if (from.getMonthValue() == month.getMonthValue() && 
                    from.getYear() == month.getYear() && 
                    r.getStatus() == 2) {
                    count++;
                }
            }
            monthlyStats.put(month.getMonth().toString(), count);
        }
        return monthlyStats;
    }
    
    // ✅ Lấy danh sách nghỉ sắp tới (7 ngày tới)
    private ArrayList<RequestForLeave> getUpcomingLeaves(ArrayList<RequestForLeave> requests) {
        ArrayList<RequestForLeave> upcoming = new ArrayList<>();
        LocalDate now = LocalDate.now();
        LocalDate weekLater = now.plusDays(7);
        
        for (RequestForLeave r : requests) {
            if (r.getStatus() == 2) { // Chỉ lấy đã approved
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
            if (r.getStatus() == 1) {
                pending.add(r);
            }
        }
        // Sort by created_time DESC
        pending.sort((r1, r2) -> r2.getCreatedTime().compareTo(r1.getCreatedTime()));
        return pending;
    }
    
    // ✅ Đếm số lần nghỉ của từng nhân viên
    private Map<String, Integer> getEmployeeLeaveCount(ArrayList<RequestForLeave> requests) {
        Map<String, Integer> count = new HashMap<>();
        for (RequestForLeave r : requests) {
            if (r.getStatus() == 2) { // Chỉ đếm approved
                String name = r.getCreatedBy().getName();
                count.put(name, count.getOrDefault(name, 0) + 1);
            }
        }
        return count;
    }
    
    private int countByStatus(ArrayList<RequestForLeave> requests, int status) {
        int count = 0;
        for (RequestForLeave r : requests) {
            if (r.getStatus() == status) count++;
        }
        return count;
    }
    
    private String getUserRole(User user) {
        if (user.getRoles() != null && !user.getRoles().isEmpty()) {
            return user.getRoles().get(0).getRname().toLowerCase();
        }
        return "employee";
    }
}