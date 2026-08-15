package com.webbanbanh.controller;

import com.webbanbanh.model.Cake; // Giả định
import com.webbanbanh.dao.CakeDAO; // Giả định

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""}) // Ánh xạ tới cả /home và root
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    // Giả định bạn đã có lớp CakeDAO để tương tác với DB
    private CakeDAO cakeDAO; 

    @Override
    public void init() throws ServletException {
        super.init();
        // Khởi tạo DAO (hoặc dùng Dependency Injection nếu có framework)
        cakeDAO = new CakeDAO(); 
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // 1. Lấy danh sách SẢN PHẨM MỚI (New Products)
            List<Cake> newCakes = cakeDAO.getNewCakes(); 
            
            // 2. Lấy danh sách SẢN PHẨM BÁN CHẠY (Best Sellers)
            List<Cake> bestSellers = cakeDAO.getBestSellers(); 

            // 3. Đặt dữ liệu vào request để chuyển sang JSP
            request.setAttribute("newCakes", newCakes);
            request.setAttribute("bestSellers", bestSellers);
            
            // 4. Chuyển tiếp (forward) đến trang JSP để hiển thị
            // ĐÃ SỬA: Đường dẫn phải là /WEB-INF/view/trangchu.jsp vì file nằm ở đó
            request.getRequestDispatcher("/WEB-INF/view/trangchu.jsp").forward(request, response); 
            // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ĐƯỜNG DẪN ĐÃ KHẮC PHỤC LỖI 404

        } catch (Exception e) {
            // Xử lý lỗi (ví dụ: lỗi kết nối DB, lỗi DAO)
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải dữ liệu sản phẩm. Vui lòng kiểm tra kết nối DB.");
            request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
        }
    }

    // Xử lý yêu cầu GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Xử lý yêu cầu POST (nếu cần)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}