package com.petadopt.dao.impl;

import com.petadopt.entity.Pet;
import com.petadopt.dao.PetDAO;
import com.petadopt.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PetDAOImpl implements PetDAO {

    @Override
    public List<Pet> findAll() {
        String sql = "SELECT * FROM pet_info ORDER BY pet_id DESC";
        return executeQuery(sql, null);
    }

    @Override
    public List<Pet> findByCondition(String species, String status, String keyword) {
        StringBuilder sql = new StringBuilder("SELECT * FROM pet_info WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // 拼接筛选条件
        if (species != null && !species.isEmpty()) {
            sql.append(" AND species = ?");
            params.add(species);
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (name LIKE ? OR breed LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        return executeQuery(sql.toString(), params.toArray());
    }

    @Override
    public Pet findById(Integer petId) {
        String sql = "SELECT * FROM pet_info WHERE pet_id = ?";
        List<Pet> pets = executeQuery(sql, new Object[]{petId});
        return pets.isEmpty() ? null : pets.get(0);
    }

    @Override
    public boolean addPet(Pet pet) {
        String sql = "INSERT INTO pet_info(name, species, breed, age, gender, description, image_url, status) " +
                "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        return executeUpdate(sql, new Object[]{
                pet.getName(), pet.getSpecies(), pet.getBreed(), pet.getAge(),
                pet.getGender(), pet.getDescription(), pet.getImageUrl(), pet.getStatus()
        });
    }

    @Override
    public boolean updatePet(Pet pet) {
        String sql = "UPDATE pet_info SET name=?, species=?, breed=?, age=?, gender=?, description=?, image_url=?, status=? " +
                "WHERE pet_id = ?";
        return executeUpdate(sql, new Object[]{
                pet.getName(), pet.getSpecies(), pet.getBreed(), pet.getAge(),
                pet.getGender(), pet.getDescription(), pet.getImageUrl(), pet.getStatus(),
                pet.getPetId()
        });
    }

    @Override
    public boolean deletePet(Integer petId) {
        String sql = "DELETE FROM pet_info WHERE pet_id = ?";
        return executeUpdate(sql, new Object[]{petId});
    }

    @Override
    public boolean updatePetStatus(Integer petId, String status) {
        String sql = "UPDATE pet_info SET status = ? WHERE pet_id = ?";
        return executeUpdate(sql, new Object[]{status, petId});
    }

    // 通用查询方法
    private List<Pet> executeQuery(String sql, Object[] params) {
        List<Pet> pets = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            // 设置参数
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i + 1, params[i]);
                }
            }
            rs = pstmt.executeQuery();

            // 封装结果集
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetId(rs.getInt("pet_id"));
                pet.setName(rs.getString("name"));
                pet.setSpecies(rs.getString("species"));
                pet.setBreed(rs.getString("breed"));
                pet.setAge(rs.getInt("age"));
                pet.setGender(rs.getString("gender"));
                pet.setDescription(rs.getString("description"));
                pet.setImageUrl(rs.getString("image_url"));
                pet.setStatus(rs.getString("status"));
                pets.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return pets;
    }

    // 通用增删改方法
    private boolean executeUpdate(String sql, Object[] params) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i + 1, params[i]);
                }
            }
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, null);
        }
        return false;
    }
}