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
            // --- 👇 新增以下 3 个分支，配合 JSP 的修改 👇 ---
            case "/toLogin":
                req.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(req, resp);
                break;
            case "/toRegister":
                req.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(req, resp);
                break;
            case "/toAdminLogin":
                req.getRequestDispatcher("/WEB-INF/views/admin/adminLogin.jsp").forward(req, resp);
                break;
            // --- 👆 新增结束 👆 ---
            default:
                // 这里建议用 ContextPath 防止路径错误
                resp.sendRedirect(req.getContextPath() + "/404.jsp");
        }
    }

    // 登录业务处理
    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            User user = userService.login(username, password);
            req.getSession().setAttribute("loginUser", user);
            if ("admin".equals(user.getRole())) {
                // 重定向路径必须加 ContextPath
                resp.sendRedirect(req.getContextPath() + "/admin/index");
            } else {
                resp.sendRedirect(req.getContextPath() + "/pet/list");
            }
        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(req, resp);
        }
    }

    // 注册业务处理
    private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        user.setUsername(req.getParameter("username"));
        user.setPassword(req.getParameter("password"));

        try {
            boolean success = userService.register(user);
            if (success) {
                req.setAttribute("successMsg", "注册成功！请登录");
                req.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("errorMsg", "注册失败！");
                req.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(req, resp);
            }
        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(req, resp);
        }
    }

    // 退出登录
    private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.getSession().removeAttribute("loginUser");
        // 退出后重定向到 /user/toLogin，让上面的 case "/toLogin" 负责转发到 JSP
        resp.sendRedirect(req.getContextPath() + "/user/toLogin");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}