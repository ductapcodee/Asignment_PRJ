/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import model.RequestForLeave;

public class RequestDBContext extends DBContext<RequestForLeave> {

    @Override
    public void insert(RequestForLeave model) {
        String sql = """
            INSERT INTO RequestForLeave(created_by, created_time, [from], [to], reason, status)
            VALUES (?, GETDATE(), ?, ?, ?, ?)
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, model.getCreatedBy());
            stm.setDate(2, model.getFromDate());
            stm.setDate(3, model.getToDate());
            stm.setString(4, model.getReason());
            stm.setInt(5, model.getStatus());
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
    }

    /**
     * ✅ 1. Lấy danh sách đơn của chính user đang đăng nhập *
     */
    public ArrayList<RequestForLeave> getOwnRequests(int empId) {
        ArrayList<RequestForLeave> list = new ArrayList<>();
        String sql = """
        SELECT r.rid, r.created_time, r.[from], r.[to], r.reason, r.status, r.created_by, e.ename
        FROM RequestForLeave r
        JOIN Employee e ON r.created_by = e.eid
        WHERE r.created_by = ?
        ORDER BY r.created_time DESC
    """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, empId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                RequestForLeave r = new RequestForLeave();
                r.setId(rs.getInt("rid"));
                r.setCreatedTime(rs.getDate("created_time"));
                r.setFromDate(rs.getDate("from"));
                r.setToDate(rs.getDate("to"));
                r.setReason(rs.getString("reason"));
                r.setStatus(rs.getInt("status"));
                r.setCreatedBy(rs.getInt("created_by"));
                r.setEmployeeName(rs.getString("ename")); // ✅ thêm dòng này
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // ❗ để in lỗi nếu SQL sai
        }

        return list;
    }

    /**
     * ✅ 2. Lấy danh sách đơn của cấp dưới (dành cho Manager) *
     */
    public ArrayList<RequestForLeave> getSubordinateRequests(int supervisorId) {
        ArrayList<RequestForLeave> list = new ArrayList<>();
        String sql = """
        SELECT r.rid, e.eid, e.ename, r.created_time, r.[from], r.[to], r.reason, r.status
        FROM RequestForLeave r
        INNER JOIN Employee e ON r.created_by = e.eid
        WHERE e.supervisorid = ?
        ORDER BY r.created_time DESC
    """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, supervisorId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                RequestForLeave r = new RequestForLeave();
                r.setId(rs.getInt("rid"));
                r.setCreatedBy(rs.getInt("eid"));
                r.setReason(rs.getString("reason"));
                r.setEmployeeName(rs.getString("ename"));
                r.setStatus(rs.getInt("status"));
                r.setCreatedTime(rs.getDate("created_time"));
                r.setFromDate(rs.getDate("from"));
                r.setToDate(rs.getDate("to"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * ✅ 3. Lấy toàn bộ đơn (cho Division Head / Admin) *
     */
    public ArrayList<RequestForLeave> getAllRequests() {
        ArrayList<RequestForLeave> list = new ArrayList<>();
        String sql = """
            SELECT r.rid, e.ename, r.created_time, r.[from], r.[to], r.reason, r.status
            FROM RequestForLeave r
            JOIN Employee e ON r.created_by = e.eid
            ORDER BY r.created_time DESC
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                RequestForLeave r = new RequestForLeave();
                r.setId(rs.getInt("rid"));
                r.setEmployeeName(rs.getString("ename"));
                r.setCreatedTime(rs.getDate("created_time"));
                r.setFromDate(rs.getDate("from"));
                r.setToDate(rs.getDate("to"));
                r.setReason(rs.getString("reason"));
                r.setStatus(rs.getInt("status"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * ✅ 4. Cập nhật trạng thái đơn (approve/reject) *
     */
    public void updateStatus(int requestId, int status, String reason) {
        String sql = "UPDATE RequestForLeave SET status = ?, reason = ? WHERE rid = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, status);
            stm.setString(2, reason);
            stm.setInt(3, requestId);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
    }

    @Override
    public ArrayList<RequestForLeave> list() {
        return null;
    }

    @Override
    public RequestForLeave get(int id) {
        return null;
    }

    @Override
    public void update(RequestForLeave model) {
    }

    @Override
    public void delete(RequestForLeave model) {
    }
}
