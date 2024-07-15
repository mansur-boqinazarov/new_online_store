package uz.pdp.online_store.servlet.seller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.online_store.service.shop.ShopService;

import java.io.IOException;

@WebServlet(name = "create-store", urlPatterns = "/seller/createstore")
public class CreateStoreServlet extends HttpServlet {
    private static final ShopService service = new ShopService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/seller/create_store.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userId = (String)session.getAttribute("user_id");
        String shopName = req.getParameter("shopName");
        String shopDescription = req.getParameter("shopDescription");

        service.createShop(userId, shopName, shopDescription);

        resp.sendRedirect("/app/seller");
    }
}