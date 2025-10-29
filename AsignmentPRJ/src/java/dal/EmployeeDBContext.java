/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import model.Division;
import model.Employee;

/**
 *
 * @author ADMIN
 */
public class EmployeeDBContext extends DBContext<Employee> {

    /**
     * ✅ 1. Lấy thông tin nhân viên theo ID *
     */
    @Override
    public Employee get(int id) {
        String sql = """
        SELECT e.eid, e.ename, e.did, e.supervisorid,
               d.dname,
               s.eid AS sid, s.ename AS sname
        FROM Employee e
        LEFT JOIN Division d ON e.did = d.did
        LEFT JOIN Employee s ON e.supervisorid = s.eid
        WHERE e.eid = ?
    """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("eid"));
                e.setName(rs.getString("ename"));

                Division d = new Division();
                d.setId(rs.getInt("did"));
                d.setDname(rs.getString("dname"));
                e.setDivision(d);

                // ✅ Gán supervisor đầy đủ (có ID và tên)
                int supId = rs.getInt("supervisorid");
                if (!rs.wasNull()) {
                    Employee sup = new Employee();
                    sup.setId(rs.getInt("sid"));
                    sup.setName(rs.getString("sname"));
                    e.setSupervisor(sup);
                }

                return e;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    /**
     * ✅ 2. Lấy toàn bộ danh sách nhân viên *
     */
    @Override
    public ArrayList<Employee> list() {
        ArrayList<Employee> list = new ArrayList<>();
        String sql = """
            SELECT e.eid, e.ename, e.did, e.supervisorid, d.dname
            FROM Employee e
            LEFT JOIN Division d ON e.did = d.did
            ORDER BY e.ename
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("eid"));
                e.setName(rs.getString("ename"));

                Division d = new Division();
                d.setId(rs.getInt("did"));
                d.setDname(rs.getString("dname"));
                e.setDivision(d);

                int supervisorId = rs.getInt("supervisorid");
                if (supervisorId != 0) {
                    Employee supervisor = new Employee();
                    supervisor.setId(supervisorId);
                    e.setSupervisor(supervisor);
                }

                list.add(e);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeConnection();
        }
        return list;
    }

    /**
     * ✅ 3. Lấy danh sách nhân viên dưới quyền của 1 người (Manager/PM) *
     */
    public ArrayList<Employee> getSubordinates(int supervisorId) {
        ArrayList<Employee> list = new ArrayList<>();
        String sql = """
            SELECT e.eid, e.ename, e.did, d.dname
            FROM Employee e
            JOIN Division d ON e.did = d.did
            WHERE e.supervisorid = ?
            ORDER BY e.ename
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, supervisorId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("eid"));
                e.setName(rs.getString("ename"));

                Division d = new Division();
                d.setId(rs.getInt("did"));
                d.setDname(rs.getString("dname"));
                e.setDivision(d);

                list.add(e);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeConnection();
        }
        return list;
    }

    /**
     * ✅ 4. Thêm nhân viên mới *
     */
    @Override
    public void insert(Employee model) {
        String sql = """
            INSERT INTO Employee(ename, did, supervisorid)
            VALUES (?, ?, ?)
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, model.getName());
            stm.setInt(2, model.getDivision().getId());
            if (model.getSupervisor() != null) {
                stm.setInt(3, model.getSupervisor().getId());
            } else {
                stm.setNull(3, java.sql.Types.INTEGER);
            }
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeConnection();
        }
    }

    /**
     * ✅ 5. Cập nhật thông tin nhân viên *
     */
    @Override
    public void update(Employee model) {
        String sql = """
            UPDATE Employee
            SET ename = ?, did = ?, supervisorid = ?
            WHERE eid = ?
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, model.getName());
            stm.setInt(2, model.getDivision().getId());
            if (model.getSupervisor() != null) {
                stm.setInt(3, model.getSupervisor().getId());
            } else {
                stm.setNull(3, java.sql.Types.INTEGER);
            }
            stm.setInt(4, model.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeConnection();
        }
    }

    /**
     * ✅ 6. Xóa nhân viên *
     */
    @Override
    public void delete(Employee model) {
        String sql = "DELETE FROM Employee WHERE eid = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, model.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeConnection();
        }
    }
}
