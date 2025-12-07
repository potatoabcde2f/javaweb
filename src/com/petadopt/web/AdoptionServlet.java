package com.petadopt.web;

import com.petadopt.entity.AdoptionApplication;
import com.petadopt.entity.ContactPerson;
import com.petadopt.entity.Pet;
import com.petadopt.dao.ContactPersonDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/adoption/*")
public class AdoptionServlet extends HttpServlet {

    /* 数据库连接工具方法：从连接池拿也行，这里先裸写 */
    private Connection getConn() throws SQLException {
        // 换成你自己的库、用户名、密码
        String url  = "jdbc:mysql://localhost:3306/chongwu?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String pwd  = "123456";
        return DriverManager.getConnection(url, user, pwd);
    }

    /* 新增申请：POST /adoption?action=add */
    private void addApplication(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("application/json;charset=utf-8");

        // 接收参数
        int petId = Integer.parseInt(req.getParameter("petId"));
        int contactId = Integer.parseInt(req.getParameter("contactId"));
        String reason = req.getParameter("reason");

        String sql = "INSERT INTO adoption_application(pet_id, contact_id, status, application_date) VALUES (?, ?, 'pending', NOW())";

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, petId);
            ps.setInt(2, contactId);
            ps.executeUpdate();
            writeJson(resp, "{\"code\":0,\"msg\":\"提交成功\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            writeJson(resp, "{\"code\":1,\"msg\":\"数据库错误\"}");
        }
    }

    /* 查询全部：GET /adoption?action=list */
    private void listApplication(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=utf-8");
        List<AdoptionApplication> list = new ArrayList<>();
        String sql = "SELECT aa.application_id, aa.pet_id, aa.contact_id, aa.application_date, aa.status, " +
                "p.name AS pet_name, cp.name AS contact_name " +
                "FROM adoption_application aa " +
                "JOIN pet_info p ON aa.pet_id = p.pet_id " +
                "JOIN contact_person cp ON aa.contact_id = cp.contact_id " +
                "ORDER BY aa.application_date DESC";
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AdoptionApplication app = new AdoptionApplication();
                app.setApplicationId(rs.getInt("application_id"));
                app.setPetId(rs.getInt("pet_id"));
                app.setContactId(rs.getInt("contact_id"));
                app.setStatus(rs.getString("status"));
                app.setApplicationDate(rs.getTimestamp("application_date"));

                // 设置关联的宠物信息
                Pet pet = new Pet();
                pet.setPetId(rs.getInt("pet_id"));
                pet.setName(rs.getString("pet_name"));
                app.setPet(pet);

                // 设置关联的联系人信息
                ContactPerson cp = new ContactPerson();
                cp.setContactId(rs.getInt("contact_id"));
                cp.setName(rs.getString("contact_name"));
                app.setContactPerson(cp);

                list.add(app);
            }
            // 转 JSON（偷懒手写，生产请用 gson/jackson）
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < list.size(); i++) {
                AdoptionApplication a = list.get(i);
                json.append("{\"id\":").append(a.getApplicationId())
                        .append(",\"petName\":\"").append(a.getPet() != null ? a.getPet().getName() : "").append('"')
                        .append(",\"contactName\":\"").append(a.getContactPerson() != null ? a.getContactPerson().getName() : "").append('"')
                        .append(",\"status\":\"").append(a.getStatus() != null ? a.getStatus() : "").append('"')
                        .append(",\"applyTime\":\"").append(a.getApplicationDate() != null ? a.getApplicationDate().toString() : "").append("\"}");
                if (i < list.size() - 1) json.append(',');
            }
            json.append(']');
            writeJson(resp, json.toString());
        } catch (SQLException e) {
            e.printStackTrace();
            writeJson(resp, "[]");
        }
    }

    /* 统一出口 */
    private void writeJson(HttpServletResponse resp, String json) throws IOException {
        try (PrintWriter out = resp.getWriter()) {
            out.print(json);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            listApplication(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "缺少参数action");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            addApplication(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "缺少参数action");
        }
    }
}