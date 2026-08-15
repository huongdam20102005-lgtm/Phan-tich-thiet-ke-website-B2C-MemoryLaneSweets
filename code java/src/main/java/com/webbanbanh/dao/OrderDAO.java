package com.webbanbanh.dao;

import com.webbanbanh.model.Order;
import com.webbanbanh.model.OrderDetail;
import com.webbanbanh.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * DAO cho bảng Orders và OrderDetails
 */
public class OrderDAO {

    /**
     * Lưu đơn hàng và chi tiết đơn hàng vào DB
     * @param order đối tượng Order chứa thông tin đơn hàng và danh sách chi tiết
     * @return orderID vừa được sinh ra
     * @throws SQLException nếu có lỗi SQL
     */
    public int saveOrder(Order order) throws SQLException {
        int orderID = 0;

        // Kết nối DB
        try (Connection conn = DBUtils.getConnection()) {

            // Lưu vào bảng Orders
            String sql = "INSERT INTO Orders(userID, status, totalAmount, address, paymentMethod) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                // Nếu không có user đăng nhập → set NULL
                if (order.getUserID() == 0) {
                    ps.setNull(1, java.sql.Types.INTEGER);
                } else {
                    ps.setInt(1, order.getUserID());
                }

                ps.setString(2, order.getStatus());
                ps.setBigDecimal(3, order.getTotalAmount());
                ps.setString(4, order.getAddress());
                ps.setString(5, order.getPaymentMethod());
                ps.executeUpdate();

                // Lấy orderID vừa insert
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderID = rs.getInt(1);
                    }
                }
            }

            // Lưu chi tiết sản phẩm vào OrderDetails
            String sqlDetail = "INSERT INTO OrderDetails(orderID, cakeID, quantity, unitPrice) VALUES (?, ?, ?, ?)";
            try (PreparedStatement psDetail = conn.prepareStatement(sqlDetail)) {
                for (OrderDetail detail : order.getDetails()) {
                    psDetail.setInt(1, orderID);
                    psDetail.setInt(2, detail.getCakeID());
                    psDetail.setInt(3, detail.getQuantity());
                    psDetail.setBigDecimal(4, detail.getUnitPrice());
                    psDetail.executeUpdate();
                }
            }
        }

        return orderID;
    }
}
