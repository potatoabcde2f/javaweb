package com.petadopt.service.impl;

import com.petadopt.entity.AdoptionApplication;
import com.petadopt.entity.ContactPerson;
import com.petadopt.service.AdoptionService;
import com.petadopt.dao.AdoptionApplicationDAO;
import com.petadopt.dao.ContactPersonDAO;
import com.petadopt.dao.PetDAO;
import com.petadopt.dao.impl.AdoptionApplicationDAOImpl;
import com.petadopt.dao.impl.ContactPersonDAOImpl;
import com.petadopt.dao.impl.PetDAOImpl;
import com.petadopt.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class AdoptionServiceImpl implements AdoptionService {
    private ContactPersonDAO contactDAO = new ContactPersonDAOImpl();
    private AdoptionApplicationDAO appDAO = new AdoptionApplicationDAOImpl();
    private PetDAO petDAO = new PetDAOImpl();

    @Override
    public boolean submitApplication(ContactPerson contactPerson, AdoptionApplication application) {
        if (contactPerson.getName() == null || contactPerson.getPhone() == null) {
            throw new RuntimeException("联系人姓名和电话不能为空！");
        }
        if (application.getPetId() == null) {
            throw new RuntimeException("领养宠物ID不能为空！");
        }

        boolean contactSuccess = contactDAO.addContactPerson(contactPerson);
        if (contactSuccess) {
            ContactPerson cp = getContactByPhone(contactPerson.getPhone());
            application.setContactId(cp.getContactId());
            application.setStatus("pending");
            return appDAO.addApplication(application);
        }
        return false;
    }

    @Override
    public List<AdoptionApplication> getMyApplications(Integer contactId) {
        if (contactId == null) {
            throw new RuntimeException("联系人ID不能为空！");
        }
        return appDAO.findByContactId(contactId);
    }

    @Override
    public List<AdoptionApplication> getAllApplications() {
        return appDAO.findAllApplications();
    }

    @Override
    public List<AdoptionApplication> getApplicationsByStatus(String status) {
        if (status == null) {
            throw new RuntimeException("状态不能为空！");
        }
        return appDAO.findByStatus(status);
    }

    @Override
    public boolean reviewApplication(Integer applicationId, String status, Integer petId) {
        if ("approved".equals(status)) {
            boolean appSuccess = appDAO.updateApplicationStatus(applicationId, status);
            if (appSuccess) {
                return petDAO.updatePetStatus(petId, "adopted");
            }
            return false;
        } else if ("rejected".equals(status)) {
            return appDAO.updateApplicationStatus(applicationId, status);
        } else {
            throw new RuntimeException("审核状态无效！");
        }
    }

    // --- ✅ 新增实现 ---
    @Override
    public AdoptionApplication getApplicationById(Integer applicationId) {
        if (applicationId == null) {
            throw new RuntimeException("申请ID不能为空！");
        }
        return appDAO.findById(applicationId);
    }

    private ContactPerson getContactByPhone(String phone) {
        String sql = "SELECT * FROM contact_person WHERE phone = ? ORDER BY contact_id DESC LIMIT 1";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, phone);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                ContactPerson cp = new ContactPerson();
                cp.setContactId(rs.getInt("contact_id"));
                return cp;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        throw new RuntimeException("联系人创建失败！");
    }
}