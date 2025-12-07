package com.petadopt.entity;

public class ContactPerson {
    private Integer contactId;     // 对应 contact_id
    private String name;           // 对应 name（联系人姓名）
    private String phone;          // 对应 phone（联系电话）
    private String email;          // 对应 email（邮箱）
    private String address;        // 对应 address（地址）

    // Getter + Setter
    public Integer getContactId() { return contactId; }
    public void setContactId(Integer contactId) { this.contactId = contactId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public void setId(int contactId) {

    }
}