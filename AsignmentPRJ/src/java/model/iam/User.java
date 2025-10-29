/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.iam;

import java.util.ArrayList;
import java.util.List;
import model.BaseModel;
import model.Employee;

public class User extends BaseModel {
    private String username;
    private String password;
    private Employee employee;
    private String displayname;
    private ArrayList<Role> roles = new ArrayList<>();
    private ArrayList<Feature> features = new ArrayList<>();

    // Getter & Setter
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Employee getEmployee() { return employee; }
    public void setEmployee(Employee employee) { this.employee = employee; }

    public String getDisplayname() {
        return displayname;
    }

    public void setDisplayname(String displayname) {
        this.displayname = displayname;
    }

    public ArrayList<Role> getRoles() { return roles; }
    public void setRoles(ArrayList<Role> roles) { this.roles = roles; }

    public ArrayList<Feature> getFeatures() { return features; }
    public void setFeatures(ArrayList<Feature> features) { this.features = features; }

    // ✅ Kiểm tra quyền truy cập Feature (URL)
    public boolean hasFeature(String featureUrl) {
        if (features == null || features.isEmpty()) return false;
        for (Feature f : features) {
            if (f.getUrl().equalsIgnoreCase(featureUrl)) {
                return true;
            }
        }
        return false;
    }

    // ✅ Lấy tên role chính (role đầu tiên)
    public String getPrimaryRoleName() {
        if (roles == null || roles.isEmpty()) return "Unknown";
        return roles.get(0).getRname();
    }

    // ✅ Lấy danh sách tên các role (nếu cần)
    public List<String> getRoleNames() {
        List<String> names = new ArrayList<>();
        for (Role r : roles) names.add(r.getRname());
        return names;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + getId() + ", username=" + username + ", role=" + getPrimaryRoleName() + "}";
    }
}
