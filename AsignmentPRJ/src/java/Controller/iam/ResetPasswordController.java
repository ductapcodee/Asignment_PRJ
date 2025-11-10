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
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import util.PasswordUtil;

@WebServlet(urlPatterns = "/reset")
public class ResetPasswordController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");
        String newpass = req.getParameter("password");

        UserDBContext db = new UserDBContext();
        var user = db.findByEmail(email);

        if (user == null) {
            req.setAttribute("error", "Email không tồn tại.");
            req.getRequestDispatcher("view/auth/reset.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra OTP
        String sql = "SELECT otp, otp_expire FROM [User] WHERE uid = ?";
        PreparedStatement stm = null;
        try {
            stm = db.getConnection().prepareStatement(sql);
            stm.setInt(1, user.getId());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
            String dbOtp = rs.getString("otp");
            Timestamp exp = rs.getTimestamp("otp_expire");

            // Kiểm tra OTP sai hoặc hết hạn
            if (!otp.equals(dbOtp) || exp.before(new Timestamp(System.currentTimeMillis()))) {
                req.setAttribute("error", "OTP sai hoặc đã hết hạn.");
                req.setAttribute("email", email);
                req.getRequestDispatcher("view/auth/reset.jsp").forward(req, resp);
                return;
            }
        }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi hệ thống. Vui lòng thử lại.");
            req.getRequestDispatcher("view/auth/reset.jsp").forward(req, resp);
            return;
        }
        db.updatePassword(user.getId(), PasswordUtil.hash(newpass));
        resp.sendRedirect("login?success=1");
    }
}
