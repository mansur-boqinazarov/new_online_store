package uz.pdp.online_store.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.online_store.entity.order.OrderItem;
import uz.pdp.online_store.entity.order.Orders;
import uz.pdp.online_store.entity.user.Users;
import uz.pdp.online_store.service.order.OrderService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ShowCartDeleteItem", urlPatterns = "/showCartRemoveProduct")
public class ShowCardRemoveItemServlet extends HttpServlet {
    public  OrderService orderService = new OrderService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String itemId = req.getParameter("itemId");
        Users user = (Users) req.getSession().getAttribute("user");
        Orders order = orderService.findOrderByUser(user).get();
        List<OrderItem> orderItems = order.getOrderItems();
        OrderItem item = orderItems.stream().filter(orderItem -> orderItem.getId().equals(itemId)).findFirst().get();
        orderItems.remove(item);
        orderService.dao.update(order);
        resp.sendRedirect("/app/showCart");
    }
}
