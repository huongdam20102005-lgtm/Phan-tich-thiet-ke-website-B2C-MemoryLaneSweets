package com.webbanbanh.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.webbanbanh.dao.CakeDAO;
import com.webbanbanh.model.Cake;

import java.io.IOException;
import java.util.List;
import java.math.BigDecimal;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy categoryId từ request
        String categoryIdParam = request.getParameter("id");
        int categoryId = 0;
        if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdParam);
            } catch (NumberFormatException e) {
                categoryId = 0;
            }
        }

        // Nếu không có categoryId thì quay về home
        if (categoryId <= 0) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Lấy filter giá
        String priceFilter = request.getParameter("priceFilter");
        BigDecimal minPrice = BigDecimal.ZERO;
        BigDecimal maxPrice = new BigDecimal("1000000000"); // Giá lớn mặc định

        if (priceFilter != null && !priceFilter.isEmpty()) {
            String[] parts = priceFilter.split("-");
            try {
                minPrice = new BigDecimal(parts[0]);
                if (parts.length > 1) {
                    if ("max".equalsIgnoreCase(parts[1])) {
                        maxPrice = new BigDecimal("1000000000");
                    } else {
                        maxPrice = new BigDecimal(parts[1]);
                    }
                }
            } catch (NumberFormatException e) {
                // Giữ giá trị mặc định nếu có lỗi định dạng số
            }
        }

        CakeDAO cakeDAO = new CakeDAO();

        try {
            // Lọc theo categoryID và giá
            List<Cake> cakeList = cakeDAO.getCakesByCategoryIdAndPrice(categoryId, minPrice, maxPrice);

            // Lấy tên danh mục để hiển thị
            String displayCategoryName = cakeDAO.getCategoryNameById(categoryId);

            request.setAttribute("cakeList", cakeList);
            request.setAttribute("categoryId", categoryId);
            request.setAttribute("categoryName", displayCategoryName);
            request.setAttribute("priceFilter", priceFilter);

            request.getRequestDispatcher("/WEB-INF/view/product-category.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống khi tải dữ liệu danh mục.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }
}
