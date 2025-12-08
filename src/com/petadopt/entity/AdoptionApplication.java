package com.petadopt.entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class AdoptionApplication implements Serializable {
    private Integer applicationId;
    private Integer petId;
    private Integer contactId;
    private Timestamp applicationDate;
    private String status;

    // --- ✅ 只保留这一个 ---
    private String adoptMotive; // 领养动机
    // ❌ 删除 private String breedPlan;

    /* 关联对象 */
    private Pet pet;
    private ContactPerson contactPerson;

    // --- Getter 和 Setter (省略前面的) ---
    // ... 前面的 getId, setPetId 等保持不变 ...

    // --- ✅ 只保留 adoptMotive 的 Getter/Setter ---
    public String getAdoptMotive() { return adoptMotive; }
    public void setAdoptMotive(String adoptMotive) { this.adoptMotive = adoptMotive; }

    // ❌ 删除 getBreedPlan() 和 setBreedPlan() 方法

    // ... 后面的 getPet, getContactPerson 等保持不变 ...
    public Integer getApplicationId() { return applicationId; }
    public void setApplicationId(Integer applicationId) { this.applicationId = applicationId; }
    public Integer getPetId() { return petId; }
    public void setPetId(Integer petId) { this.petId = petId; }
    public Integer getContactId() { return contactId; }
    public void setContactId(Integer contactId) { this.contactId = contactId; }
    public Timestamp getApplicationDate() { return applicationDate; }
    public void setApplicationDate(Timestamp applicationDate) { this.applicationDate = applicationDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Pet getPet() { return pet; }
    public void setPet(Pet pet) { this.pet = pet; }
    public ContactPerson getContactPerson() { return contactPerson; }
    public void setContactPerson(ContactPerson contactPerson) { this.contactPerson = contactPerson; }
}