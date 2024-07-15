//package uz.pdp.online_store.filter;
//
//import jakarta.servlet.Filter;
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.FilterConfig;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.ServletRequest;
//import jakarta.servlet.ServletResponse;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//
//@WebFilter("/app/*")
//public class SecurityFilter implements Filter {
//
//    @Override
//    public void init(FilterConfig filterConfig) throws ServletException {
//        // Filter initialization if needed
//    }
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//        HttpServletResponse httpResponse = (HttpServletResponse) response;
//        HttpSession session = httpRequest.getSession(false);
//
//        String loginURI = httpRequest.getContextPath() + "/loginSignUp";
//
//        boolean loggedIn = (session != null && session.getAttribute("user") != null);
//        boolean loginRequest = httpRequest.getRequestURI().equals(loginURI);
//
//        if (loggedIn || loginRequest) {
//            chain.doFilter(request, response);
//        } else {
//            httpResponse.sendRedirect(loginURI);
//        }
//    }
//
//    @Override
//    public void destroy() {
//        // Clean up resources if needed
//    }
//}
