package uz.pdp.online_store.servlet.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.online_store.service.user.UserService;

import java.io.IOException;

@WebServlet(name = "removeUser", urlPatterns = "/admin/removeUser")
public class RemoveUserServlet extends HttpServlet {

    private final UserService userService = new UserService(); // Initialize your service

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String removeUserId = req.getParameter("removeUserId");
        userService.removeUser(removeUserId);
        resp.sendRedirect( "/app/admin/users");
    }

}
