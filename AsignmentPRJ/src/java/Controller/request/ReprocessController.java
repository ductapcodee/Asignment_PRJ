package Controller.request;

import Controller.iam.BaseRequiredAuthenticationController;
import dal.RequestDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import model.Employee;
import model.RequestForLeave;
import model.iam.User;

@WebServlet(urlPatterns = "/request/reprocess")
public class ReprocessController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        int rid = Integer.parseInt(req.getParameter("rid"));
        RequestDBContext db = new RequestDBContext();
        RequestForLeave request = db.get(rid);


        if (request == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Request not found.");
            return;
        }

        // ✅ Kiểm tra quyền
        String roleName = user.getPrimaryRoleName() != null ? user.getPrimaryRoleName() : "";
        boolean isPM = roleName.toLowerCase().contains("pm");
        boolean isDivisionHead = roleName.toLowerCase().contains("head");

        if (!isPM && !isDivisionHead) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to reprocess this request!");
            return;
        }

        // ❌ PM không thể reprocess đơn đã được xử lý bởi Division Leader
        if (isPM && request.getProcessedBy() != null
                && request.getProcessedBy().getSupervisor() == null) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "This request was processed by Division Leader. PM cannot reprocess it!");
            return;
        }

        // ✅ Kiểm tra ngày reprocess
        LocalDate now = LocalDate.now();
        LocalDate leaveDate = request.getFrom().toLocalDate();
        if (!now.isBefore(leaveDate.minusDays(2))) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Cannot reprocess request less than 2 days before leave date!");
            return;
        }

        req.setAttribute("request", request);
        req.getRequestDispatcher("../view/request/reprocess.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        int rid = Integer.parseInt(req.getParameter("rid"));
        int status = Integer.parseInt(req.getParameter("status"));
        String reason = req.getParameter("process_reason");
        int processedBy = user.getEmployee().getId();

        RequestDBContext db = new RequestDBContext();
        RequestForLeave request = db.get(rid);
        Employee current = user.getEmployee();

        if (request == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Request not found!");
            return;
        }

        boolean isPM = user.getPrimaryRoleName().contains("PM");
        boolean isDivisionHead = user.getPrimaryRoleName().contains("Head") || current.getSupervisor() == null;

        if (!isPM && !isDivisionHead) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to reprocess this request!");
            return;
        }

        if (isPM && request.getProcessedBy() != null
                && request.getProcessedBy().getSupervisor() == null) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "PM cannot reprocess a request already handled by Division Leader!");
            return;
        }
        // ✅ Division Leader có thể reprocess lại đơn đã xử lý bởi PM
        if (isDivisionHead && request.getProcessedBy() != null
                && request.getProcessedBy().getSupervisor() != null) {
            // Cho phép reprocess, không cần chặn
        }
        LocalDate now = LocalDate.now();
        LocalDate leaveDate = request.getFrom().toLocalDate();
        if (!now.isBefore(leaveDate.minusDays(2))) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Cannot reprocess less than 2 days before leave date!");
            return;
        }

        // ✅ Cập nhật lại đơn
        db.processRequest(rid, status, reason, processedBy);

        resp.sendRedirect(req.getContextPath() + "/request/list?updated=true");

    }
}
