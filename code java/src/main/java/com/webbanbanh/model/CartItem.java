package com.webbanbanh.model;

import java.math.BigDecimal;

public class CartItem {

    private Cake cake;
    private int quantity;

    public CartItem(Cake cake, int quantity) {
        this.cake = cake;
        this.quantity = quantity;
    }

    public Cake getCake() {
        return cake;
    }

    public void setCake(Cake cake) {
        this.cake = cake;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Tổng tiền của 1 item
    public BigDecimal getTotalPrice() {
        if (cake == null || cake.getPrice() == null) return BigDecimal.ZERO;

        return cake.getPrice().multiply(BigDecimal.valueOf(quantity));
    }
}
