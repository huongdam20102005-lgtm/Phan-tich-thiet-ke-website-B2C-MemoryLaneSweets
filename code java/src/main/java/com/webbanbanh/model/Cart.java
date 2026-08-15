package com.webbanbanh.model;

import java.util.HashMap;
import java.util.Map;
import java.math.BigDecimal;

public class Cart {

    private Map<Integer, CartItem> items;

    public Cart() {
        this.items = new HashMap<>();
    }

    // Thêm sản phẩm vào giỏ
    public void add(CartItem item) {
        if (item == null || item.getCake() == null) return;

        int cakeID = item.getCake().getCakeID();

        if (items.containsKey(cakeID)) {
            CartItem existingItem = items.get(cakeID);
            existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
        } else {
            items.put(cakeID, item);
        }
    }

    // Xóa sản phẩm
    public void removeItem(int cakeID) {
        items.remove(cakeID);
    }

    // Tổng tiền (đúng chuẩn BigDecimal)
    public BigDecimal getTotalMoney() {
        BigDecimal total = BigDecimal.ZERO;

        for (CartItem item : items.values()) {
            total = total.add(item.getTotalPrice());
        }

        return total;
    }

    // **Thêm phương thức này để JSP đọc được totalPrice**
    public BigDecimal getTotalPrice() {
        return getTotalMoney();
    }

    // Tổng số lượng
    public int getTotalQuantity() {
        int total = 0;

        for (CartItem item : items.values()) {
            total += item.getQuantity();
        }

        return total;
    }

    // Getter / Setter
    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void setItems(Map<Integer, CartItem> items) {
        if (items == null) {
            this.items = new HashMap<>();
        } else {
            this.items = items;
        }
    }
    // Thêm vào cuối class Cart
    public void clear() {
        items.clear(); // Xóa toàn bộ sản phẩm trong giỏ
    }

}
