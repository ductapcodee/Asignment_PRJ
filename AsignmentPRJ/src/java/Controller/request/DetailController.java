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

@WebServlet(urlPatterns = "/request/detail")
public class DetailController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        String rid = req.getParameter("rid");

        if (rid == null) {
            resp.sendRedirect(req.getContextPath() + "/request/agenda");
            return;
        }

        RequestDBContext db = new RequestDBContext();
        RequestForLeave request = db.get(Integer.parseInt(rid)); // nhớ hàm get(rid) phải có

        if (request == null) {
            req.setAttribute("error", "Không tìm thấy đơn nghỉ!");
            req.getRequestDispatcher("/view/request/detail.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("request", request);
        req.getRequestDispatcher("/view/request/detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
