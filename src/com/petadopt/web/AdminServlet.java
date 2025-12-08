package com.petadopt.web;

import com.petadopt.entity.User;
import com.petadopt.service.AdoptionService;
import com.petadopt.service.PetService;
import com.petadopt.service.impl.AdoptionServiceImpl;
import com.petadopt.service.impl.PetServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();
    private AdoptionService adoptionService = new AdoptionServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();

        // 校验管理员权限
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/user/toLogin"); // 修正跳转
            return;
        }

        switch (path) {
            case "/index":
                adminIndex(req, resp);
                break;
            case "/statistics":
                showStatistics(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/404.jsp");
        }
    }

    // --- 1. 管理员首页 (工作台) 数据 ---
    private void adminIndex(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 关键：这里必须查询数据，否则页面显示为0或空
        try {
            int totalPet = petService.getAllPets().size();
            int pendingApp = adoptionService.getApplicationsByStatus("pending").size();
            // 首页只需要这两个核心数据作为“待办提醒”，不需要查太细，保持首页加载快

            req.setAttribute("totalPet", totalPet);
            req.setAttribute("pendingApp", pendingApp);

            // 转发到 adminIndex.jsp
            req.getRequestDispatcher("/WEB-INF/views/admin/adminIndex.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            // 如果出错，也至少要把页面显示出来
            req.getRequestDispatcher("/WEB-INF/views/admin/adminIndex.jsp").forward(req, resp);
        }
    }

    // --- 2. 统计分析页数据 ---
    private void showStatistics(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 物种分布
            int dogCount = petService.searchPets("狗", null, null).size();
            int catCount = petService.searchPets("猫", null, null).size();
            int otherCount = petService.searchPets("其他", null, null).size();

            // 申请状态分布
            int pendingCount = adoptionService.getApplicationsByStatus("pending").size();
            int approvedCount = adoptionService.getApplicationsByStatus("approved").size();
            int rejectedCount = adoptionService.getApplicationsByStatus("rejected").size();

            req.setAttribute("dogCount", dogCount);
            req.setAttribute("catCount", catCount);
            req.setAttribute("otherCount", otherCount);

            req.setAttribute("pendingCount", pendingCount);
            req.setAttribute("approvedCount", approvedCount);
            req.setAttribute("rejectedCount", rejectedCount);

            req.getRequestDispatcher("/WEB-INF/views/admin/statistics.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("/WEB-INF/views/admin/statistics.jsp").forward(req, resp);
        }
    }
}