package com.webbanbanh.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date; // Giữ lại nếu bạn cần sử dụng lớp Date

public class Cake {
    private int cakeID;
    private String cakeName;
    private int categoryID;
    private BigDecimal price; // Sử dụng BigDecimal cho tiền tệ
    private int quantity;
    private String imageURL;
    private String description;
    private Timestamp createdAt; // Thuộc tính kiểu Timestamp

    // 1. Constructor không tham số (Bắt buộc cho nhiều Framework)
    public Cake() {
    }

    // 2. Constructor đầy đủ tham số (ĐÃ SỬA LỖI: Tham số createdAt là Timestamp)
    public Cake(int cakeID, String cakeName, int categoryID, BigDecimal price, int quantity, String imageURL, String description, Timestamp createdAt) {
        this.cakeID = cakeID;
        this.cakeName = cakeName;
        this.categoryID = categoryID;
        this.price = price;
        this.quantity = quantity;
        this.imageURL = imageURL;
        this.description = description;
        this.createdAt = createdAt;
    }

    // 3. Getters và Setters
    public int getCakeID() {
        return cakeID;
    }

    public void setCakeID(int cakeID) {
        this.cakeID = cakeID;
    }

    public String getCakeName() {
        return cakeName;
    }

    public void setCakeName(String cakeName) {
        this.cakeName = cakeName;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedAt() { // Getter kiểu Timestamp
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) { // Setter kiểu Timestamp
        this.createdAt = createdAt;
    }
    
    // Nếu bạn cần chuyển đổi từ Timestamp sang Date (java.util.Date), bạn có thể thêm:
    /*
    public Date getCreatedAtAsDate() {
        return (Date) createdAt;
    }
    */
}