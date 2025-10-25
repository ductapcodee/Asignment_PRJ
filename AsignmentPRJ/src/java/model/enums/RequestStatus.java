/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.enums;

/**
 *
 * @author ADMIN
 */
public class RequestStatus {
    public static final int IN_PROGRESS = 1;
    public static final int APPROVED = 2;
    public static final int REJECTED = 3;

    public static String getName(int status) {
        return switch (status) {
            case IN_PROGRESS -> "In Progress";
            case APPROVED -> "Approved";
            case REJECTED -> "Rejected";
            default -> "Unknown";
        };
    }
}