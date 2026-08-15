package com.webbanbanh.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Model ánh xạ bảng Orders:
 * - orderID INT (PK, identity)
 * - userID INT (FK -> Users.userID)
 * - orderDate DATETIME DEFAULT GETDATE()
 * - status NVARCHAR(50)
 * - totalAmount DECIMAL(18,0)
 * - address NVARCHAR(200)
 * - paymentMethod NVARCHAR(50)
 */
public class Order {

    private int orderID;
    private int userID;
    private LocalDateTime orderDate;       // Có thể để null nếu DB tự sinh
    private String status;                 // Ví dụ: "Chờ xác nhận"
    private BigDecimal totalAmount;        // DECIMAL(18,0) → BigDecimal
    private String address;
    private String paymentMethod;          // COD, Momo, Thẻ...

    // Danh sách chi tiết đơn hàng (không nằm trong bảng Orders, dùng để thao tác trong code)
    private List<OrderDetail> details = new ArrayList<>();

    public Order() {
    }

    public Order(int userID, String status, BigDecimal totalAmount, String address, String paymentMethod) {
        this.userID = userID;
        this.status = status;
        this.totalAmount = totalAmount;
        this.address = address;
        this.paymentMethod = paymentMethod;
    }

    // Getter / Setter
    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public List<OrderDetail> getDetails() {
        return details;
    }

    public void setDetails(List<OrderDetail> details) {
        this.details = details;
    }

    public void addDetail(OrderDetail detail) {
        if (this.details == null) {
            this.details = new ArrayList<>();
        }
        this.details.add(detail);
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderID=" + orderID +
                ", userID=" + userID +
                ", orderDate=" + orderDate +
                ", status='" + status + '\'' +
                ", totalAmount=" + totalAmount +
                ", address='" + address + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", details=" + (details != null ? details.size() : 0) +
                '}';
    }
}
