package com.petadopt.entity;

public class User {
    private Integer id;           // 自增主键
    private String username;      // 登录账号
    private String password;      // 登录密码
    private String role;          // 角色（user/admin）
    private String status;        // 状态（normal/disabled）

    // Getter + Setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
