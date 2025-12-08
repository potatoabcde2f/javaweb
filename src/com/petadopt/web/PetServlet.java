package com.petadopt.web;

import com.petadopt.entity.Pet;
import com.petadopt.entity.User;
import com.petadopt.service.PetService;
import com.petadopt.service.impl.PetServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/pet/*")
public class PetServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();

        switch (path) {
            case "/list":
                getPetList(req, resp);
                break;
            case "/detail":
                getPetDetail(req, resp);
                break;
            case "/toAdd":
                toAddPet(req, resp);
                break;
            case "/toEdit":
                toEditPet(req, resp);
                break;
            default:
                resp.sendRedirect("/404.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();

        switch (path) {
            case "/add":
                addPet(req, resp);
                break;
            case "/edit":
                editPet(req, resp);
                break;
            case "/delete":
                deletePet(req, resp);
                break;
            case "/search":
                searchPets(req, resp);
                break;
            default:
                resp.sendRedirect("/404.jsp");
        }
    }

    // 宠物列表（普通用户+管理员）
    private void getPetList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Pet> petList = petService.getAllPets();
        req.setAttribute("petList", petList);
        // 判断是否为管理员
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser != null && "admin".equals(loginUser.getRole())) {
            req.getRequestDispatcher("/WEB-INF/views/admin/petManage.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/WEB-INF/views/user/petList.jsp").forward(req, resp);
        }
    }

    // 宠物详情
    private void getPetDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String petIdStr = req.getParameter("petId");
        try {
            Integer petId = Integer.parseInt(petIdStr);
            Pet pet = petService.getPetById(petId);
            req.setAttribute("pet", pet);
            req.getRequestDispatcher("/WEB-INF/views/user/petDetail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect("/pet/list");
        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/pet/list").forward(req, resp);
        }
    }

    // 管理员：跳转到新增宠物页
    private void toAddPet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/admin/addPet.jsp").forward(req, resp);
    }

    // 管理员：新增宠物
    private void addPet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Pet pet = new Pet();
        pet.setName(req.getParameter("name"));
        pet.setSpecies(req.getParameter("species"));
        pet.setBreed(req.getParameter("breed"));
        pet.setAge(Integer.parseInt(req.getParameter("age")));
        pet.setGender(req.getParameter("gender"));
        pet.setDescription(req.getParameter("description"));
        pet.setImageUrl(req.getParameter("imageUrl"));
        pet.setStatus("available");

        try {
            boolean success = petService.addPet(pet);
            if (success) {
                resp.sendRedirect("/pet/list");
            } else {
                req.setAttribute("errorMsg", "新增宠物失败！");
                req.getRequestDispatcher("/WEB-INF/views/admin/addPet.jsp").forward(req, resp);
            }
        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/admin/addPet.jsp").forward(req, resp);
        }
    }

    // 管理员：跳转到编辑宠物页
    private void toEditPet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String petIdStr = req.getParameter("petId");
        try {
            Integer petId = Integer.parseInt(petIdStr);
            Pet pet = petService.getPetById(petId);
            req.setAttribute("pet", pet);
            req.getRequestDispatcher("/WEB-INF/views/admin/editPet.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect("/pet/list");
        }
    }

    // 管理员：编辑宠物
    private void editPet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Pet pet = new Pet();
        pet.setPetId(Integer.parseInt(req.getParameter("petId")));
        pet.setName(req.getParameter("name"));
        pet.setSpecies(req.getParameter("species"));
        pet.setBreed(req.getParameter("breed"));
        pet.setAge(Integer.parseInt(req.getParameter("age")));
        pet.setGender(req.getParameter("gender"));
        pet.setDescription(req.getParameter("description"));
        pet.setImageUrl(req.getParameter("imageUrl"));
        pet.setStatus(req.getParameter("status"));

        try {
            boolean success = petService.editPet(pet);
            if (success) {
                resp.sendRedirect("/pet/list");
            } else {
                req.setAttribute("errorMsg", "编辑宠物失败！");
                req.getRequestDispatcher("/WEB-INF/views/admin/editPet.jsp").forward(req, resp);
            }
        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/admin/editPet.jsp").forward(req, resp);
        }
    }

    // 管理员：删除宠物
    private void deletePet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String petIdStr = req.getParameter("petId");
        try {
            Integer petId = Integer.parseInt(petIdStr);
            petService.deletePet(petId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect("/pet/list");
    }

    // 宠物搜索/筛选
    private void searchPets(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String species = req.getParameter("species");
        String status = req.getParameter("status");
        String keyword = req.getParameter("keyword");

        List<Pet> petList = petService.searchPets(species, status, keyword);
        req.setAttribute("petList", petList);
        // 回显筛选条件
        req.setAttribute("species", species);
        req.setAttribute("status", status);
        req.setAttribute("keyword", keyword);

        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser != null && "admin".equals(loginUser.getRole())) {
            req.getRequestDispatcher("/WEB-INF/views/admin/petManage.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/WEB-INF/views/user/petList.jsp").forward(req, resp);
        }
    }
}