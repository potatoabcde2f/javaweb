package com.petadopt.dao;

import com.petadopt.entity.ContactPerson;

public interface ContactPersonDAO {
    // 新增联系人（领养申请时）
    boolean addContactPerson(ContactPerson contactPerson);
    // 按ID查询联系人
    ContactPerson findById(Integer contactId);
    // 编辑联系人信息
    boolean updateContactPerson(ContactPerson contactPerson);
}