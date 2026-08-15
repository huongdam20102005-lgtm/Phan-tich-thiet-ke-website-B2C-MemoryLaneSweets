package com.webbanbanh.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

import com.webbanbanh.model.Cart;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        // Nếu cart chưa tồn tại → tạo cart trống để tránh lỗi JSP
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // Đẩy dữ liệu cho JSP (không bắt buộc, nhưng tốt)
        request.setAttribute("cartItems", cart.getItems());
        request.setAttribute("cartTotal", cart.getTotalMoney());

        request.getRequestDispatcher("/WEB-INF/view/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        System.out.println("THÔNG TIN NHẬN ĐƯỢC:");
        System.out.println(name + " - " + phone + " - " + address);

        // Lưu thông tin giao hàng vào session (để payment.jsp có thể dùng)
        HttpSession session = request.getSession();
        session.setAttribute("shippingName", name);
        session.setAttribute("shippingPhone", phone);
        session.setAttribute("shippingAddress", address);

        // Chuyển sang trang thanh toán
        response.sendRedirect("payment");
    }
}
