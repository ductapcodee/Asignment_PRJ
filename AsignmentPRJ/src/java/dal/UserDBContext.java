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
                u.displayname,
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
            WHERE
                u.username = ? AND u.password = ? AND en.active = 1
        """;

        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, username);
        stm.setString(2, password);
        ResultSet rs = stm.executeQuery();

        if (rs.next()) {
            // Division
            Division d = new Division();
            d.setId(rs.getInt("did"));
            d.setDname(rs.getString("dname"));

            // Supervisor (nếu có)
            Employee supervisor = null;
            int sid = rs.getInt("sid");
            if (sid != 0) {
                supervisor = new Employee();
                supervisor.setId(sid);
                supervisor.setName(rs.getString("sname"));
            }

            // Employee
            Employee e = new Employee();
            e.setId(rs.getInt("eid"));
            e.setName(rs.getString("ename"));
            e.setDivision(d);
            e.setSupervisor(supervisor);

            // User
            User u = new User();
            u.setId(rs.getInt("uid"));
            u.setUsername(rs.getString("username"));
            u.setDisplayname(rs.getString("displayname"));
            u.setEmployee(e);
            u.setRoles(new ArrayList<>());

            // Role
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
    } finally {
        closeConnection();
    }
    return null;
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
