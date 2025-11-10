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
import model.RequestForLeave;
import model.iam.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(urlPatterns = "/request/delete")
public class DeleteController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(req.getParameter("id"));
        RequestDBContext db = new RequestDBContext();
        RequestForLeave r = db.get(id);

        if (r != null && r.getCreatedBy().getId() == user.getEmployee().getId() && r.getStatus() == 1) {
            db.delete(id);
            req.getSession().setAttribute("success", "Xóa đơn thành công!");
        } else {
            req.getSession().setAttribute("error", "Không thể xóa đơn này!");
        }

        resp.sendRedirect(req.getContextPath() + "/request/list");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}

