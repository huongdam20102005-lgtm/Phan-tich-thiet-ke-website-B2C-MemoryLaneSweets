package com.webbanbanh.model;

import java.math.BigDecimal;

/**
 * Model ánh xạ bảng OrderDetails:
 * - orderDetailID INT (PK, identity)
 * - orderID INT (FK -> Orders.orderID)
 * - cakeID INT (FK -> Cakes.cakeID)
 * - quantity INT
 * - unitPrice DECIMAL(18,0) (giá tại thời điểm mua)
 */
public class OrderDetail {

    private int orderDetailID;
    private int orderID;          // Sẽ được set sau khi insert Orders để lấy orderID
    private int cakeID;
    private int quantity;
    private BigDecimal unitPrice;

    public OrderDetail() {
    }

    public OrderDetail(int cakeID, int quantity, BigDecimal unitPrice) {
        this.cakeID = cakeID;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    // Getter / Setter
    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCakeID() {
        return cakeID;
    }

    public void setCakeID(int cakeID) {
        this.cakeID = cakeID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "orderDetailID=" + orderDetailID +
                ", orderID=" + orderID +
                ", cakeID=" + cakeID +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                '}';
    }
}
