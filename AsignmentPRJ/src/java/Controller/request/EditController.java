package Controller.request;

import Controller.iam.BaseRequiredAuthenticationController;
import dal.RequestDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import model.RequestForLeave;
import model.iam.User;

@WebServlet(urlPatterns = "/request/edit")
public class EditController extends BaseRequiredAuthenticationController {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        int rid = Integer.parseInt(req.getParameter("rid"));
        RequestDBContext db = new RequestDBContext();
        RequestForLeave r = db.get(rid);
        
        // ✅ Chỉ cho phép chỉnh sửa nếu là người tạo và đơn chưa được xử lý
        if (r == null || r.getCreatedBy().getId() != user.getEmployee().getId() || r.getStatus() != 1) {
            resp.sendRedirect(req.getContextPath() + "/request/list?updated=true");
            return;
        }
        
        req.setAttribute("request", r);
        req.getRequestDispatcher("../view/request/edit.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        int rid = Integer.parseInt(req.getParameter("rid"));
        String reason = req.getParameter("reason");
        String from = req.getParameter("from");
        String to = req.getParameter("to");
        
        // ✅ Kiểm tra ngày hợp lệ
        try {
            LocalDate fromDate = LocalDate.parse(from);
            LocalDate toDate = LocalDate.parse(to);
            
            // Kiểm tra ngày kết thúc phải sau hoặc bằng ngày bắt đầu
            if (toDate.isBefore(fromDate)) {
                RequestDBContext db = new RequestDBContext();
                RequestForLeave r = db.get(rid);
                
                req.setAttribute("request", r);
                req.setAttribute("error", "Ngày kết thúc phải sau hoặc bằng ngày bắt đầu!");
                req.getRequestDispatcher("../view/request/edit.jsp").forward(req, resp);
                return;
            }
            
            // ✅ Validation thành công, tiến hành update
            RequestDBContext db = new RequestDBContext();
            db.updateRequest(rid, reason, from, to);
            
            // Redirect lại ListController với thông báo thành công
            resp.sendRedirect(req.getContextPath() + "/request/list?updated=true");
            
        } catch (Exception e) {
            // Xử lý lỗi parse date hoặc lỗi khác
            RequestDBContext db = new RequestDBContext();
            RequestForLeave r = db.get(rid);
            
            req.setAttribute("request", r);
            req.setAttribute("error", "Định dạng ngày không hợp lệ!");
            req.getRequestDispatcher("../view/request/edit.jsp").forward(req, resp);
        }
    }
}