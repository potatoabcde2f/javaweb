package com.petadopt.service.impl;

import com.petadopt.entity.User;
import com.petadopt.service.UserService;
import com.petadopt.dao.UserDAO;
import com.petadopt.dao.impl.UserDAOImpl;

public class UserServiceImpl implements UserService {
    private UserDAO userDAO = new UserDAOImpl();

    @Override
    public User login(String username, String password) {
        // 校验账号密码不为空
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            throw new RuntimeException("账号或密码不能为空！");
        }
        User user = userDAO.login(username, password);
        if (user == null) {
            throw new RuntimeException("账号或密码错误！");
        }
        if ("disabled".equals(user.getStatus())) {
            throw new RuntimeException("账号已被禁用！");
        }
        return user;
    }

    @Override
    public boolean register(User user) {
        // 校验账号密码不为空
        if (user.getUsername() == null || user.getUsername().isEmpty() ||
                user.getPassword() == null || user.getPassword().isEmpty()) {
            throw new RuntimeException("账号或密码不能为空！");
        }
        // 校验账号是否已存在
        if (userDAO.findByUsername(user.getUsername()) != null) {
            throw new RuntimeException("账号已存在！");
        }
        return userDAO.register(user);
    }
}