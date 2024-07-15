package uz.pdp.online_store.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.online_store.entity.order.Orders;
import uz.pdp.online_store.entity.user.Users;
import uz.pdp.online_store.service.order.OrderService;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "showCart", urlPatterns = "/showCart")
public class ShowCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        req.getRequestDispatcher("/views/user/showCart.jsp").forward(req,resp);
        OrderService orderService = new OrderService();
        Users user = (Users) req.getSession().getAttribute("user");
        Optional<Orders> optOrder = orderService.findOrderByUser(user);
        if (optOrder.isPresent()) {
            req.getSession().setAttribute("order", optOrder.get());
            req.getRequestDispatcher("/views/user/showCart.jsp").forward(req, resp);
        } else {
            req.setAttribute("message", "Your cart is empty");
            req.getRequestDispatcher("/views/user/showCart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
