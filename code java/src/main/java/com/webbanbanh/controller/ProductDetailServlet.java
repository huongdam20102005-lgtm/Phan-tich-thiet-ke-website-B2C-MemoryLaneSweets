package com.webbanbanh.controller;

import com.webbanbanh.dao.CakeDAO;
import com.webbanbanh.model.Cake;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

// Đảm bảo mapping là /product
@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product-detail"})
public class ProductDetailServlet extends HttpServlet {
    
    private final CakeDAO cakeDAO = new CakeDAO(); // Khai báo DAO một lần

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Cần thiết lập encoding trước khi lấy tham số để tránh lỗi tiếng Việt nếu cần
        // request.setCharacterEncoding("UTF-8"); 
    
        // 1. Lấy ID sản phẩm từ tham số URL
        String cakeID_raw = request.getParameter("id");
    
        if (cakeID_raw == null || cakeID_raw.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số ID sản phẩm.");
            return;
        }
    
        try {
            int cakeID = Integer.parseInt(cakeID_raw);
        
            // 2. Lấy thông tin sản phẩm
            Cake cake = cakeDAO.getCakeByID(cakeID); // Lấy đối tượng Cake
        
            if (cake != null) {
                
                // 3. Lấy tên danh mục (cho Breadcrumb)
                String categoryName = cakeDAO.getCategoryNameById(cake.getCategoryID());
                
                // 4. Lấy sản phẩm liên quan
                List<Cake> relatedProducts = cakeDAO.getCakesByCategoryId(
                    cake.getCategoryID(), 
                    cakeID
                );
                
                // 5. Đặt tất cả các thuộc tính VỚI TÊN ĐÚNG VỚI JSP
                request.setAttribute("cake", cake);
                request.setAttribute("categoryName", categoryName);
                request.setAttribute("relatedProducts", relatedProducts);
                
                // 6. Forward đến trang JSP
                request.getRequestDispatcher("/WEB-INF/view/product-detail.jsp").forward(request, response);
                
            } else {
                // Sản phẩm không tồn tại
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm này.");
            }
        
        } catch (NumberFormatException e) {
            // Lỗi ID không phải số
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ.");
        } catch (Exception e) {
            // Lỗi DAO/CSDL
            System.err.println("Lỗi truy vấn CSDL trong ProductDetailServlet: " + e.getMessage());
            e.printStackTrace(); // Ghi log chi tiết vào console
            // Gửi lỗi 500 nếu gặp lỗi CSDL
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi truy vấn CSDL: " + e.getMessage());
        }
    }
}