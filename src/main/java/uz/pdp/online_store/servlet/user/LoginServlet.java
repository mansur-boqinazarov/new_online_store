package uz.pdp.online_store.servlet.user;


import jakarta.el.ELClass;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import uz.pdp.online_store.entity.user.Users;
import uz.pdp.online_store.enums.Role;
import uz.pdp.online_store.service.user.UserService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Objects;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {
    UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/user/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Users user = userService.login(email, password);
        if (user != null) {
            PrintWriter writer = resp.getWriter();

            HttpSession session = req.getSession();
            session.setAttribute("user_id", user.getId());
            session.setAttribute("user", user);
            String id = session.getId();
            Cookie cookie = new Cookie("id", id);

            if (user.getRole() == Role.ADMIN) {
                req.getRequestDispatcher("/views/admin/admin.jsp").forward(req, resp);
            } else if (user.getRole() == Role.SELLER) {
                req.getRequestDispatcher("/views/seller/seller.jsp").forward(req, resp);
            } else if (user.getRole() == Role.USER) {
                writer.println("""
                        <!DOCTYPE html>
                        <html lang="en">
                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                            <meta http-equiv="X-UA-Compatible" content="ie=edge">
                            <title> Congratulations Page Design By WebJourney - Html Template </title>
                            <!-- FontAwesome -->
                            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                            <!-- Latest compiled and minified CSS -->
                            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
                            <style>
                            .congratulation-wrapper {
                                max-width: 550px;
                                margin-inline: auto;
                                -webkit-box-shadow: 0 0 20px #f3f3f3;
                                box-shadow: 0 0 20px #f3f3f3;
                                padding: 30px 20px;
                                background-color: #fff;
                                border-radius: 10px;
                            }

                            .congratulation-contents.center-text .congratulation-contents-icon {
                                margin-inline: auto;
                            }
                            .congratulation-contents-icon {
                                display: -webkit-box;
                                display: -ms-flexbox;
                                display: flex;
                                -webkit-box-align: center;
                                -ms-flex-align: center;
                                align-items: center;
                                -webkit-box-pack: center;
                                -ms-flex-pack: center;
                                justify-content: center;
                                height: 100px;
                                width: 100px;
                                background-color: #65c18c;
                                color: #fff;
                                font-size: 50px;
                                border-radius: 50%;
                                margin-bottom: 30px;
                            }
                            .congratulation-contents-title {
                                font-size: 32px;
                                line-height: 36px;
                                margin: -6px 0 0;
                            }
                            .congratulation-contents-para {
                                font-size: 16px;
                                line-height: 24px;
                                margin-top: 15px;
                            }
                            .btn-wrapper {
                                display: block;
                            }
                            .cmn-btn.btn-bg-1 {
                                background: #6176f6;
                                color: #fff;
                                border: 2px solid transparent;
                                border-radius:3px;
                                text-decoration: none;
                                padding:5px;
                            }
                            </style>
                        </head>

                        <body>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                            <!-- Congratulations area start -->
                            <div class="congratulation-area text-center mt-5">
                                <div class="container">
                                    <div class="congratulation-wrapper">
                                        <div class="congratulation-contents center-text">
                                            <div class="congratulation-contents-icon">
                                                <i class="fas fa-check"></i>
                                            </div>
                                            <h4 class="congratulation-contents-title"> Congratulations! </h4>
                                            <p class="congratulation-contents-para"> Your account is ready to submit proposals and get work. </p>
                                            <div class="btn-wrapper mt-4">
                                                <a href="/app" class="cmn-btn btn-bg-1"> Go to Home </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Congratulations area end -->

                        <!-- Latest compiled JavaScript -->
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
                        </body>
                        </html>
                        """);
            }
        }
        else {
            PrintWriter writer = resp.getWriter();
            writer.println("""
                    <!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Login Error</title>
                        <style>
                            body {
                                display: flex;
                                justify-content: center;
                                align-items: center;
                                height: 100vh;
                                margin: 0;
                                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                                background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
                            }
                                        
                            .container {
                                text-align: center;
                                padding: 20px 40px;
                                background-color: white;
                                border: 1px solid #ccc;
                                border-radius: 10px;
                                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                                animation: fadeIn 1s ease-out;
                            }
                                        
                            .error-icon {
                                width: 50px;
                                height: 50px;
                                margin-bottom: 20px;
                            }
                                        
                            .error-message {
                                font-size: 20px;
                                color: #333;
                                margin: 0;
                                padding: 10px 0;
                                animation: slideIn 0.5s ease-out;
                            }
                                        
                            @keyframes fadeIn {
                                from {
                                    opacity: 0;
                                    transform: scale(0.9);
                                }
                                to {
                                    opacity: 1;
                                    transform: scale(1);
                                }
                            }
                                        
                            @keyframes slideIn {
                                from {
                                    opacity: 0;
                                    transform: translateY(-20px);
                                }
                                to {
                                    opacity: 1;
                                    transform: translateY(0);
                                }
                            }
                        </style>
                    </head>
                    <body>
                        <div class="container">
                            <svg class="error-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <circle cx="12" cy="12" r="10" fill="#e74c3c"/>
                                <path d="M15 9L9 15" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M9 9L15 15" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <div class="error-message">
                                <p>Login yoki parol xato</p>
                            </div>
                        </div>
                                        
                        <script>
                            // 3 soniyadan keyin "/app" sahifasiga qaytaradi
                            setTimeout(function(){
                                window.location.href = "/app";
                            }, 3000);
                        </script>
                    </body>
                    </html>
                     
                    """);
        }
    }
}