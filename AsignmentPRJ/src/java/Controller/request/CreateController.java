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
import model.RequestForLeave;
import model.iam.User;

/**
 *
 * @author sonnt
 */
@WebServlet(urlPatterns = "/request/create")
public class CreateController extends BaseRequiredAuthenticationController {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        req.getRequestDispatcher("../view/request/create.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        String from = req.getParameter("from");
        String to = req.getParameter("to");
        String reason = req.getParameter("reason");
        
        // ✅ Kiểm tra ngày hợp lệ
        try {
            LocalDate fromDate = LocalDate.parse(from);
            LocalDate toDate = LocalDate.parse(to);
            
            // Kiểm tra ngày kết thúc phải sau hoặc bằng ngày bắt đầu
            if (toDate.isBefore(fromDate)) {
                req.setAttribute("error", "Ngày kết thúc phải sau hoặc bằng ngày bắt đầu!");
                req.setAttribute("from", from);
                req.setAttribute("to", to);
                req.setAttribute("reason", reason);
                req.getRequestDispatcher("../view/request/create.jsp").forward(req, resp);
                return;
            }
            
            // ✅ Validation thành công, tiến hành tạo đơn
            RequestForLeave request = new RequestForLeave();
            request.setCreatedBy(user.getEmployee());
            request.setFrom(java.sql.Date.valueOf(fromDate));
            request.setTo(java.sql.Date.valueOf(toDate));
            request.setReason(reason);
            
            RequestDBContext db = new RequestDBContext();
            db.insert(request);
            
            req.setAttribute("message", "Gửi đơn thành công!");
            req.getRequestDispatcher("../view/request/create.jsp").forward(req, resp);
            
        } catch (Exception e) {
            // Xử lý lỗi parse date hoặc lỗi khác
            req.setAttribute("error", "Định dạng ngày không hợp lệ!");
            req.setAttribute("from", from);
            req.setAttribute("to", to);
            req.setAttribute("reason", reason);
            req.getRequestDispatcher("../view/request/create.jsp").forward(req, resp);
        }

    }
}