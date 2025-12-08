package com.petadopt.dao.impl;

import com.petadopt.entity.AdoptionApplication;
import com.petadopt.entity.Pet;
import com.petadopt.entity.ContactPerson;
import com.petadopt.dao.AdoptionApplicationDAO;
import com.petadopt.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdoptionApplicationDAOImpl implements AdoptionApplicationDAO {

    @Override
    public boolean addApplication(AdoptionApplication application) {
        // 只保留 adopt_motive，去掉了 breed_plan
        String sql = "INSERT INTO adoption_application(pet_id, contact_id, application_date, status, adopt_motive) " +
                "VALUES(?, ?, NOW(), ?, ?)";
        return executeUpdate(sql, new Object[]{
                application.getPetId(),
                application.getContactId(),
                application.getStatus(),
                application.getAdoptMotive()
        });
    }

    @Override
    public List<AdoptionApplication> findByContactId(Integer contactId) {
        String sql = "SELECT a.*, p.name as pet_name, c.name as contact_name, c.phone, c.email " +
                "FROM adoption_application a " +
                "LEFT JOIN pet_info p ON a.pet_id = p.pet_id " +
                "LEFT JOIN contact_person c ON a.contact_id = c.contact_id " +
                "WHERE a.contact_id = ? ORDER BY a.application_date DESC";
        return executeQuery(sql, new Object[]{contactId});
    }

    @Override
    public List<AdoptionApplication> findByPetId(Integer petId) {
        String sql = "SELECT a.*, p.name as pet_name, c.name as contact_name, c.phone, c.email " +
                "FROM adoption_application a " +
                "LEFT JOIN pet_info p ON a.pet_id = p.pet_id " +
                "LEFT JOIN contact_person c ON a.contact_id = c.contact_id " +
                "WHERE a.pet_id = ?";
        return executeQuery(sql, new Object[]{petId});
    }

    @Override
    public List<AdoptionApplication> findByStatus(String status) {
        String sql = "SELECT a.*, p.name as pet_name, c.name as contact_name, c.phone, c.email " +
                "FROM adoption_application a " +
                "LEFT JOIN pet_info p ON a.pet_id = p.pet_id " +
                "LEFT JOIN contact_person c ON a.contact_id = c.contact_id " +
                "WHERE a.status = ? ORDER BY a.application_date DESC";
        return executeQuery(sql, new Object[]{status});
    }

    @Override
    public boolean updateApplicationStatus(Integer applicationId, String status) {
        String sql = "UPDATE adoption_application SET status = ? WHERE application_id = ?";
        return executeUpdate(sql, new Object[]{status, applicationId});
    }

    @Override
    public List<AdoptionApplication> findAllApplications() {
        String sql = "SELECT a.*, p.name as pet_name, c.name as contact_name, c.phone, c.email " +
                "FROM adoption_application a " +
                "LEFT JOIN pet_info p ON a.pet_id = p.pet_id " +
                "LEFT JOIN contact_person c ON a.contact_id = c.contact_id " +
                "ORDER BY a.application_date DESC";
        return executeQuery(sql, null);
    }

    @Override
    public AdoptionApplication findById(Integer applicationId) {
        // ✅ 关键：查询详细信息（包含宠物的所有字段和联系人地址）
        String sql = "SELECT a.*, " +
                "p.name as pet_name, p.species, p.breed, p.age, p.gender, p.image_url, p.status as pet_status, " +
                "c.name as contact_name, c.phone, c.email, c.address " +
                "FROM adoption_application a " +
                "LEFT JOIN pet_info p ON a.pet_id = p.pet_id " +
                "LEFT JOIN contact_person c ON a.contact_id = c.contact_id " +
                "WHERE a.application_id = ?";
        List<AdoptionApplication> list = executeQuery(sql, new Object[]{applicationId});
        return list.isEmpty() ? null : list.get(0);
    }

    // --- 核心改动：增强的映射方法 ---
    private List<AdoptionApplication> executeQuery(String sql, Object[] params) {
        List<AdoptionApplication> apps = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i + 1, params[i]);
                }
            }
            rs = pstmt.executeQuery();

            while (rs.next()) {
                AdoptionApplication app = new AdoptionApplication();
                app.setApplicationId(rs.getInt("application_id"));
                app.setPetId(rs.getInt("pet_id"));
                app.setContactId(rs.getInt("contact_id"));
                app.setApplicationDate(rs.getTimestamp("application_date"));
                app.setStatus(rs.getString("status"));

                // 尝试获取 adopt_motive (容错处理)
                try { app.setAdoptMotive(rs.getString("adopt_motive")); } catch (SQLException e) {}

                // --- 映射宠物信息 ---
                Pet pet = new Pet();
                pet.setPetId(rs.getInt("pet_id"));
                try {
                    pet.setName(rs.getString("pet_name"));
                    // 以下字段可能在列表查询中不存在，使用 try-catch 忽略错误
                    pet.setSpecies(rs.getString("species"));
                    pet.setBreed(rs.getString("breed"));
                    pet.setAge(rs.getInt("age"));
                    pet.setGender(rs.getString("gender"));
                    pet.setImageUrl(rs.getString("image_url"));
                    pet.setStatus(rs.getString("pet_status"));
                } catch (SQLException e) { /* 忽略列表页没有查这些字段的情况 */ }
                app.setPet(pet);

                // --- 映射联系人信息 ---
                ContactPerson contact = new ContactPerson();
                contact.setContactId(rs.getInt("contact_id"));
                try {
                    contact.setName(rs.getString("contact_name"));
                    contact.setPhone(rs.getString("phone"));
                    contact.setEmail(rs.getString("email"));
                    contact.setAddress(rs.getString("address")); // 获取地址
                } catch (SQLException e) { /* 忽略 */ }
                app.setContactPerson(contact);

                apps.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return apps;
    }

    private boolean executeUpdate(String sql, Object[] params) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i + 1, params[i]);
                }
            }
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, null);
        }
        return false;
    }
}