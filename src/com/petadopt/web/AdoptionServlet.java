package com.petadopt.web;

import com.petadopt.entity.AdoptionApplication;
import com.petadopt.entity.ContactPerson;
import com.petadopt.service.AdoptionService;
import com.petadopt.service.impl.AdoptionServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/adoption/*")
public class AdoptionServlet extends HttpServlet {
    private AdoptionService adoptionService = new AdoptionServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();

        switch (path) {
            case "/toApply":
                String petId = req.getParameter("petId");
                req.setAttribute("petId", petId);
                req.getRequestDispatcher("/WEB-INF/views/user/applyAdopt.jsp").forward(req, resp);
                break;
            case "/manage":
                listApplications(req, resp);
                break;
            case "/myApply":
                req.getRequestDispatcher("/WEB-INF/views/user/myApply.jsp").forward(req, resp);
                break;
            case "/review":
                // --- ✅ 修复点：查询详情数据 ---
                String appIdStr = req.getParameter("appId");
                if (appIdStr != null) {
                    try {
                        int appId = Integer.parseInt(appIdStr);
                        // 调用 Service 查详情
                        AdoptionApplication app = adoptionService.getApplicationById(appId);
                        // 存入 Request，供 JSP 渲染
                        req.setAttribute("app", app);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                req.getRequestDispatcher("/WEB-INF/views/admin/reviewApply.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/404.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();

        switch (path) {
            case "/submit":
                submitApplication(req, resp);
                break;
            case "/doReview":
                processReview(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/404.jsp");
        }
    }

    // --- 业务逻辑 ---

    private void submitApplication(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ContactPerson person = new ContactPerson();
            person.setName(req.getParameter("contactName"));
            person.setPhone(req.getParameter("phone"));
            person.setEmail(req.getParameter("email"));
            person.setAddress(req.getParameter("address"));

            AdoptionApplication app = new AdoptionApplication();
            app.setPetId(Integer.parseInt(req.getParameter("petId")));
            app.setAdoptMotive(req.getParameter("adoptMotive")); // 只保留动机

            boolean success = adoptionService.submitApplication(person, app);
            if (success) {
                req.setAttribute("successMsg", "申请提交成功！");
                req.getRequestDispatcher("/WEB-INF/views/user/applySuccess.jsp").forward(req, resp);
            } else {
                throw new RuntimeException("提交失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "提交失败：" + e.getMessage());
            req.setAttribute("petId", req.getParameter("petId"));
            req.getRequestDispatcher("/WEB-INF/views/user/applyAdopt.jsp").forward(req, resp);
        }
    }

    private void listApplications(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        List<AdoptionApplication> list;
        // 修复“查全部为0”的问题：严格判断空串和null字符串
        if (status != null && !status.trim().isEmpty() && !"null".equals(status)) {
            list = adoptionService.getApplicationsByStatus(status);
            req.setAttribute("status", status);
        } else {
            list = adoptionService.getAllApplications();
        }
        req.setAttribute("appList", list);
        req.getRequestDispatcher("/WEB-INF/views/admin/applyManage.jsp").forward(req, resp);
    }

    private void processReview(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int appId = Integer.parseInt(req.getParameter("appId"));
            int petId = Integer.parseInt(req.getParameter("petId"));
            String status = req.getParameter("status");
            adoptionService.reviewApplication(appId, status, petId);
            resp.sendRedirect(req.getContextPath() + "/adoption/manage");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/adoption/manage");
        }
    }
}