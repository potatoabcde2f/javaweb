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

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class AdoptionServiceImpl implements AdoptionService {
    private ContactPersonDAO contactDAO = new ContactPersonDAOImpl();
    private AdoptionApplicationDAO appDAO = new AdoptionApplicationDAOImpl();
    private PetDAO petDAO = new PetDAOImpl();

    @Override
    public boolean submitApplication(ContactPerson contactPerson, AdoptionApplication application) {
        // 业务校验
        if (contactPerson.getName() == null || contactPerson.getPhone() == null) {
            throw new RuntimeException("联系人姓名和电话不能为空！");
        }
        if (application.getPetId() == null) {
            throw new RuntimeException("领养宠物ID不能为空！");
        }

        // 先新增联系人，获取contactId后关联申请
        boolean contactSuccess = contactDAO.addContactPerson(contactPerson);
        if (contactSuccess) {
            // 查询刚新增的联系人（按姓名+电话查询，简化处理）
            ContactPerson cp = getContactByPhone(contactPerson.getPhone());
            application.setContactId(cp.getContactId());
            application.setStatus("pending"); // 默认待审核
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
        // 审核通过：更新申请状态+更新宠物状态为adopted
        if ("approved".equals(status)) {
            // 先更新申请状态
            boolean appSuccess = appDAO.updateApplicationStatus(applicationId, status);
            if (appSuccess) {
                // 再更新宠物状态
                return petDAO.updatePetStatus(petId, "adopted");
            }
            return false;
        } else if ("rejected".equals(status)) {
            // 审核拒绝：仅更新申请状态，宠物状态不变
            return appDAO.updateApplicationStatus(applicationId, status);
        } else {
            throw new RuntimeException("审核状态无效！");
        }
    }

    // 辅助方法：按电话查询联系人（获取最新新增的联系人ID）
    private ContactPerson getContactByPhone(String phone) {
        String sql = "SELECT * FROM contact_person WHERE phone = ? ORDER BY contact_id DESC LIMIT 1";
        Connection conn = null;
        java.sql.PreparedStatement pstmt = null;
        java.sql.ResultSet rs = null;

        try {
            conn = com.petadopt.util.JDBCUtil.getConnection();
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
            com.petadopt.util.JDBCUtil.close(conn, pstmt, rs);
        }
        throw new RuntimeException("联系人创建失败！");
    }
}