package com.petadopt.service;

import com.petadopt.entity.AdoptionApplication;
import com.petadopt.entity.ContactPerson;
import java.util.List;

public interface AdoptionService {
    // 提交领养申请（关联联系人+申请记录）
    boolean submitApplication(ContactPerson contactPerson, AdoptionApplication application);
    // 查询个人领养申请
    List<AdoptionApplication> getMyApplications(Integer contactId);
    // 管理员查询所有申请
    List<AdoptionApplication> getAllApplications();
    // 按状态查询申请
    List<AdoptionApplication> getApplicationsByStatus(String status);
    // 审核申请（通过/拒绝）
    boolean reviewApplication(Integer applicationId, String status, Integer petId);
}