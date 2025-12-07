package com.petadopt.dao;

import com.petadopt.entity.Pet;
import java.util.List;

public interface PetDAO {
    // 查询所有宠物
    List<Pet> findAll();
    // 按条件筛选（物种、状态、关键词）
    List<Pet> findByCondition(String species, String status, String keyword);
    // 按ID查询宠物
    Pet findById(Integer petId);
    // 新增宠物（管理员）
    boolean addPet(Pet pet);
    // 编辑宠物（管理员）
    boolean updatePet(Pet pet);
    // 删除宠物（管理员）
    boolean deletePet(Integer petId);
    // 更新宠物领养状态
    boolean updatePetStatus(Integer petId, String status);
}