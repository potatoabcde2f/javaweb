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
        String sql = "INSERT INTO adoption_application(pet_id, contact_id, application_date, status) " +
                "VALUES(?, ?, NOW(), ?)";
        return executeUpdate(sql, new Object[]{
                application.getPetId(), 
                application.getContactId(),
                application.getStatus()
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
        String sql = "INSERT INTO adoption_application(pet_id, contact_id, application_date, status, adopt_motive) " +
                "VALUES(?, ?, NOW(), ?, ?)";
        return executeQuery(sql, null);
    }

    // 通用查询方法
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
                app.setAdoptMotive(rs.getString("adopt_motive"));
                
                // 设置关联的宠物信息
                if (rs.getString("pet_name") != null) {
                    Pet pet = new Pet();
                    pet.setPetId(rs.getInt("pet_id"));
                    pet.setName(rs.getString("pet_name"));
                    app.setPet(pet);
                }
                
                // 设置关联的联系人信息
                if (rs.getString("contact_name") != null) {
                    ContactPerson contact = new ContactPerson();
                    contact.setContactId(rs.getInt("contact_id"));
                    contact.setName(rs.getString("contact_name"));
                    contact.setPhone(rs.getString("phone"));
                    contact.setEmail(rs.getString("email"));
                    app.setContactPerson(contact);
                }
                
                apps.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return apps;
    }

    // 通用增删改方法
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