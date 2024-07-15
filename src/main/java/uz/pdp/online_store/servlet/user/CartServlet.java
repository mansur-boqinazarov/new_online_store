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
        Orders userOrder = getOrder(user);
        Product product = productService.findById(productId);
        orderItemService.addProduct(userOrder, product);
        resp.sendRedirect("/app");

    }

    private Orders getOrder(Users user) {
        Optional<Orders> optOrder = orderService.findOrderByUser(user);
        if (optOrder.isPresent()) {
            return optOrder.get();
        } else {
            return orderService.createOrder(user);
        }
    }
}
