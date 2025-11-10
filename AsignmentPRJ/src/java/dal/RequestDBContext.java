/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import model.Employee;
import model.RequestForLeave;

public class RequestDBContext extends DBContext<RequestForLeave> {

    private final EmployeeDBContext empDB = new EmployeeDBContext();
// Count total filtered requests (based on role)

    public int countRequestsForReport(int empId, boolean isManager, boolean isHead) {
        String sql;
        if (isHead) {
            sql = """
            SELECT COUNT(*)
            FROM RequestForLeave r
            JOIN Employee e ON r.created_by = e.eid
            WHERE e.did = (SELECT did FROM Employee WHERE eid = ?)
        """;
        } else if (isManager) {
            sql = """
            SELECT COUNT(*)
            FROM RequestForLeave r
            WHERE r.created_by = ?
               OR r.created_by IN (SELECT eid FROM Employee WHERE supervisorid = ?)
        """;
        } else {
            sql = "SELECT COUNT(*) FROM RequestForLeave WHERE created_by = ?";
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, empId);
            if (isManager) {
                stm.setInt(2, empId);
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

// Pagination request fetch
    public ArrayList<RequestForLeave> getRequestsForReport(int empId, boolean isManager, boolean isHead, int pageindex, int pagesize) {
        ArrayList<RequestForLeave> list = new ArrayList<>();
        String sql;

        if (isHead) {
            sql = """
            SELECT r.rid, r.created_by, r.created_time, r.[from], r.[to], r.reason, r.status,
                   r.processed_by, r.process_reason, r.processed_time
            FROM RequestForLeave r
            JOIN Employee e ON r.created_by = e.eid
            WHERE e.did = (SELECT did FROM Employee WHERE eid = ?)
            ORDER BY r.created_time DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;
        } else if (isManager) {
            sql = """
            SELECT r.rid, r.created_by, r.created_time, r.[from], r.[to], r.reason, r.status,
                   r.processed_by, r.process_reason, r.processed_time
            FROM RequestForLeave r
            WHERE r.created_by = ?
               OR r.created_by IN (SELECT eid FROM Employee WHERE supervisorid = ?)
            ORDER BY r.created_time DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;
        } else {
            sql = """
            SELECT r.rid, r.created_by, r.created_time, r.[from], r.[to], r.reason, r.status,
                   r.processed_by, r.process_reason, r.processed_time
            FROM RequestForLeave r
            WHERE r.created_by = ?
            ORDER BY r.created_time DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, empId);
            if (isManager) {
                stm.setInt(2, empId);
            }
            stm.setInt(isManager ? 3 : 2, (pageindex - 1) * pagesize);
            stm.setInt(isManager ? 4 : 3, pagesize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResult(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Count Employee Requests
    public int countRequestsOfEmployee(int empId) {
        String sql = "SELECT COUNT(*) FROM RequestForLeave WHERE created_by = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, empId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

// Pagination - Employee
    public ArrayList<RequestForLeave> getRequestsOfEmployee(int empId, int pageindex, int pagesize) {
        ArrayList<RequestForLeave> list = new ArrayList<>();
        String sql = """
        SELECT r.rid, r.created_by, r.created_time, r.[from], r.[to], r.reason, r.status,
               r.processed_by, r.process_reason, r.processed_time
        FROM RequestForLeave r
        WHERE r.created_by = ?
        ORDER BY r.created_time DESC
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, empId);
            stm.setInt(2, (pageindex - 1) * pagesize);
            stm.setInt(3, pagesize);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResult(rs));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public int countRequestsOfManager(int managerId) {
        String sql = """
        SELECT COUNT(*)
        FROM RequestForLeave r
        WHERE r.created_by = ? 
           OR r.created_by IN (SELECT eid FROM Employee WHERE supervisorid = ?)
    """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, managerId);
            stm.setInt(2, managerId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<RequestForLeave> getRequestsOfManager(int managerId, int pageindex, int pagesize) {
        ArrayList<RequestForLeave> list = new ArrayList<>();
        String sql = """
        SELECT r.rid, r.created_by, r.created_time, r.[from], r.[to], r.reason, r.status,
               r.processed_by, r.process_reason, r.processed_time
        FROM RequestForLeave r
        WHERE r.created_by = ? 
           OR r.created_by IN (SELECT eid FROM Employee WHERE supervisorid = ?)
        ORDER BY r.created_time DESC
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, managerId);
            stm.setInt(2, managerId);
            stm.setInt(3, (pageindex - 1) * pagesize);
            stm.setInt(4, pagesize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResult(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countRequestsOfDivision(int divisionId) {
        String sql = """
        SELECT COUNT(*)
        FROM RequestForLeave r
        JOIN Employee e ON r.created_by = e.eid
        WHERE e.did = ?
    """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, divisionId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<RequestForLeave> getRequestsOfDivision(int divisionId, int pageindex, int pagesize) {
        ArrayList<RequestForLeave> list = new ArrayList<>();
        String sql = """
        SELECT r.rid, r.created_by, r.created_time, r.[from], r.[to], r.reason, r.status,
               r.processed_by, r.process_reason, r.processed_time
        FROM RequestForLeave r
        JOIN Employee e ON r.created_by = e.eid
        WHERE e.did = ?
        ORDER BY r.created_time DESC
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, divisionId);
            stm.setInt(2, (pageindex - 1) * pagesize);
            stm.setInt(3, pagesize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResult(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Lấy tất cả request của một nhân viên
    public ArrayList<RequestForLeave> getRequestsOfEmployee(int empId) {
        ArrayList<RequestForLeave> list = new ArrayList<>();
        String sql = """
            SELECT r.rid, r.created_by, r.created_time, r.[from], r.[to], r.reason, r.status,
                   r.processed_by, r.process_reason, r.processed_time
            FROM RequestForLeave r
            WHERE r.created_by = ?
            ORDER BY r.created_time DESC
        """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, empId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResult(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Lấy tất cả request mà Manager có thể xem
    public ArrayList<RequestForLeave> getRequestsOfManager(int managerId) {
        ArrayList<RequestForLeave> list = new ArrayList<>();
        String sql = """
            SELECT r.rid, r.created_by, r.created_time, r.[from], r.[to], r.reason, r.status,
                   r.processed_by, r.process_reason, r.processed_time
            FROM RequestForLeave r
            WHERE r.created_by = ? OR r.created_by IN (
                SELECT eid FROM Employee WHERE supervisorid = ?
            )
            ORDER BY r.created_time DESC
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, managerId);
            stm.setInt(2, managerId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResult(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Lấy tất cả request trong division (Division Leader)
    public ArrayList<RequestForLeave> getRequestsOfDivision(int divisionId) {
        ArrayList<RequestForLeave> list = new ArrayList<>();
        String sql = """
            SELECT r.rid, r.created_by, r.created_time, r.[from], r.[to], r.reason, r.status,
                   r.processed_by, r.process_reason, r.processed_time
            FROM RequestForLeave r
            JOIN Employee e ON r.created_by = e.eid
            WHERE e.did = ?
            ORDER BY r.created_time DESC
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, divisionId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResult(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Duyệt đơn (Approve / Reject)
    public void processRequest(int requestId, int status, String reason, int processedBy) {
        String sql = """
            UPDATE RequestForLeave
            SET status = ?, 
                process_reason = ?, 
                processed_by = ?, 
                processed_time = GETDATE()
            WHERE rid = ?
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, status);
            stm.setString(2, reason);
            stm.setInt(3, processedBy);
            stm.setInt(4, requestId);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("processRequest error: " + e.getMessage());
        }
    }

    private boolean isDivisionLeader(Employee e) throws SQLException {
        String sql = """
        SELECT r.rname
                FROM UserRole er
                JOIN [Role] r ON er.rid = r.rid
                WHERE er.uid = ?
    """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, e.getId());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String role = rs.getString("rname");
                if (role != null && role.toLowerCase().contains("head")) {
                    return true; // ✅ Là Division Leader
                }
            }
        }
        return false;
    }

    private boolean isManager(int empId) throws SQLException {
        String sql = """
        SELECT r.rname
        FROM UserRole er
        JOIN [Role] r ON er.rid = r.rid
        WHERE er.uid = ?
    """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, empId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String role = rs.getString("rname");
                if (role != null && role.toLowerCase().contains("pm")) {
                    return true; // ✅ Có role chứa "PM" → là Manager
                }
            }
        }
        return false;
    }

    // ✅ Nhân viên chỉnh sửa đơn (chưa duyệt)
    public void updateRequest(int rid, String reason, String from, String to) {
        String sql = """
            UPDATE RequestForLeave
            SET reason = ?, [from] = ?, [to] = ?
            WHERE rid = ? AND status = 1
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, reason);
            stm.setDate(2, Date.valueOf(from));
            stm.setDate(3, Date.valueOf(to));
            stm.setInt(4, rid);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("updateRequest error: " + e.getMessage());
        }
    }

    // ✅ Helper map ResultSet -> Object
    private RequestForLeave mapResult(ResultSet rs) throws SQLException {
        RequestForLeave r = new RequestForLeave();
        r.setId(rs.getInt("rid"));
        r.setCreatedBy(empDB.get(rs.getInt("created_by")));
        r.setCreatedTime(rs.getTimestamp("created_time"));
        r.setFrom(rs.getDate("from"));
        r.setTo(rs.getDate("to"));
        r.setReason(rs.getString("reason"));
        r.setStatus(rs.getInt("status"));

        int pid = rs.getInt("processed_by");
        if (!rs.wasNull()) {
            r.setProcessedBy(empDB.get(pid));
        }

        r.setProcessReason(rs.getString("process_reason"));
        r.setProcessedTime(rs.getTimestamp("processed_time"));
        return r;
    }
    
    public void delete(int id) {
    String sql = "DELETE FROM RequestForLeave WHERE rid = ?";
    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setInt(1, id);
        stm.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

    // ✅ CRUD cơ bản
    @Override
    public ArrayList<RequestForLeave> list() {
        return new ArrayList<>();
    }

    @Override
    public RequestForLeave get(int id) {
        RequestForLeave r = null;
        String sql = "SELECT * FROM RequestForLeave WHERE rid = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                r = mapResult(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return r;
    }

    @Override
    public void insert(RequestForLeave model) {
        try {
            Employee creator = model.getCreatedBy();

            // Kiểm tra role
            boolean isLeader = isDivisionLeader(creator);  // Head / Leader
//            boolean isManager = isManager(creator.getId()); // PM / Manager

            int status = 1; // Pending mặc định
            if (isLeader) {
                status = 2; // ✅ Auto-Approved
            }

            String sql = """
            INSERT INTO RequestForLeave(created_by, created_time, [from], [to], reason, status)
            VALUES (?, GETDATE(), ?, ?, ?, ?)
        """;

            try (PreparedStatement stm = connection.prepareStatement(sql)) {
                stm.setInt(1, creator.getId());
                stm.setDate(2, model.getFrom());
                stm.setDate(3, model.getTo());
                stm.setString(4, model.getReason());
                stm.setInt(5, status);
                stm.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(RequestForLeave model) {
    }

    @Override
    public void delete(RequestForLeave model) {
        String sql = "DELETE FROM RequestForLeave WHERE rid = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, model.getId());
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
