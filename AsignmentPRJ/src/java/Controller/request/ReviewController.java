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
import model.Employee;
import model.RequestForLeave;
import model.iam.User;

@WebServlet(urlPatterns = "/request/review")
public class ReviewController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        int rid = Integer.parseInt(req.getParameter("rid"));
        RequestDBContext db = new RequestDBContext();
        RequestForLeave request = db.get(rid);
        Employee current = user.getEmployee();

        if (request == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Request not found.");
            return;
        }

        // ❌ Không cho phép tự review đơn của mình
        if (request.getCreatedBy().getId() == current.getId()) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "You cannot review your own request!");
            return;
        }

        // ✅ Kiểm tra quyền xử lý
        boolean isSupervisor = request.getCreatedBy().getSupervisor() != null
                && request.getCreatedBy().getSupervisor().getId() == current.getId();

        boolean isDivisionHead = current.getSupervisor() == null
                && request.getCreatedBy().getDivision() != null
                && request.getCreatedBy().getDivision().getId() == current.getDivision().getId();

        if (!isSupervisor && !isDivisionHead) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to review this request!");
            return;
        }

        // ✅ Cho phép hiển thị trang review
        req.setAttribute("request", request);
        req.getRequestDispatcher("../view/request/review.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        int rid = Integer.parseInt(req.getParameter("rid"));
        String action = req.getParameter("action"); // "approve" hoặc "reject"
        String reason = req.getParameter("process_reason");
        int processedBy = user.getEmployee().getId();

        // ✅ Ánh xạ rõ ràng trạng thái
        int status;
        if ("approve".equalsIgnoreCase(action)) {
            status = 2; // Đã duyệt
        } else if ("reject".equalsIgnoreCase(action)) {
            status = 3; // Từ chối
        } else {
            status = 1; // Chờ duyệt (fallback)
        }

        RequestDBContext db = new RequestDBContext();
        RequestForLeave request = db.get(rid);

        // ❌ Chặn xử lý sai quyền
        if (request.getCreatedBy().getId() == processedBy) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "You cannot process your own request!");
            return;
        }

        boolean isSupervisor = request.getCreatedBy().getSupervisor() != null
                && request.getCreatedBy().getSupervisor().getId() == processedBy;

        boolean isDivisionHead = user.getEmployee().getSupervisor() == null
                && request.getCreatedBy().getDivision() != null
                && request.getCreatedBy().getDivision().getId() == user.getEmployee().getDivision().getId();

        if (!isSupervisor && !isDivisionHead) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to process this request!");
            return;
        }

        // ✅ Xử lý đơn hợp lệ
        db.processRequest(rid, status, reason, processedBy);
        resp.sendRedirect(req.getContextPath() + "/request/list?updated=true");

    }
}
