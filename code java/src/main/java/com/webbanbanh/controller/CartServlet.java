package com.webbanbanh.controller;

import com.webbanbanh.model.Cake;
import com.webbanbanh.model.Cart;
import com.webbanbanh.model.CartItem;
import com.webbanbanh.dao.CakeDAO;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private final CakeDAO cakeDAO = new CakeDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Xóa thông báo lỗi cũ (nếu có)
        request.getSession().removeAttribute("errorMessage");

        // Lấy hành động (nếu không có mặc định là 'add')
        String action = request.getParameter("action");
        if (action == null) {
            action = "add";
        }

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        // Đảm bảo Cart tồn tại trước khi thao tác
        if (cart == null) {
            cart = new Cart();
        }

        String productID_raw = request.getParameter("productID");
        int productID;

        try {
            productID = Integer.parseInt(productID_raw);

            if (action.equals("add")) {
                // Logic Thêm sản phẩm
                String quantity_raw = request.getParameter("quantity");
                int quantity = Integer.parseInt(quantity_raw);
                if (quantity < 1) quantity = 1;

                // Lấy sản phẩm từ DB
                Cake cake = cakeDAO.getCakeByID(productID);
                if (cake != null) {
                    int available = cake.getQuantity();

                    // Lấy số lượng hiện tại trong giỏ hàng
                    int currentQuantityInCart = cart.getItems().containsKey(productID)
                                                 ? cart.getItems().get(productID).getQuantity() : 0;

                    // Tổng số lượng sau khi thêm
                    int totalQuantity = currentQuantityInCart + quantity;

                    // Kiểm tra số lượng tồn kho
                    if (totalQuantity > available) {
                        // Nếu vượt quá tồn kho, đặt thông báo lỗi
                        session.setAttribute("errorMessage", "Số lượng không đủ. Chỉ còn " + available + " sản phẩm.");
                    } else {
                        // Nếu hợp lệ, thêm vào giỏ (hàm add sẽ tự động cộng dồn)
                        CartItem newItem = new CartItem(cake, quantity);
                        cart.add(newItem);
                    }
                }
            }
            else if (action.equals("update")) {
                // Logic Cập nhật số lượng (Kiểm tra tồn kho)
                String quantity_raw = request.getParameter("quantity");
                int newQuantity = Integer.parseInt(quantity_raw);

                if (newQuantity < 1) {
                    // Nếu số lượng <= 0, xóa sản phẩm khỏi giỏ hàng
                    cart.removeItem(productID);
                } else if (cart.getItems().containsKey(productID)) {
                    Cake cake = cakeDAO.getCakeByID(productID);
                    if (cake != null) {
                        int available = cake.getQuantity();

                        if (newQuantity > available) {
                            // Nếu số lượng cập nhật vượt quá tồn kho
                            session.setAttribute("errorMessage", "Số lượng cập nhật vượt quá tồn kho. Chỉ còn " + available + " sản phẩm.");
                            // KHÔNG CẬP NHẬT
                        } else {
                            // Cập nhật số lượng
                            cart.getItems().get(productID).setQuantity(newQuantity);
                        }
                    }
                }
            }

            // Lưu lại Cart vào Session
            session.setAttribute("cart", cart);

            // Chuyển hướng người dùng về trang giỏ hàng sau khi thao tác
            response.sendRedirect(request.getContextPath() + "/cart");

        } catch (Exception e) {
            // Ghi lỗi chi tiết ra console
            e.printStackTrace();
            // Nếu có lỗi, chuyển hướng về trang chủ hoặc hiển thị thông báo lỗi
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thông báo lỗi từ Session, đặt vào Request, và xóa khỏi Session (PRG Pattern)
        String errorMessage = (String) request.getSession().getAttribute("errorMessage");
        if (errorMessage != null) {
              request.setAttribute("errorMessage", errorMessage);
              request.getSession().removeAttribute("errorMessage");
        }

        String action = request.getParameter("action");

        if (action != null && action.equals("remove")) {
            // Xử lý Xóa sản phẩm (Được gọi qua GET link)
            try {
                int productID = Integer.parseInt(request.getParameter("productID"));
                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("cart");

                if (cart != null) {
                    cart.removeItem(productID);
                    session.setAttribute("cart", cart);
                }

            } catch (NumberFormatException e) {
                // Nếu ID không hợp lệ, không làm gì cả
            }

            // Sau khi xóa, chuyển hướng về CartServlet để hiển thị trang giỏ hàng
            response.sendRedirect(request.getContextPath() + "/cart");

        } else {
            // Nếu không có action (hoặc action khác), forward đến cart.jsp để hiển thị
            request.getRequestDispatcher("/WEB-INF/view/cart.jsp").forward(request, response);
        }
    }
}