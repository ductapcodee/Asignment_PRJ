/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author sonnt
 */
public class Employee extends BaseModel {

    private String name;
    private Division division; // Mối quan hệ 1-nhiều: 1 Division có nhiều Employee
    private Employee supervisor; // Trưởng bộ phận (nếu có)

    public Employee() {
    }

    public Employee(int id, String name) {
        this.setId(id); // ✅ Gọi setter để gán id
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Division getDivision() {
        return division;
    }

    public void setDivision(Division division) {
        this.division = division;
    }

    public Employee getSupervisor() {
        return supervisor;
    }

    public void setSupervisor(Employee supervisor) {
        this.supervisor = supervisor;
    }
    }
