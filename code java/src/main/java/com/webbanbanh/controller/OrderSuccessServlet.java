package com.webbanbanh.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Xóa giỏ hàng sau đặt hàng
        request.getSession().removeAttribute("cart");

        request.getRequestDispatcher("/WEB-INF/view/order-success.jsp").forward(request, response);
    }
}
