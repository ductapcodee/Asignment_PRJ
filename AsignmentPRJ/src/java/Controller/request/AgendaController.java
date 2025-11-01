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
import java.time.YearMonth;
import java.util.ArrayList;
import model.RequestForLeave;
import model.iam.User;

@WebServlet(urlPatterns = "/request/agenda")
public class AgendaController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        // ✅ Lấy tháng/năm từ params hoặc dùng tháng hiện tại
        String yearParam = req.getParameter("year");
        String monthParam = req.getParameter("month");
        String todayParam = req.getParameter("today");

        YearMonth currentMonth;
        LocalDate today = LocalDate.now();

        if ("true".equals(todayParam)) {
            // Khi nhấn nút Today -> load tháng hiện tại
            currentMonth = YearMonth.of(today.getYear(), today.getMonthValue());
        } else if (yearParam != null && monthParam != null) {
            currentMonth = YearMonth.of(Integer.parseInt(yearParam), Integer.parseInt(monthParam));
        } else {
            currentMonth = YearMonth.now();
        }

        // ✅ Lấy danh sách request theo role
        RequestDBContext db = new RequestDBContext();
        ArrayList<RequestForLeave> requests = new ArrayList<>();

        String role = getUserRole(user);

        if (role.contains("head") || role.contains("leader")) {
            // Division Leader: xem toàn bộ phòng ban
            int divisionId = user.getEmployee().getDivision().getId();
            requests = db.getRequestsOfDivision(divisionId);
        } else if (role.contains("pm") || role.contains("manager")) {
            // Manager: xem của mình và cấp dưới
            requests = db.getRequestsOfManager(user.getEmployee().getId());
        } else {
            // Employee: chỉ xem của mình
            requests = db.getRequestsOfEmployee(user.getEmployee().getId());
        }

        // ✅ Lọc requests theo tháng đang xem
        ArrayList<RequestForLeave> monthRequests = filterByMonth(requests, currentMonth);

        // ✅ Tính toán thống kê
        int totalRequests = monthRequests.size();
        int pending = countByStatus(monthRequests, 1);
        int approved = countByStatus(monthRequests, 2);
        int rejected = countByStatus(monthRequests, 3);

        // ✅ Gửi dữ liệu sang JSP
        req.setAttribute("requests", monthRequests);
        req.setAttribute("currentMonth", currentMonth);
        req.setAttribute("year", currentMonth.getYear());
        req.setAttribute("month", currentMonth.getMonthValue());
        req.setAttribute("role", role);
        req.setAttribute("stats", new int[]{totalRequests, pending, approved, rejected});
        req.setAttribute("today", today);

        req.getRequestDispatcher("../view/request/agenda.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        doGet(req, resp, user);
    }

    // ✅ Helper: Lấy role của user
    private String getUserRole(User user) {
        if (user.getRoles() != null && !user.getRoles().isEmpty()) {
            return user.getRoles().get(0).getRname().toLowerCase();
        }
        return "employee";
    }

    // ✅ Helper: Lọc requests theo tháng
    private ArrayList<RequestForLeave> filterByMonth(ArrayList<RequestForLeave> requests, YearMonth month) {
        ArrayList<RequestForLeave> filtered = new ArrayList<>();
        LocalDate startOfMonth = month.atDay(1);
        LocalDate endOfMonth = month.atEndOfMonth();

        for (RequestForLeave r : requests) {
            LocalDate from = r.getFrom().toLocalDate();
            LocalDate to = r.getTo().toLocalDate();

            // Kiểm tra xem request có overlap với tháng đang xem không
            if (!(to.isBefore(startOfMonth) || from.isAfter(endOfMonth))) {
                filtered.add(r);
            }
        }
        return filtered;
    }

    // ✅ Helper: Đếm theo status
    private int countByStatus(ArrayList<RequestForLeave> requests, int status) {
        int count = 0;
        for (RequestForLeave r : requests) {
            if (r.getStatus() == status) {
                count++;
            }
        }
        return count;
    }
}
