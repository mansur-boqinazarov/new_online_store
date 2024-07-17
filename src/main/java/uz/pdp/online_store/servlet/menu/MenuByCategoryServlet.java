package uz.pdp.online_store.servlet.menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "categorymenu", urlPatterns = "/showCategoryProducts")
public class MenuByCategoryServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryId = req.getParameter("categoryId");
        req.getSession().setAttribute("categoryId", categoryId);
        req.getRequestDispatcher("/views/menu/mainmenubycategory.jsp").forward(req, resp);
    }
}