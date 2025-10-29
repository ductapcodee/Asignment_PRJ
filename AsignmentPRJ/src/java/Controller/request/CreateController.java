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
import java.sql.Date;
import model.RequestForLeave;
import model.iam.User;

/**
 *
 * @author sonnt
 */
@WebServlet(urlPatterns = "/request/create")
public class CreateController extends BaseRequiredAuthenticationController {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        try {
            String from = req.getParameter("from");
            String to = req.getParameter("to");
            String reason = req.getParameter("reason");

            RequestForLeave request = new RequestForLeave();
            request.setCreatedBy(user.getEmployee());
            request.setFrom(Date.valueOf(from));
            request.setTo(Date.valueOf(to));
            request.setReason(reason);
            request.setStatus(1); // 1 = In progress

            RequestDBContext db = new RequestDBContext();
            db.insert(request);

            req.setAttribute("message", "Leave request has been submitted successfully!");
        } catch (Exception e) {
            req.setAttribute("message", "Error submitting request: " + e.getMessage());
        }

        req.getRequestDispatcher("../view/auth/message.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        // Hiển thị form tạo đơn nghỉ phép
        req.getRequestDispatcher("../view/request/create.jsp").forward(req, resp);
    }

}
