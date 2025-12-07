package com.petadopt.entity;

public class Pet {
    private Integer petId;         // 对应 pet_id
    private String name;           // 对应 name
    private String species;        // 对应 species（物种：狗/猫）
    private String breed;          // 对应 breed（品种：金毛/英短等）
    private Integer age;           // 对应 age
    private String gender;         // 对应 gender（公/母）
    private String description;    // 对应 description（描述）
    private String imageUrl;       // 对应 image_url（照片路径）
    private String status;         // 对应 status（available/adopted/pending）

    // Getter + Setter
    public Integer getPetId() { return petId; }
    public void setPetId(Integer petId) { this.petId = petId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getSpecies() { return species; }
    public void setSpecies(String species) { this.species = species; }
    public String getBreed() { return breed; }
    public void setBreed(String breed) { this.breed = breed; }
    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}