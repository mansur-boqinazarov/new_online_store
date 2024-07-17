package uz.pdp.online_store.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.online_store.entity.order.Orders;
import uz.pdp.online_store.entity.product.Product;
import uz.pdp.online_store.entity.user.Users;
import uz.pdp.online_store.service.order.OrderItemService;
import uz.pdp.online_store.service.order.OrderService;
import uz.pdp.online_store.service.product.ProductService;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "Cart", urlPatterns = "/cart")
public class CartServlet extends HttpServlet {
    OrderService orderService = new OrderService();
    ProductService productService = new ProductService();
    OrderItemService orderItemService = new OrderItemService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String productId = req.getParameter("productId");
        Users user = (Users) req.getSession().getAttribute("user");

        Optional<Orders> orderByUser = orderService.findOrderByUser(user);
        if (orderByUser.isPresent()) {
            Product product = productService.findById(productId);
            orderItemService.addProduct(orderByUser.get(), product);
        }
        resp.sendRedirect("/app");
    }
}