package com.webbanbanh.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.webbanbanh.model.Cart;
import com.webbanbanh.model.CartItem;
import com.webbanbanh.model.Order;
import com.webbanbanh.model.OrderDetail;
import com.webbanbanh.dao.OrderDAO;
import com.webbanbanh.dao.CakeDAO; // <<< 1. THÊM IMPORT

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(PaymentServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        // Lấy thông tin giao hàng từ session (đã lưu ở CheckoutServlet)
        String shippingName = (String) session.getAttribute("shippingName");
        String shippingPhone = (String) session.getAttribute("shippingPhone");
        String shippingAddress = (String) session.getAttribute("shippingAddress");
        
        request.setAttribute("shippingName", shippingName);
        request.setAttribute("shippingPhone", shippingPhone);
        request.setAttribute("shippingAddress", shippingAddress);

        if (cart == null || cart.getItems().isEmpty()) {
            request.setAttribute("cartItems", null);
            request.setAttribute("cartTotal", BigDecimal.ZERO);
        } else {
            request.setAttribute("cartItems", cart.getItems());
            request.setAttribute("cartTotal", cart.getTotalMoney());
        }

        request.getRequestDispatcher("/WEB-INF/view/payment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            request.setAttribute("error", "Giỏ hàng của bạn đang trống.");
            doGet(request, response);
            return;
        }

        String method = request.getParameter("method");
        session.setAttribute("paymentMethod", method);

        // Lấy thông tin giao hàng đã lưu ở CheckoutServlet
        String shippingAddress = (String) session.getAttribute("shippingAddress");
        
        // Build Order
        Order order = new Order();
        // Giả định UserID=0 cho khách vãng lai. Nếu có đăng nhập thì lấy từ session.
        // CẦN LƯU Ý: UserID cần được xử lý phù hợp với DB (có thể là NULLable hoặc 0)
        order.setUserID(0); 
        order.setStatus("Chờ xác nhận");
        order.setTotalAmount(cart.getTotalMoney());
        // Sử dụng địa chỉ từ session thay vì "Địa chỉ mặc định"
        order.setAddress(shippingAddress != null ? shippingAddress : "Địa chỉ mặc định");
        order.setPaymentMethod(method);

        List<OrderDetail> details = new ArrayList<>();
        // Lặp qua các mục trong Cart để tạo OrderDetail
        // Chú ý: cart.getItems() có kiểu dữ liệu là Map (hoặc List). Nếu là Map, dùng values()
        for (CartItem item : cart.getItems().values()) { 
            OrderDetail detail = new OrderDetail();
            detail.setCakeID(item.getCake().getCakeID());
            detail.setQuantity(item.getQuantity());
            detail.setUnitPrice(item.getCake().getPrice());
            details.add(detail);
        }
        order.setDetails(details);

        // Lưu vào DB
        OrderDAO orderDAO = new OrderDAO();
        CakeDAO cakeDAO = new CakeDAO(); // <<< KHỞI TẠO DAO MỚI

        try {
            // BƯỚC 1: LƯU ĐƠN HÀNG VÀ CHI TIẾT
            // Giả sử orderDAO.saveOrder(order) thành công và đã CHÈN orderDetails
            orderDAO.saveOrder(order);

            // ------------------------------------------------------------------
            // BƯỚC 2: TRỪ TỒN KHO <<< LOGIC MỚI ĐƯỢC THÊM VÀO ĐÂY
            // ------------------------------------------------------------------
            for (OrderDetail detail : order.getDetails()) {
                int cakeId = detail.getCakeID();
                int orderedQuantity = detail.getQuantity();
                
                // Gọi phương thức UPDATE_CAKE_QUANTITY từ CakeDAO
                boolean success = cakeDAO.updateCakeQuantity(cakeId, orderedQuantity);
                
                if (!success) {
                    LOGGER.log(Level.WARNING, "Không thể trừ tồn kho CakeID: " + cakeId);
                    // Tùy chọn: Xử lý rollback (gây phức tạp) hoặc ghi log để xử lý thủ công
                }
            }
            // ------------------------------------------------------------------

            // BƯỚC 3: Xóa giỏ hàng và thông tin giao hàng khỏi session
            session.removeAttribute("cart");
            session.removeAttribute("shippingName");
            session.removeAttribute("shippingPhone");
            session.removeAttribute("shippingAddress");
            session.removeAttribute("paymentMethod");

            // Forward sang trang thành công
            request.getRequestDispatcher("/WEB-INF/view/order-success.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lưu đơn hàng hoặc trừ tồn kho.", e);
            request.setAttribute("error", "Có lỗi khi lưu đơn hàng. Vui lòng thử lại.");
            doGet(request, response);
            return;
        }
    }
}