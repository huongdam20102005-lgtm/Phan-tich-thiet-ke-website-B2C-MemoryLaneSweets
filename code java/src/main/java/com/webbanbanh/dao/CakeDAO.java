package com.webbanbanh.dao;

import com.webbanbanh.model.Cake;
import com.webbanbanh.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CakeDAO {

    private static final Logger LOGGER = Logger.getLogger(CakeDAO.class.getName());

    // --- CÁC TRUY VẤN SQL CHUNG ---

    private static final String GET_NEW_CAKES =
            "SELECT TOP 6 cakeID, cakeName, categoryID, price, quantity, imageURL, description, createdAt " +
            "FROM Cakes " +
            "WHERE quantity > 0 " +
            "ORDER BY createdAt DESC";

    private static final String GET_BEST_SELLERS =
            "SELECT TOP 3 c.cakeID, c.cakeName, c.categoryID, c.price, c.quantity, c.imageURL, c.description, c.createdAt, SUM(od.quantity) AS TotalSold " +
            "FROM Cakes c " +
            "JOIN OrderDetails od ON c.cakeID = od.cakeID " +
            "WHERE c.quantity > 0 " +
            "GROUP BY c.cakeID, c.cakeName, c.categoryID, c.price, c.quantity, c.imageURL, c.description, c.createdAt " +
            "ORDER BY TotalSold DESC";

    private static final String GET_CAKES_BY_CATEGORY_NAME =
            "SELECT c.cakeID, c.cakeName, c.categoryID, c.price, c.quantity, c.imageURL, c.description, c.createdAt " +
            "FROM Cakes c " +
            "JOIN CakeCategories cc ON c.categoryID = cc.categoryID " +
            "WHERE cc.categoryName = ? AND c.quantity > 0";

    private static final String GET_CAKE_BY_ID =
            "SELECT cakeID, cakeName, categoryID, price, quantity, imageURL, description, createdAt " +
            "FROM Cakes " +
            "WHERE cakeID = ? AND quantity > 0";

    private static final String GET_RELATED_CAKES =
            "SELECT TOP 4 cakeID, cakeName, categoryID, price, quantity, imageURL, description, createdAt " +
            "FROM Cakes " +
            "WHERE categoryID = ? AND quantity > 0 AND cakeID != ?";

    private static final String GET_CATEGORY_NAME = "SELECT categoryName FROM CakeCategories WHERE categoryID = ?";

    private static final String GET_CAKES_BY_SEARCH =
            "SELECT cakeID, cakeName, categoryID, price, quantity, imageURL, description, createdAt " +
            "FROM Cakes " +
            "WHERE cakeName LIKE ? AND quantity > 0";

    private static final String GET_CAKES_BY_CATEGORY_AND_PRICE =
            "SELECT c.cakeID, c.cakeName, c.categoryID, c.price, c.quantity, c.imageURL, c.description, c.createdAt " +
            "FROM Cakes c JOIN CakeCategories cc ON c.categoryID = cc.categoryID " +
            "WHERE cc.categoryName = ? AND c.price BETWEEN ? AND ? AND c.quantity > 0";

    private static final String GET_CAKES_BY_CATEGORYID_AND_PRICE =
            "SELECT cakeID, cakeName, categoryID, price, quantity, imageURL, description, createdAt " +
            "FROM Cakes " +
            "WHERE categoryID = ? AND price BETWEEN ? AND ? AND quantity > 0";
    
    // --- TRUY VẤN MỚI: CẬP NHẬT SỐ LƯỢNG TỒN KHO ---
    private static final String UPDATE_CAKE_QUANTITY = 
            "UPDATE Cakes SET quantity = quantity - ? WHERE cakeID = ?"; 


    private Cake extractCakeFromResultSet(ResultSet rs) throws SQLException {
        Cake cake = new Cake();
        cake.setCakeID(rs.getInt("cakeID"));
        cake.setCakeName(rs.getString("cakeName"));
        cake.setCategoryID(rs.getInt("categoryID"));
        cake.setPrice(rs.getBigDecimal("price"));
        cake.setQuantity(rs.getInt("quantity"));
        cake.setImageURL(rs.getString("imageURL"));
        cake.setDescription(rs.getString("description"));
        cake.setCreatedAt(rs.getTimestamp("createdAt"));
        return cake;
    }

    public List<Cake> getNewCakes() throws Exception {
        List<Cake> listCakes = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(GET_NEW_CAKES);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                listCakes.add(extractCakeFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy bánh mới.", e);
            throw new Exception("Lỗi truy vấn cơ sở dữ liệu khi lấy bánh mới.", e);
        }
        return listCakes;
    }

    public List<Cake> getBestSellers() throws Exception {
        List<Cake> listCakes = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(GET_BEST_SELLERS);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                listCakes.add(extractCakeFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy bánh bán chạy.", e);
            throw new Exception("Lỗi truy vấn cơ sở dữ liệu khi lấy bánh bán chạy.", e);
        }
        return listCakes;
    }

    public List<Cake> getCakesByCategoryName(String categoryName) throws Exception {
        if (categoryName == null || categoryName.trim().isEmpty()) {
            return new ArrayList<>();
        }

        List<Cake> cakeList = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(GET_CAKES_BY_CATEGORY_NAME)) {

            ps.setString(1, categoryName);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cakeList.add(extractCakeFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy bánh theo danh mục: " + categoryName, e);
            throw new Exception("Lỗi truy vấn cơ sở dữ liệu khi lấy bánh theo danh mục.", e);
        }
        return cakeList;
    }

    /**
     * Lấy danh sách bánh theo tên danh mục và khoảng giá.
     * @param categoryName Tên danh mục.
     * @param minPrice Giá tối thiểu.
     * @param maxPrice Giá tối đa.
     * @return Danh sách bánh phù hợp.
     */
    public List<Cake> getCakesByCategoryNameAndPrice(String categoryName, BigDecimal minPrice, BigDecimal maxPrice) throws Exception {
        if (categoryName == null || categoryName.trim().isEmpty()) {
            return new ArrayList<>();
        }

        // Đảm bảo maxPrice là giá trị lớn nếu truyền vào giá trị âm (ví dụ: signal "max")
        if (maxPrice.compareTo(BigDecimal.ZERO) < 0) {
            maxPrice = new BigDecimal("1000000000"); // Giá trị lớn mặc định
        }

        List<Cake> cakeList = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(GET_CAKES_BY_CATEGORY_AND_PRICE)) {

            ps.setString(1, categoryName);
            ps.setBigDecimal(2, minPrice);
            ps.setBigDecimal(3, maxPrice);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cakeList.add(extractCakeFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy bánh theo danh mục và giá: " + categoryName, e);
            throw new Exception("Lỗi truy vấn cơ sở dữ liệu khi lấy bánh theo danh mục và giá.", e);
        }
        return cakeList;
    }


    public Cake getCakeByID(int cakeId) throws Exception {
        if (cakeId <= 0) {
            return null;
        }

        Cake cake = null;

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(GET_CAKE_BY_ID)) {

            ps.setInt(1, cakeId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cake = extractCakeFromResultSet(rs);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy chi tiết bánh ID: " + cakeId, e);
            throw new Exception("Lỗi truy vấn cơ sở dữ liệu khi lấy chi tiết bánh.", e);
        }
        return cake;
    }

    public List<Cake> getCakesByCategoryId(int categoryId, int excludeCakeId) throws Exception {
        if (categoryId <= 0) {
            return new ArrayList<>();
        }

        List<Cake> cakeList = new ArrayList<>();

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(GET_RELATED_CAKES)) {

            ps.setInt(1, categoryId);
            ps.setInt(2, excludeCakeId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cakeList.add(extractCakeFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy sản phẩm liên quan (CatID: " + categoryId + ")", e);
            throw new Exception("Lỗi truy vấn cơ sở dữ liệu khi lấy sản phẩm liên quan.", e);
        }
        return cakeList;
    }

    public List<Cake> getCakesByCategoryId(int categoryId) throws Exception {
        return getCakesByCategoryId(categoryId, 0);
    }

    public String getCategoryNameById(int categoryId) throws Exception {
        if (categoryId <= 0) {
            return "Không xác định";
        }

        String categoryName = null;
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(GET_CATEGORY_NAME)) {

            ps.setInt(1, categoryId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    categoryName = rs.getString("categoryName");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy tên danh mục ID: " + categoryId, e);
            throw new Exception("Lỗi truy vấn cơ sở dữ liệu khi lấy tên danh mục.", e);
        }
        return categoryName;
    }

    public List<Cake> searchCakesByName(String searchKeyword) throws Exception {
        if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
            return new ArrayList<>();
        }

        List<Cake> cakeList = new ArrayList<>();

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(GET_CAKES_BY_SEARCH)) {

            String keywordParam = "%" + searchKeyword.trim() + "%";
            ps.setString(1, keywordParam);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cakeList.add(extractCakeFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm kiếm bánh theo từ khóa: " + searchKeyword, e);
            throw new Exception("Lỗi truy vấn cơ sở dữ liệu khi tìm kiếm bánh.", e);
        }
        return cakeList;
    }

    /**
     * Lấy danh sách bánh theo ID danh mục và khoảng giá.
     */
    public List<Cake> getCakesByCategoryIdAndPrice(int categoryId, BigDecimal minPrice, BigDecimal maxPrice) throws Exception {
        if (categoryId <= 0) {
            return new ArrayList<>();
        }
        if (maxPrice.compareTo(BigDecimal.ZERO) < 0) {
            maxPrice = new BigDecimal("1000000000");
        }

        List<Cake> cakeList = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(GET_CAKES_BY_CATEGORYID_AND_PRICE)) {
            ps.setInt(1, categoryId);
            ps.setBigDecimal(2, minPrice);
            ps.setBigDecimal(3, maxPrice);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cakeList.add(extractCakeFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy bánh theo categoryID và giá: " + categoryId, e);
            throw new Exception("Lỗi truy vấn cơ sở dữ liệu khi lấy bánh theo categoryID và giá.", e);
        }
        return cakeList;
    }
    
    // ----------------------------------------------------------------------------------
    // PHƯƠNG THỨC MỚI: CẬP NHẬT SỐ LƯỢNG TỒN KHO SAU KHI ĐẶT HÀNG
    // ----------------------------------------------------------------------------------

    /**
     * Trừ số lượng tồn kho của một sản phẩm sau khi có đơn hàng.
     * SỬ DỤNG: UPDATE Cakes SET quantity = quantity - ? WHERE cakeID = ?
     * * @param cakeId ID của sản phẩm cần cập nhật.
     * @param orderedQuantity Số lượng đã đặt (cần trừ đi).
     * @return true nếu cập nhật thành công (rowsAffected > 0), false nếu thất bại.
     */
    public boolean updateCakeQuantity(int cakeId, int orderedQuantity) {
        if (cakeId <= 0 || orderedQuantity <= 0) {
            return false;
        }
        
        boolean success = false;
        // Sử dụng try-with-resources cho Connection và PreparedStatement 
        // để đảm bảo tài nguyên được đóng ngay cả khi có ngoại lệ
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_CAKE_QUANTITY)) {
            
            // 1. Số lượng cần trừ đi (đặt vào dấu hỏi thứ nhất)
            ps.setInt(1, orderedQuantity); 
            // 2. ID của sản phẩm (đặt vào dấu hỏi thứ hai)
            ps.setInt(2, cakeId); 
            
            // executeUpdate trả về số lượng hàng đã bị ảnh hưởng
            int rowsAffected = ps.executeUpdate(); 
            
            // Nếu có ít nhất 1 hàng bị ảnh hưởng, tức là cập nhật thành công
            if (rowsAffected > 0) {
                success = true;
            }

        } catch (SQLException e) {
            // Ghi log lỗi để dễ dàng kiểm tra
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật số lượng tồn kho cho CakeID: " + cakeId, e);
        } 
        return success;
    }
}