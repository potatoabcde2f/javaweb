<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>编辑宠物 - 管理员后台</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="admin-container">
    <header class="admin-header">
        <h1>宠物领养系统 - 管理后台</h1>
        <div class="admin-operate">
            <span>欢迎您，管理员</span>
            <a href="/user/logout">退出登录</a>
        </div>
    </header>

    <div class="admin-sidebar">
        <ul class="menu-list">
            <li><a href="/admin/index" class="menu-item">数据概览</a></li>
            <li><a href="/pet/list" class="menu-item active">宠物管理</a></li>
            <li><a href="/adoption/manage" class="menu-item">领养申请管理</a></li>
            <li><a href="/admin/statistics" class="menu-item">统计分析</a></li>
        </ul>
    </div>

    <div class="admin-content">
        <div class="content-header">
            <h2>编辑宠物</h2>
            <a href="/pet/list" class="back-btn">返回列表</a>
        </div>

        <div class="form-box">
            <form action="/pet/edit" method="post">
                <input type="hidden" name="petId" value="${pet.petId}">
                <div class="form-group">
                    <label>宠物名称：</label>
                    <input type="text" name="name" required placeholder="请输入宠物名称" value="${pet.name}">
                </div>
                <div class="form-group">
                    <label>物种：</label>
                    <select name="species" required>
                        <option value="狗" ${pet.species == '狗' ? 'selected' : ''}>狗</option>
                        <option value="猫" ${pet.species == '猫' ? 'selected' : ''}>猫</option>
                        <option value="其他" ${pet.species == '其他' ? 'selected' : ''}>其他</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>品种：</label>
                    <input type="text" name="breed" placeholder="请输入宠物品种（可选）" value="${pet.breed}">
                </div>
                <div class="form-group">
                    <label>年龄：</label>
                    <input type="number" name="age" min="0" required placeholder="请输入宠物年龄（单位：岁）" value="${pet.age}">
                </div>
                <div class="form-group">
                    <label>性别：</label>
                    <select name="gender" required>
                        <option value="公" ${pet.gender == '公' ? 'selected' : ''}>公</option>
                        <option value="母" ${pet.gender == '母' ? 'selected' : ''}>母</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>宠物描述：</label>
                    <textarea name="description" rows="5" required placeholder="请输入宠物的性格、健康状况等详细描述">${pet.description}</textarea>
                </div>
                <div class="form-group">
                    <label>照片URL：</label>
                    <input type="text" name="imageUrl" required placeholder="请输入宠物照片的网络URL" value="${pet.imageUrl}">
                    <span class="tips">提示：可使用Unsplash等免费图片网站的图片URL</span>
                </div>
                <div class="form-group">
                    <label>状态：</label>
                    <select name="status" required>
                        <option value="available" ${pet.status == 'available' ? 'selected' : ''}>可领养</option>
                        <option value="pending" ${pet.status == 'pending' ? 'selected' : ''}>审核中</option>
                        <option value="adopted" ${pet.status == 'adopted' ? 'selected' : ''}>已领养</option>
                    </select>
                </div>
                <div class="error-msg">${errorMsg}</div>
                <div class="btn-group">
                    <button type="submit">保存修改</button>
                    <a href="/pet/list" class="cancel-btn">取消</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>