package uz.pdp.online_store.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.online_store.entity.user.Users;
import uz.pdp.online_store.service.user.UserService;

import java.io.IOException;

@WebServlet(name = "signup", value = "/signup")
public class SignupServlet extends HttpServlet {
    UserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/user/signup.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String number = req.getParameter("number");
        Users users = userService.signUp(fullName, email, password, number);
            req.getSession().setAttribute("user", users);
        resp.sendRedirect("/app");
    }
}