/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.iam;

import dal.UserDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import model.iam.User;
import util.PasswordUtil;

/**
 *
 * @author sonnt
 */
@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserDBContext db = new UserDBContext();
        User u = db.get(username, password); // lấy user theo username

        if (u == null) {
            req.setAttribute("error", "Tài khoản không tồn tại.");
            req.getRequestDispatcher("view/auth/login.jsp").forward(req, resp);
            return;
        }

        // kiểm tra lock
        Timestamp lockUntil = u.getLockUntil();
        if (lockUntil != null && lockUntil.after(new Timestamp(System.currentTimeMillis()))) {
            long diff = (lockUntil.getTime() - System.currentTimeMillis()) / 1000;
            req.setAttribute("error", "Tài khoản bị khóa. Thử lại sau " + diff + " giây.");
            req.getRequestDispatcher("view/auth/login.jsp").forward(req, resp);
            return;
        }

// kiểm tra mật khẩu
        if (!PasswordUtil.verify(password, u.getPassword())) {
            int newFail = u.getLoginFailCount() + 1;
            if (newFail >= 5) {
                long lockTime = System.currentTimeMillis() + 2 * 60 * 1000;
                db.lockUser(u.getId(), new Timestamp(lockTime));
                req.setAttribute("error", "Sai 5 lần. Tài khoản đã bị khóa 2 phút.");
            } else {
                db.updateFailCount(u.getId(), newFail);
                req.setAttribute("error", "Sai mật khẩu. Lần sai: " + newFail);
            }

            req.getRequestDispatcher("view/auth/login.jsp").forward(req, resp);
            return;
        }

        // đăng nhập thành công
        db.resetLoginState(u.getId());
        req.getSession().setAttribute("auth", u);
        resp.sendRedirect("home");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("view/auth/login.jsp").forward(req, resp);
    }
}
