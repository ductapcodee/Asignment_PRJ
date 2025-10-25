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
import java.util.ArrayList;
import model.RequestForLeave;
import model.iam.User;

/**
 *
 * @author sonnt
 */
@WebServlet(urlPatterns = "/request/list")
public class ListController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        RequestDBContext db = new RequestDBContext();
        ArrayList<RequestForLeave> list;

        // Lấy role đầu tiên (đơn giản hoá)
        String roleName = user.getRoles().isEmpty() ? "" : user.getRoles().get(0).getRname();

        if (roleName.contains("Head")) {
            // Sếp lớn → xem toàn bộ
            list = db.getAllRequests();
        } else if (roleName.contains("PM")) {
            // Quản lý → xem cấp dưới + đơn của chính mình
            list = db.getSubordinateRequests(user.getEmployee().getId());
            list.addAll(db.getOwnRequests(user.getEmployee().getId()));
        } else {
            // Nhân viên bình thường → chỉ xem của mình
            list = db.getOwnRequests(user.getEmployee().getId());
        }

        req.setAttribute("requests", list);
        req.getRequestDispatcher("../view/request/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        // xử lý duyệt/từ chối ở đây (manager)
    }
}
