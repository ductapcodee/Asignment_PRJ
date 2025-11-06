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
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import model.RequestForLeave;
import model.iam.User;

@WebServlet(urlPatterns = "/request/report")
public class ReportController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        String format = req.getParameter("format");
        String fromDate = req.getParameter("from");
        String toDate = req.getParameter("to");
        String status = req.getParameter("status");

        // ✅ Lấy data
        RequestDBContext db = new RequestDBContext();
        ArrayList<RequestForLeave> requests = getRequestsByRole(db, user);

        // ===== Filter Date =====
        if ((fromDate != null && !fromDate.isEmpty()) && (toDate != null && !toDate.isEmpty())) {
            LocalDate from = LocalDate.parse(fromDate);
            LocalDate to = LocalDate.parse(toDate);

            if (from.isAfter(to)) {
                req.setAttribute("error", "❌ 'From Date' cannot be later than 'To Date'.");
                req.getRequestDispatcher("../view/request/report.jsp").forward(req, resp);
                return;
            }

            requests = filterByDateRange(requests, fromDate, toDate);
        }

        // ===== Filter Status =====
        if (status != null && !status.equals("all")) {
            requests = filterByStatus(requests, Integer.parseInt(status));
        }

        // ===== Export =====
        if ("excel".equals(format)) {
            exportToExcel(resp, requests);
            return; // ✅ STOP here, không chạy xuống phân trang
        }

        // ===== Pagination =====
        int pagesize = 7;
        int totalRecords = requests.size();
        int totalPages = (totalRecords + pagesize - 1) / pagesize;
        String page_raw = req.getParameter("page");
        int pageindex = 1;
        try {
            if (page_raw != null && !page_raw.isEmpty()) {
                pageindex = Integer.parseInt(page_raw.trim());  // ✅ trim tránh lỗi
            }
        } catch (Exception e) {
            pageindex = 1;  // fallback
        }

        pageindex = Math.max(1, Math.min(pageindex, totalPages));

        int fromIndex = (pageindex - 1) * pagesize;
        int toIndex = Math.min(fromIndex + pagesize, totalRecords);

        ArrayList<RequestForLeave> pageList = new ArrayList<>(requests.subList(fromIndex, toIndex));

        // ===== Send to JSP =====
        req.setAttribute("requests", pageList);
        req.setAttribute("pageindex", pageindex);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("../view/request/report.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        doGet(req, resp, user);
    }

    // ✅ Export to Excel (HTML table with Excel MIME type)
    private void exportToExcel(HttpServletResponse resp, ArrayList<RequestForLeave> requests)
            throws IOException {
        resp.setContentType("application/vnd.ms-excel");
        resp.setHeader("Content-Disposition", "attachment; filename=leave_report_"
                + LocalDate.now() + ".xls");

        PrintWriter writer = resp.getWriter();

        writer.println("<?xml version=\"1.0\"?>");
        writer.println("<?mso-application progid=\"Excel.Sheet\"?>");
        writer.println("<Workbook xmlns=\"urn:schemas-microsoft-com:office:spreadsheet\"");
        writer.println(" xmlns:ss=\"urn:schemas-microsoft-com:office:spreadsheet\">");
        writer.println("<Worksheet ss:Name=\"Leave Report\">");
        writer.println("<Table>");

        // Header row
        writer.println("<Row>");
        writer.println("<Cell><Data ss:Type=\"String\">ID</Data></Cell>");
        writer.println("<Cell><Data ss:Type=\"String\">Employee</Data></Cell>");
        writer.println("<Cell><Data ss:Type=\"String\">From</Data></Cell>");
        writer.println("<Cell><Data ss:Type=\"String\">To</Data></Cell>");
        writer.println("<Cell><Data ss:Type=\"String\">Days</Data></Cell>");
        writer.println("<Cell><Data ss:Type=\"String\">Reason</Data></Cell>");
        writer.println("<Cell><Data ss:Type=\"String\">Status</Data></Cell>");
        writer.println("<Cell><Data ss:Type=\"String\">Processed By</Data></Cell>");
        writer.println("<Cell><Data ss:Type=\"String\">Process Date</Data></Cell>");
        writer.println("</Row>");

        // Data rows
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        for (RequestForLeave r : requests) {
            long days = r.getTo().toLocalDate().toEpochDay()
                    - r.getFrom().toLocalDate().toEpochDay() + 1;

            String statusText = r.getStatus() == 1 ? "Pending"
                    : (r.getStatus() == 2 ? "Approved" : "Rejected");

            String processedBy = r.getProcessedBy() != null
                    ? r.getProcessedBy().getName() : "N/A";

            String processDate = r.getProcessedTime() != null
                    ? r.getProcessedTime().toLocalDateTime().format(formatter) : "N/A";

            writer.println("<Row>");
            writer.printf("<Cell><Data ss:Type=\"Number\">%d</Data></Cell>\n", r.getId());
            writer.printf("<Cell><Data ss:Type=\"String\">%s</Data></Cell>\n",
                    escapeXml(r.getCreatedBy().getName()));
            writer.printf("<Cell><Data ss:Type=\"String\">%s</Data></Cell>\n",
                    r.getFrom().toLocalDate().format(formatter));
            writer.printf("<Cell><Data ss:Type=\"String\">%s</Data></Cell>\n",
                    r.getTo().toLocalDate().format(formatter));
            writer.printf("<Cell><Data ss:Type=\"Number\">%d</Data></Cell>\n", days);
            writer.printf("<Cell><Data ss:Type=\"String\">%s</Data></Cell>\n",
                    escapeXml(r.getReason()));
            writer.printf("<Cell><Data ss:Type=\"String\">%s</Data></Cell>\n", statusText);
            writer.printf("<Cell><Data ss:Type=\"String\">%s</Data></Cell>\n",
                    escapeXml(processedBy));
            writer.printf("<Cell><Data ss:Type=\"String\">%s</Data></Cell>\n", processDate);
            writer.println("</Row>");
        }

        writer.println("</Table>");
        writer.println("</Worksheet>");
        writer.println("</Workbook>");

        writer.flush();
    }

    // ✅ Helper methods
    private ArrayList<RequestForLeave> getRequestsByRole(RequestDBContext db, User user) {
        String role = getUserRole(user);
        if (role.contains("head") || role.contains("leader")) {
            return db.getRequestsOfDivision(user.getEmployee().getDivision().getId());
        } else if (role.contains("pm") || role.contains("manager")) {
            return db.getRequestsOfManager(user.getEmployee().getId());
        } else {
            return db.getRequestsOfEmployee(user.getEmployee().getId());
        }
    }

    private ArrayList<RequestForLeave> filterByDateRange(ArrayList<RequestForLeave> requests,
            String from, String to) {
        ArrayList<RequestForLeave> filtered = new ArrayList<>();
        LocalDate fromDate = LocalDate.parse(from);
        LocalDate toDate = LocalDate.parse(to);

        for (RequestForLeave r : requests) {
            LocalDate rFrom = r.getFrom().toLocalDate();
            if (!rFrom.isBefore(fromDate) && !rFrom.isAfter(toDate)) {
                filtered.add(r);
            }
        }
        return filtered;
    }

    private ArrayList<RequestForLeave> filterByStatus(ArrayList<RequestForLeave> requests,
            int status) {
        ArrayList<RequestForLeave> filtered = new ArrayList<>();
        for (RequestForLeave r : requests) {
            if (r.getStatus() == status) {
                filtered.add(r);
            }
        }
        return filtered;
    }

    private String getUserRole(User user) {
        if (user.getRoles() != null && !user.getRoles().isEmpty()) {
            return user.getRoles().get(0).getRname().toLowerCase();
        }
        return "employee";
    }

    private String escapeXml(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&apos;");
    }
}
