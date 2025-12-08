package com.petadopt.dao;

import com.petadopt.entity.AdoptionApplication;
import java.util.List;

public interface AdoptionApplicationDAO {
    // 提交领养申请
    boolean addApplication(AdoptionApplication application);
    // 按联系人ID查询申请（普通用户）
    List<AdoptionApplication> findByContactId(Integer contactId);
    // 按宠物ID查询申请
    List<AdoptionApplication> findByPetId(Integer petId);
    // 按状态查询申请（管理员）
    List<AdoptionApplication> findByStatus(String status);
    // 审核申请（更新状态）
    boolean updateApplicationStatus(Integer applicationId, String status);
    // 查询所有申请（管理员）
    List<AdoptionApplication> findAllApplications();

    // --- ✅ 新增：按ID查询详情 ---
    AdoptionApplication findById(Integer applicationId);
}