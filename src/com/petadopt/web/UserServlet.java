package com.petadopt.web;

import com.petadopt.entity.User;
import com.petadopt.service.UserService;
import com.petadopt.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/user/*")
public class UserServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String path = req.getPathInfo();

        switch (path) {
            case "/login":
                login(req, resp);
                break;
            case "/register":
                register(req, resp);
                break;
            case "/logout":
                logout(req, resp);
                break;
            default:
                resp.sendRedirect("/404.jsp");
        }
    }

    // 登录处理
    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            User user = userService.login(username, password);
            // 存入Session
            req.getSession().setAttribute("loginUser", user);
            // 管理员跳转后台，普通用户跳转宠物列表
            if ("admin".equals(user.getRole())) {
                resp.sendRedirect("/admin/index.jsp");
            } else {
                resp.sendRedirect("/pet/list");
            }
        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("WEB-INF/views/user/login.jsp").forward(req, resp);
        }
    }

    // 注册处理
    private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        user.setUsername(req.getParameter("username"));
        user.setPassword(req.getParameter("password"));

        try {
            boolean success = userService.register(user);
            if (success) {
                // 注册成功跳转登录页
                req.setAttribute("successMsg", "注册成功！请登录");
                req.getRequestDispatcher("WEB-INF/views/user/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("errorMsg", "注册失败！");
                req.getRequestDispatcher("WEB-INF/views/user/register.jsp").forward(req, resp);
            }
        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("WEB-INF/views/user/register.jsp").forward(req, resp);
        }
    }

    // 退出登录
    private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.getSession().removeAttribute("loginUser");
        resp.sendRedirect("WEB-INF/views/user/login.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}