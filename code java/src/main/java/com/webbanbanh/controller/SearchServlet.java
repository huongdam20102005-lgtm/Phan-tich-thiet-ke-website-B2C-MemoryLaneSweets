package com.webbanbanh.controller;

import com.webbanbanh.dao.CakeDAO;
import com.webbanbanh.model.Cake;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SearchServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
        
        String searchKeyword = request.getParameter("keyword");
        if (searchKeyword == null) {
            searchKeyword = "";
        }
        searchKeyword = searchKeyword.trim(); 
        
        CakeDAO cakeDAO = new CakeDAO();
        List<Cake> searchResults = Collections.emptyList(); // Khởi tạo rỗng

        try {
            // Lỗi biên dịch xảy ra ở dòng này:
            searchResults = cakeDAO.searchCakesByName(searchKeyword);
            
        } catch (Exception e) {
            // 1. Ghi log chi tiết lỗi để kiểm tra (rất quan trọng)
            LOGGER.log(Level.SEVERE, "Lỗi truy vấn khi tìm kiếm bánh: " + searchKeyword, e);
            
            // 2. Thiết lập thông báo lỗi cho người dùng
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống khi tìm kiếm. Vui lòng thử lại sau.");
            
        }
        
        // Gửi kết quả (dù tìm thấy hay rỗng/lỗi) và từ khóa trở lại JSP
        request.setAttribute("keyword", searchKeyword);
        request.setAttribute("searchResults", searchResults);
        
        // Chuyển tiếp đến trang hiển thị kết quả
        request.getRequestDispatcher("/WEB-INF/view/search-results.jsp").forward(request, response);
    }
}