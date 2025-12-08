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
    // 引入 Service 层，而不是自己连数据库
    private AdoptionService adoptionService = new AdoptionServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();

        switch (path) {
            case "/toApply":
                // 跳转到申请填写页面，并把 petId 传过去
                String petId = req.getParameter("petId");
                req.setAttribute("petId", petId);
                req.getRequestDispatcher("/WEB-INF/views/user/applyAdopt.jsp").forward(req, resp);
                break;
            case "/manage":
                // 管理员查看申请列表（支持筛选）
                listApplications(req, resp);
                break;
            case "/myApply":
                // 普通用户查询自己的申请
                searchMyApplication(req, resp);
                break;
            case "/review":
                // 跳转到审核详情页
                showReviewPage(req, resp);
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
                // 提交领养申请
                submitApplication(req, resp);
                break;
            case "/doReview":
                // 提交审核结果
                processReview(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/404.jsp");
        }
    }

    // --- 业务方法 ---

    // 1. 处理提交申请
    private void submitApplication(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 封装联系人信息
            ContactPerson person = new ContactPerson();
            person.setName(req.getParameter("contactName"));
            person.setPhone(req.getParameter("phone"));
            person.setEmail(req.getParameter("email"));
            person.setAddress(req.getParameter("address"));

            // 封装申请信息
            AdoptionApplication app = new AdoptionApplication();
            app.setPetId(Integer.parseInt(req.getParameter("petId")));
            app.setAdoptMotive(req.getParameter("adoptMotive"));

            // 调用 Service
            boolean success = adoptionService.submitApplication(person, app);

            if (success) {
                req.setAttribute("successMsg", "您的领养申请已提交，请耐心等待审核！");
                req.getRequestDispatcher("/WEB-INF/views/user/applySuccess.jsp").forward(req, resp);
            } else {
                req.setAttribute("errorMsg", "提交失败，请重试！");
                req.setAttribute("petId", app.getPetId()); // 回显ID
                req.getRequestDispatcher("/WEB-INF/views/user/applyAdopt.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "系统错误：" + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/user/applyAdopt.jsp").forward(req, resp);
        }
    }

    // 2. 管理员查看列表
    private void listApplications(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        List<AdoptionApplication> list;

        if (status != null && !status.isEmpty()) {
            list = adoptionService.getApplicationsByStatus(status);
            req.setAttribute("status", status); // 回显筛选状态
        } else {
            list = adoptionService.getAllApplications();
        }

        req.setAttribute("appList", list);
        req.getRequestDispatcher("/WEB-INF/views/admin/applyManage.jsp").forward(req, resp);
    }

    // 3. 用户查询自己的申请
    private void searchMyApplication(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phone = req.getParameter("phone");
        if (phone != null && !phone.trim().isEmpty()) {
            // 这里为了简化，直接用 Service 层现有的 getMyApplications (需要 ContactId)
            // 实际项目中应该加一个 getApplicationsByPhone 方法
            // 这里我们暂时假设 Service 没有按电话查的方法，先留空或做个简单处理
            // *为了让你跑通，你需要去 AdoptionService 补一个按电话查的方法，或者暂时不处理*
            // 这里演示简单的页面跳转，如果有数据则展示

            // 修正：由于你的 Service 接口目前只有 getMyApplications(Integer contactId)
            // 你可能需要修改 Service 增加 getApplicationsByPhone(String phone)
            // 这里暂时转发回原页面，避免报错
        }
        req.getRequestDispatcher("/WEB-INF/views/user/myApply.jsp").forward(req, resp);
    }

    // 4. 展示审核页
    private void showReviewPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 你需要去实现 getApplicationById 方法，这里暂时用列表跳转逻辑
        // 简单处理：为了不报错，先重定向回管理页，实际需要 Service 支持 findById
        String appId = req.getParameter("appId");
        // 假设你要审核，需要获取详情，这里先不做复杂查询，直接跳转
        // 真正开发需要在 Service 加一个 getApplicationById(int id)
        // 暂时跳回管理页避免 404
        req.getRequestDispatcher("/WEB-INF/views/admin/reviewApply.jsp").forward(req, resp);
    }

    // 5. 处理审核
    private void processReview(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int appId = Integer.parseInt(req.getParameter("appId"));
            int petId = Integer.parseInt(req.getParameter("petId"));
            String status = req.getParameter("status");

            adoptionService.reviewApplication(appId, status, petId);

            // 成功后重定向回列表
            resp.sendRedirect(req.getContextPath() + "/adoption/manage");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/adoption/manage?error=reviewFailed");
        }
    }
}