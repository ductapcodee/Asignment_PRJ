/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.request;



import Controller.iam.BaseRequiredAuthenticationController;
import dal.EmployeeDBContext;
import dal.RequestDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import model.Employee;
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

        RequestDBContext requestDB = new RequestDBContext();
        EmployeeDBContext empDB = new EmployeeDBContext();

        int empId = user.getEmployee().getId();
        Employee current = empDB.get(empId);
        String role = user.getPrimaryRoleName();

        // ✅ Phân trang
        int pagesize = 7;  // số đơn mỗi trang (bạn có thể chỉnh)
        String page = req.getParameter("page");
        int pageindex = (page == null) ? 1 : Integer.parseInt(page);

        ArrayList<RequestForLeave> list = new ArrayList<>();
        int count = 0;

        System.out.println(">>> Role: " + role + ", EmpID: " + empId);

        if (role.contains("Employee")) {
            list = requestDB.getRequestsOfEmployee(empId, pageindex, pagesize);
            count = requestDB.countRequestsOfEmployee(empId);
        } 
        else if (role.contains("PM")) {
            list = requestDB.getRequestsOfManager(empId, pageindex, pagesize);
            count = requestDB.countRequestsOfManager(empId);
        } 
        else if (role.contains("Head") || current.getSupervisor() == null) {
            if (current.getDivision() != null) {
                list = requestDB.getRequestsOfDivision(current.getDivision().getId(), pageindex, pagesize);
                count = requestDB.countRequestsOfDivision(current.getDivision().getId());
            }
        }

        int totalpage = (count % pagesize == 0) ? count / pagesize : (count / pagesize) + 1;

        System.out.println(">>> Page " + pageindex + "/" + totalpage + ", Found requests: " + list.size());

        req.setAttribute("requests", list);
        req.setAttribute("pageindex", pageindex);
        req.setAttribute("totalpage", totalpage);
        req.setAttribute("currentUser", current);
        req.setAttribute("roleName", role);

        req.getRequestDispatcher("/view/request/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        resp.sendRedirect("list");
    }
}
