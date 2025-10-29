/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Model đại diện cho bảng RequestForLeave trong DB.
 * Mỗi đơn xin nghỉ bao gồm thông tin người tạo, người xử lý, thời gian, lý do và trạng thái.
 */
public class RequestForLeave extends BaseModel {
    
    private Employee createdBy;         // người tạo đơn
    private Timestamp createdTime;      // ✅ FIXED: datetime → Timestamp
    private Date from;                  // ngày bắt đầu nghỉ
    private Date to;                    // ngày kết thúc nghỉ
    private String reason;              // lý do xin nghỉ
    private int status;                 // 1: Pending, 2: Approved, 3: Rejected
    private Employee processedBy;       // người xử lý đơn
    private String processReason;       // lý do xử lý (Approve / Reject / ReProcess)
    private Timestamp processedTime;    // ✅ FIXED: datetime → Timestamp
    
    // ====== CONSTRUCTORS ======
    
    public RequestForLeave() {
        // Default constructor
    }
    
    // ====== GETTERS & SETTERS ======
    
    public Employee getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(Employee createdBy) {
        this.createdBy = createdBy;
    }
    
    public Timestamp getCreatedTime() {
        return createdTime;
    }
    
    public void setCreatedTime(Timestamp createdTime) {
        this.createdTime = createdTime;
    }
    
    // ✅ Overload để hỗ trợ java.util.Date
    public void setCreatedTime(java.util.Date date) {
        if (date != null) {
            this.createdTime = new Timestamp(date.getTime());
        }
    }
    
    public Date getFrom() {
        return from;
    }
    
    public void setFrom(Date from) {
        this.from = from;
    }
    
    public Date getTo() {
        return to;
    }
    
    public void setTo(Date to) {
        this.to = to;
    }
    
    public String getReason() {
        return reason;
    }
    
    public void setReason(String reason) {
        this.reason = reason;
    }
    
    public int getStatus() {
        return status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }
    
    public Employee getProcessedBy() {
        return processedBy;
    }
    
    public void setProcessedBy(Employee processedBy) {
        this.processedBy = processedBy;
    }
    
    public String getProcessReason() {
        return processReason;
    }
    
    public void setProcessReason(String processReason) {
        this.processReason = processReason;
    }
    
    public Timestamp getProcessedTime() {
        return processedTime;
    }
    
    public void setProcessedTime(Timestamp processedTime) {
        this.processedTime = processedTime;
    }
    
    // ✅ Overload để hỗ trợ java.util.Date
    public void setProcessedTime(java.util.Date date) {
        if (date != null) {
            this.processedTime = new Timestamp(date.getTime());
        }
    }
    
    // ✅ Overload để hỗ trợ java.sql.Date (compatibility)
    public void setProcessedTime(Date date) {
        if (date != null) {
            this.processedTime = new Timestamp(date.getTime());
        }
    }
    
    // ====== HELPER METHODS ======
    
    /**
     * Trả về mô tả trạng thái dễ đọc
     * @return 
     */
    public String getStatusText() {
        return switch (status) {
            case 1 -> "Pending";
            case 2 -> "Approved";
            case 3 -> "Rejected";
            default -> "Unknown";
        };
    }
    
    /**
     * Kiểm tra xem request đã được xử lý hay chưa
     * @return 
     */
    public boolean isProcessed() {
        return status == 2 || status == 3;
    }
    
    /**
     * Kiểm tra xem request có đang chờ xử lý không
     * @return 
     */
    public boolean isPending() {
        return status == 1;
    }
    
    /**
     * Kiểm tra xem request có thể được chỉnh sửa lại hay không
     * @return 
     */
    public boolean canReprocess() {
        return isProcessed(); // có thể reprocess nếu đã được xử lý
    }
    
    /**
     * Kiểm tra xem request có được approve không
     * @return 
     */
    public boolean isApproved() {
        return status == 2;
    }
    
    /**
     * Kiểm tra xem request có bị reject không
     * @return 
     */
    public boolean isRejected() {
        return status == 3;
    }
    
    /**
     * Format created time to readable string
     * @return 
     */
    public String getFormattedCreatedTime() {
        if (createdTime != null) {
            return new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(createdTime);
        }
        return "";
    }
    
    /**
     * Format processed time to readable string
     * @return 
     */
    public String getFormattedProcessedTime() {
        if (processedTime != null) {
            return new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(processedTime);
        }
        return "Not processed yet";
    }
    
    /**
     * Calculate number of days for leave
     * @return 
     */
    public long getLeaveDays() {
        if (from != null && to != null) {
            long diff = to.getTime() - from.getTime();
            return (diff / (1000 * 60 * 60 * 24)) + 1; // +1 to include both start and end date
        }
        return 0;
    }
    
    /**
     * Validate date range
     * @return 
     */
    public boolean isValidDateRange() {
        if (from == null || to == null) {
            return false;
        }
        return !to.before(from); // to must be >= from
    }
    
    @Override
    public String toString() {
        return "RequestForLeave{" +
                "id=" + getId() +
                ", createdBy=" + (createdBy != null ? createdBy.getName() : "null") +
                ", createdTime=" + getFormattedCreatedTime() +
                ", from=" + from +
                ", to=" + to +
                ", days=" + getLeaveDays() +
                ", status=" + getStatusText() +
                ", processedBy=" + (processedBy != null ? processedBy.getName() : "null") +
                ", processedTime=" + (processedTime != null ? getFormattedProcessedTime() : "null") +
                '}';
    }
}