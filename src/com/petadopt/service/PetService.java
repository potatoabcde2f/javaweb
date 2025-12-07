package com.petadopt.service;

import com.petadopt.entity.Pet;
import java.util.List;

public interface PetService {
    List<Pet> getAllPets();
    List<Pet> searchPets(String species, String status, String keyword);
    Pet getPetById(Integer petId);
    boolean addPet(Pet pet);
    boolean editPet(Pet pet);
    boolean deletePet(Integer petId);
    boolean changePetStatus(Integer petId, String status);
}