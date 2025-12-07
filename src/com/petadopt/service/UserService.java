package com.petadopt.service;

import com.petadopt.entity.User;

public interface UserService {
    User login(String username, String password);
    boolean register(User user);
}