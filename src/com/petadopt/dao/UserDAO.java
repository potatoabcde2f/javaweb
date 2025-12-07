package com.petadopt.dao;

import com.petadopt.entity.User;

public interface UserDAO {
    // 登录（按账号密码查询）
    User login(String username, String password);
    // 注册（新增普通用户）
    boolean register(User user);
    // 按账号查询用户（判断是否已存在）
    User findByUsername(String username);
}