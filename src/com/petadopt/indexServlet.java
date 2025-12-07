package com.petadopt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/indexServlet")
public class indexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取当前用户的Session
        HttpSession session = request.getSession();

        // 从Session中获取个人访问次数
        Object count = session.getAttribute("userTimes");

        Integer times = 0;

        if (count == null) {
            // 第一次访问
            times = 1;
        } else {
            // 非第一次，次数累加
            times = Integer.parseInt(count.toString()) + 1;
        }

        // 将新次数存回Session
        session.setAttribute("userTimes", times);

        // 设置响应
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<h1>欢迎光临本网站，这是您第" + times + "次访问！</h1>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
