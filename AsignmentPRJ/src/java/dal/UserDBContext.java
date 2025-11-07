/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.iam.User;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Division;
import model.Employee;
import model.iam.Role;

/**
 *
 * @author sonnt
 */
public class UserDBContext extends DBContext<User> {

    public User get(String username, String password) {
        try {
            String sql = """
            SELECT
                u.uid,
                u.username,
                u.password,
                u.displayname,
                u.login_fail_count,
                u.lock_until,
                e.eid,
                e.ename,
                e.supervisorid,
                d.did,
                d.dname,
                r.rid,
                r.rname,
                s.eid AS sid,
                s.ename AS sname
            FROM [User] u
            INNER JOIN [Enrollment] en ON u.[uid] = en.[uid]
            INNER JOIN [Employee] e ON e.eid = en.eid
            INNER JOIN [Division] d ON e.did = d.did
            LEFT JOIN [Employee] s ON e.supervisorid = s.eid
            LEFT JOIN [UserRole] ur ON u.uid = ur.uid
            LEFT JOIN [Role] r ON ur.rid = r.rid
            WHERE u.username = ? AND en.active = 1
        """;

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {

                Division d = new Division();
                d.setId(rs.getInt("did"));
                d.setDname(rs.getString("dname"));

                Employee supervisor = null;
                int sid = rs.getInt("sid");
                if (sid != 0) {
                    supervisor = new Employee();
                    supervisor.setId(sid);
                    supervisor.setName(rs.getString("sname"));
                }

                Employee e = new Employee();
                e.setId(rs.getInt("eid"));
                e.setName(rs.getString("ename"));
                e.setDivision(d);
                e.setSupervisor(supervisor);

                User u = new User();
                u.setId(rs.getInt("uid"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password")); // ✅ LẤY PASSWORD
                u.setDisplayname(rs.getString("displayname"));
                u.setLoginFailCount(rs.getInt("login_fail_count"));
                u.setLockUntil(rs.getTimestamp("lock_until"));
                u.setEmployee(e);
                u.setRoles(new ArrayList<>());

                int rid = rs.getInt("rid");
                if (rid != 0) {
                    Role r = new Role();
                    r.setRid(rid);
                    r.setRname(rs.getString("rname"));
                    u.getRoles().add(r);
                }

                return u;
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateFailCount(int uid, int count) {
        try {
            String sql = "UPDATE [User] SET login_fail_count = ? WHERE uid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, count);
            stm.setInt(2, uid);
            stm.executeUpdate();
        } catch (SQLException ex) {
        }
    }

    public void lockUser(int uid, Timestamp until) {
        try {
            String sql = "UPDATE [User] SET lock_until = ?, login_fail_count = 0 WHERE uid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setTimestamp(1, until);
            stm.setInt(2, uid);
            stm.executeUpdate();
        } catch (SQLException ex) {
        }
    }

    public void resetLoginState(int uid) {
        try {
            String sql = "UPDATE [User] SET login_fail_count = 0, lock_until = NULL WHERE uid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            stm.executeUpdate();
        } catch (SQLException ex) {
        }
    }

    public void saveOTP(int uid, String otp, Timestamp expire) {
        try {
            String sql = "UPDATE [User] SET otp = ?, otp_expire = ? WHERE uid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, otp);
            stm.setTimestamp(2, expire);
            stm.setInt(3, uid);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public User findByEmail(String email) {
        try {
            String sql = "SELECT * FROM [User] WHERE email = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("uid"));
                u.setEmail(rs.getString("email"));
                return u;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void updatePassword(int uid, String hashedPassword) {
        try {
            String sql = "UPDATE [User] SET password = ?, otp = NULL, otp_expire = NULL WHERE uid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, hashedPassword);
            stm.setInt(2, uid);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public Connection getConnection() {
        return connection; // connection là biến cha đã có sẵn
    }

    @Override
    public ArrayList<User> list() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public User get(int id) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void insert(User model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void update(User model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void delete(User model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
