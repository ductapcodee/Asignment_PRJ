/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.iam;

/**
 *
 * @author ADMIN
 */

import dal.UserDBContext;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.MailUtil;

@WebServlet(urlPatterns = "/forgot")
public class ForgotController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.getRequestDispatcher("view/auth/forgot.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        try {
            String email = req.getParameter("email").trim();
            
            UserDBContext db = new UserDBContext();
            var user = db.findByEmail(email);
            
            if (user == null) {
                req.setAttribute("error", "Email không tồn tại.");
                req.getRequestDispatcher("view/auth/forgot.jsp").forward(req, resp);
                return;
            }
            
            String otp = String.valueOf(new Random().nextInt(900000) + 100000);
            Timestamp expire = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000);
            
            db.saveOTP(user.getId(), otp, expire);
            
            MailUtil.sendEmail(email, "OTP Reset Password", "Mã OTP của bạn là: " + otp);
            
            req.setAttribute("email", email);
            req.getRequestDispatcher("view/auth/reset.jsp").forward(req, resp);
        } catch (MessagingException ex) {
            Logger.getLogger(ForgotController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

