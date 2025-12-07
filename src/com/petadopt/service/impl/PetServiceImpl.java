package com.petadopt.service.impl;

import com.petadopt.entity.Pet;
import com.petadopt.service.PetService;
import com.petadopt.dao.PetDAO;
import com.petadopt.dao.impl.PetDAOImpl;

import java.util.List;

public class PetServiceImpl implements PetService {
    private PetDAO petDAO = new PetDAOImpl();

    @Override
    public List<Pet> getAllPets() {
        return petDAO.findAll();
    }

    @Override
    public List<Pet> searchPets(String species, String status, String keyword) {
        return petDAO.findByCondition(species, status, keyword);
    }

    @Override
    public Pet getPetById(Integer petId) {
        if (petId == null || petId <= 0) {
            throw new RuntimeException("宠物ID无效！");
        }
        return petDAO.findById(petId);
    }

    @Override
    public boolean addPet(Pet pet) {
        // 业务校验：宠物名称、物种不能为空
        if (pet.getName() == null || pet.getName().isEmpty() ||
                pet.getSpecies() == null || pet.getSpecies().isEmpty()) {
            throw new RuntimeException("宠物名称和物种不能为空！");
        }
        return petDAO.addPet(pet);
    }

    @Override
    public boolean editPet(Pet pet) {
        if (pet.getPetId() == null) {
            throw new RuntimeException("宠物ID不能为空！");
        }
        return petDAO.updatePet(pet);
    }

    @Override
    public boolean deletePet(Integer petId) {
        return petDAO.deletePet(petId);
    }

    @Override
    public boolean changePetStatus(Integer petId, String status) {
        // 校验状态合法性
        if (!"available".equals(status) && !"adopted".equals(status) && !"pending".equals(status)) {
            throw new RuntimeException("状态值无效！");
        }
        return petDAO.updatePetStatus(petId, status);
    }
}