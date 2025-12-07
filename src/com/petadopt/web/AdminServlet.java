package com.petadopt.web;

import com.petadopt.entity.User;
import com.petadopt.service.PetService;
import com.petadopt.service.AdoptionService;
import com.petadopt.service.impl.PetServiceImpl;
import com.petadopt.service.impl.AdoptionServiceImpl;

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
            resp.sendRedirect(req.getContextPath() + "/user/login");
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
                resp.sendRedirect("/404.jsp");
        }
    }

    // 管理员首页
    private void adminIndex(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 统计数据
        int totalPet = petService.getAllPets().size();
        int availablePet = petService.searchPets(null, "available", null).size();
        int pendingApp = adoptionService.getApplicationsByStatus("pending").size();
        int approvedApp = adoptionService.getApplicationsByStatus("approved").size();

        req.setAttribute("totalPet", totalPet);
        req.setAttribute("availablePet", availablePet);
        req.setAttribute("pendingApp", pendingApp);
        req.setAttribute("approvedApp", approvedApp);
        req.getRequestDispatcher("/WEB-INF/views/admin/adminIndex.jsp").forward(req, resp);
    }

    // 统计分析页
    private void showStatistics(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 物种分布统计
        int dogCount = petService.searchPets("狗", null, null).size();
        int catCount = petService.searchPets("猫", null, null).size();
        int otherCount = petService.searchPets("其他", null, null).size();

        // 申请状态统计
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
    }
}