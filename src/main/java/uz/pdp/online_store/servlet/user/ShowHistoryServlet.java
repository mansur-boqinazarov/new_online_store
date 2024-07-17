package uz.pdp.online_store.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.online_store.entity.order.OrderItem;
import uz.pdp.online_store.entity.order.Orders;
import uz.pdp.online_store.service.order.OrderItemService;
import uz.pdp.online_store.service.order.OrderService;


import java.io.IOException;
import java.util.List;

@WebServlet(name = "history", urlPatterns = "/showHistoryProduct")
public class ShowHistoryServlet extends HttpServlet {

    private static final OrderService service = new OrderService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String historyItem = req.getParameter("historyItem");
        Orders order = service.findOrder(historyItem);
        OrderItemService ser = new OrderItemService();
        List<OrderItem> allOrderItemByOrderID = ser.getAllOrderItemByOrderID(order.getId());
        req.setAttribute("allorderitembyorderid", allOrderItemByOrderID);
        req.getRequestDispatcher("/views/user/showHistory.jsp").forward(req, resp);
    }
}
