package com.petadopt.dao.impl;

import com.petadopt.entity.ContactPerson;
import com.petadopt.dao.ContactPersonDAO;
import com.petadopt.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ContactPersonDAOImpl implements ContactPersonDAO {

    @Override
    public boolean addContactPerson(ContactPerson contactPerson) {
        String sql = "INSERT INTO contact_person(name, phone, email, address) VALUES(?, ?, ?, ?)";
        return executeUpdate(sql, new Object[]{
                contactPerson.getName(), contactPerson.getPhone(),
                contactPerson.getEmail(), contactPerson.getAddress()
        });
    }

    @Override
    public ContactPerson findById(Integer contactId) {
        String sql = "SELECT * FROM contact_person WHERE contact_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, contactId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                ContactPerson cp = new ContactPerson();
                cp.setContactId(rs.getInt("contact_id"));
                cp.setName(rs.getString("name"));
                cp.setPhone(rs.getString("phone"));
                cp.setEmail(rs.getString("email"));
                cp.setAddress(rs.getString("address"));
                return cp;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return null;
    }

    @Override
    public boolean updateContactPerson(ContactPerson contactPerson) {
        String sql = "UPDATE contact_person SET name=?, phone=?, email=?, address=? WHERE contact_id = ?";
        return executeUpdate(sql, new Object[]{
                contactPerson.getName(), contactPerson.getPhone(),
                contactPerson.getEmail(), contactPerson.getAddress(),
                contactPerson.getContactId()
        });
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