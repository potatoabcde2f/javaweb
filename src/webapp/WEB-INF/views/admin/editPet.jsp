<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>编辑宠物</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="admin-container">
    <header class="admin-header">
        <h1>后台管理</h1>
        <div class="admin-operate">
            <a href="${pageContext.request.contextPath}/user/logout" class="btn cancel-btn" style="border: none; padding: 0;">退出</a>
        </div>
    </header>

    <div class="admin-body">
        <div class="admin-sidebar">
            <ul class="menu-list">
                <li><a href="${pageContext.request.contextPath}/admin/index" class="menu-item">数据概览</a></li>
                <li><a href="${pageContext.request.contextPath}/pet/list" class="menu-item active">宠物信息</a></li>
                <li><a href="${pageContext.request.contextPath}/adoption/manage" class="menu-item">领养审核</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/statistics" class="menu-item">统计报表</a></li>
            </ul>
        </div>

        <div class="admin-content">
            <div class="content-header">
                <h2>编辑档案 #${pet.petId}</h2>
                <a href="${pageContext.request.contextPath}/pet/list" class="btn cancel-btn">返回列表</a>
            </div>

            <div class="form-box" style="max-width: 800px;">
                <form action="${pageContext.request.contextPath}/pet/edit" method="post">
                    <input type="hidden" name="petId" value="${pet.petId}">

                    <div class="form-group">
                        <label>宠物昵称</label>
                        <input type="text" name="name" required value="${pet.name}">
                    </div>
                    <div class="form-group">
                        <label>物种</label>
                        <select name="species" required>
                            <option value="狗" ${pet.species == '狗' ? 'selected' : ''}>狗</option>
                            <option value="猫" ${pet.species == '猫' ? 'selected' : ''}>猫</option>
                            <option value="其他" ${pet.species == '其他' ? 'selected' : ''}>其他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>品种</label>
                        <input type="text" name="breed" value="${pet.breed}">
                    </div>
                    <div class="form-group">
                        <label>年龄</label>
                        <input type="number" name="age" min="0" required value="${pet.age}">
                    </div>
                    <div class="form-group">
                        <label>性别</label>
                        <select name="gender" required>
                            <option value="公" ${pet.gender == '公' ? 'selected' : ''}>公</option>
                            <option value="母" ${pet.gender == '母' ? 'selected' : ''}>母</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>照片 URL</label>
                        <input type="text" name="imageUrl" required value="${pet.imageUrl}">
                    </div>
                    <div class="form-group">
                        <label>状态</label>
                        <select name="status" required>
                            <option value="available" ${pet.status == 'available' ? 'selected' : ''}>可领养</option>
                            <option value="pending" ${pet.status == 'pending' ? 'selected' : ''}>审核中</option>
                            <option value="adopted" ${pet.status == 'adopted' ? 'selected' : ''}>已领养</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>详细描述</label>
                        <textarea name="description" rows="5" required>${pet.description}</textarea>
                    </div>

                    <div style="margin-top: 30px;">
                        <button type="submit" class="primary-solid">保存修改</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>