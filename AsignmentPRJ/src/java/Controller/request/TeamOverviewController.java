/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.request;

import Controller.iam.BaseRequiredAuthenticationController;
import dal.EmployeeDBContext;
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
import model.Employee;
import model.RequestForLeave;
import model.iam.User;

@WebServlet(urlPatterns = "/request/team")
public class TeamOverviewController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        // ✅ Lấy danh sách nhân viên trong team
        EmployeeDBContext empDB = new EmployeeDBContext();
        RequestDBContext reqDB = new RequestDBContext();

        ArrayList<Employee> teamMembers = new ArrayList<>();
        String role = getUserRole(user);

        if (role.contains("head") || role.contains("leader")) {
            // Division Leader: lấy toàn bộ division
            teamMembers = empDB.getEmployeesByDivision(user.getEmployee().getDivision().getId());
        } else if (role.contains("pm") || role.contains("manager")) {
            // Manager: lấy cấp dưới
            teamMembers = empDB.getSubordinates(user.getEmployee().getId());
            teamMembers.add(user.getEmployee()); // Add self
        }

        // ✅ Lấy requests của division
        ArrayList<RequestForLeave> requests;
        if (role.contains("head") || role.contains("leader")) {
            requests = reqDB.getRequestsOfDivision(user.getEmployee().getDivision().getId());
        } else {
            requests = reqDB.getRequestsOfManager(user.getEmployee().getId());
        }

        // ✅ Tính toán metrics cho từng nhân viên
        Map<Integer, EmployeeMetrics> metricsMap = calculateEmployeeMetrics(teamMembers, requests);

        // ✅ Tìm employees on leave hôm nay
        ArrayList<Employee> onLeaveToday = getEmployeesOnLeaveToday(requests);

        // ✅ Tìm employees nghỉ nhiều nhất
        ArrayList<Map.Entry<Employee, Integer>> topLeaveUsers = getTopLeaveUsers(metricsMap, teamMembers);

        // ✅ Team availability cho 7 ngày tới
        Map<LocalDate, Integer> availabilityForecast = calculateAvailabilityForecast(requests, teamMembers.size());

        // ✅ Gửi data sang JSP
        req.setAttribute("teamMembers", teamMembers);
        req.setAttribute("metricsMap", metricsMap);
        req.setAttribute("onLeaveToday", onLeaveToday);
        req.setAttribute("topLeaveUsers", topLeaveUsers);
        req.setAttribute("availabilityForecast", availabilityForecast);
        req.setAttribute("role", role);

        req.getRequestDispatcher("../view/request/team.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        doGet(req, resp, user);
    }

    // ✅ Class lưu metrics của từng nhân viên
    public static class EmployeeMetrics {

        public int totalRequests;
        public int approvedRequests;
        public int pendingRequests;
        public int totalLeaveDays;
        public int remainingLeaveQuota; // Giả sử mỗi người có 20 ngày/năm
        public LocalDate lastLeaveDate;
        public boolean isOnLeaveToday;

        public EmployeeMetrics() {
            this.remainingLeaveQuota = 20; // Default annual leave quota
        }

        public int getTotalRequests() {
            return totalRequests;
        }

        public void setTotalRequests(int totalRequests) {
            this.totalRequests = totalRequests;
        }

        public int getApprovedRequests() {
            return approvedRequests;
        }

        public void setApprovedRequests(int approvedRequests) {
            this.approvedRequests = approvedRequests;
        }

        public int getPendingRequests() {
            return pendingRequests;
        }

        public void setPendingRequests(int pendingRequests) {
            this.pendingRequests = pendingRequests;
        }

        public int getTotalLeaveDays() {
            return totalLeaveDays;
        }

        public void setTotalLeaveDays(int totalLeaveDays) {
            this.totalLeaveDays = totalLeaveDays;
        }

        public int getRemainingLeaveQuota() {
            return remainingLeaveQuota;
        }

        public void setRemainingLeaveQuota(int remainingLeaveQuota) {
            this.remainingLeaveQuota = remainingLeaveQuota;
        }

        public LocalDate getLastLeaveDate() {
            return lastLeaveDate;
        }

        public void setLastLeaveDate(LocalDate lastLeaveDate) {
            this.lastLeaveDate = lastLeaveDate;
        }

        public boolean isOnLeaveToday() {
            return isOnLeaveToday;
        }

        public void setOnLeaveToday(boolean onLeaveToday) {
            this.isOnLeaveToday = onLeaveToday;
        }
    }

    // ✅ Tính metrics cho từng employee
    private Map<Integer, EmployeeMetrics> calculateEmployeeMetrics(
            ArrayList<Employee> employees, ArrayList<RequestForLeave> requests) {

        Map<Integer, EmployeeMetrics> map = new HashMap<>();
        LocalDate today = LocalDate.now();

        // Initialize metrics for all employees
        for (Employee emp : employees) {
            map.put(emp.getId(), new EmployeeMetrics());
        }

        // Calculate from requests
        for (RequestForLeave req : requests) {
            int empId = req.getCreatedBy().getId();
            if (!map.containsKey(empId)) {
                continue;
            }

            EmployeeMetrics metrics = map.get(empId);
            metrics.totalRequests++;

            if (req.getStatus() == 2) { // Approved
                metrics.approvedRequests++;

                // Calculate leave days
                long days = req.getTo().toLocalDate().toEpochDay()
                        - req.getFrom().toLocalDate().toEpochDay() + 1;
                metrics.totalLeaveDays += days;

                // Update last leave date
                LocalDate toDate = req.getTo().toLocalDate();
                if (metrics.lastLeaveDate == null || toDate.isAfter(metrics.lastLeaveDate)) {
                    metrics.lastLeaveDate = toDate;
                }

                // Check if on leave today
                LocalDate fromDate = req.getFrom().toLocalDate();
                if (!today.isBefore(fromDate) && !today.isAfter(toDate)) {
                    metrics.isOnLeaveToday = true;
                }
            } else if (req.getStatus() == 1) { // Pending
                metrics.pendingRequests++;
            }
        }

        // Calculate remaining quota
        for (EmployeeMetrics metrics : map.values()) {
            metrics.remainingLeaveQuota = 20 - metrics.totalLeaveDays;
        }

        return map;
    }

    // ✅ Lấy employees đang nghỉ hôm nay
    private ArrayList<Employee> getEmployeesOnLeaveToday(ArrayList<RequestForLeave> requests) {
        ArrayList<Employee> onLeave = new ArrayList<>();
        LocalDate today = LocalDate.now();

        for (RequestForLeave req : requests) {
            if (req.getStatus() == 2) { // Only approved
                LocalDate from = req.getFrom().toLocalDate();
                LocalDate to = req.getTo().toLocalDate();

                if (!today.isBefore(from) && !today.isAfter(to)) {
                    if (!onLeave.contains(req.getCreatedBy())) {
                        onLeave.add(req.getCreatedBy());
                    }
                }
            }
        }
        return onLeave;
    }

// ✅ Top employees by leave days
    private ArrayList<Map.Entry<Employee, Integer>> getTopLeaveUsers(
            Map<Integer, EmployeeMetrics> metricsMap, ArrayList<Employee> employees) {

        Map<Employee, Integer> leaveDaysMap = new HashMap<>();

        for (Employee emp : employees) {
            EmployeeMetrics metrics = metricsMap.get(emp.getId());
            if (metrics != null) {
                leaveDaysMap.put(emp, metrics.totalLeaveDays);
            }
        }

        ArrayList<Map.Entry<Employee, Integer>> list = new ArrayList<>(leaveDaysMap.entrySet());
        list.sort((e1, e2) -> e2.getValue().compareTo(e1.getValue())); // Sort DESC
        return list;
    }

    // ✅ Dự báo availability cho 7 ngày tới
    private Map<LocalDate, Integer> calculateAvailabilityForecast(
            ArrayList<RequestForLeave> requests, int teamSize) {

        Map<LocalDate, Integer> forecast = new HashMap<>();
        LocalDate today = LocalDate.now();

        for (int i = 0; i < 7; i++) {
            LocalDate date = today.plusDays(i);
            int onLeave = 0;

            for (RequestForLeave req : requests) {
                if (req.getStatus() == 2) { // Only approved
                    LocalDate from = req.getFrom().toLocalDate();
                    LocalDate to = req.getTo().toLocalDate();

                    if (!date.isBefore(from) && !date.isAfter(to)) {
                        onLeave++;
                    }
                }
            }

            forecast.put(date, teamSize - onLeave);
        }

        return forecast;
    }

    private String getUserRole(User user) {
        if (user.getRoles() != null && !user.getRoles().isEmpty()) {
            return user.getRoles().get(0).getRname().toLowerCase();
        }
        return "employee";
    }
}
