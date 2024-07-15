package uz.pdp.online_store.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.online_store.entity.user.Users;
import uz.pdp.online_store.service.order.OrderService;

import java.io.IOException;

@WebServlet(name = "purchase", urlPatterns = "/purchase")
public class PurchaseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users user = (Users)req.getSession().getAttribute("user");
        OrderService service = new OrderService();
        service.orderedProduct(user);
        System.err.println("PurchaseServletning doPost metodiga keldi");
        resp.sendRedirect("/app");
    }
}
