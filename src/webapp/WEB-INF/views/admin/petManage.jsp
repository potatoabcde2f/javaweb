<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>宠物管理 - 管理员后台</title>
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
            <h2>宠物管理</h2>
            <a href="/pet/toAdd" class="add-btn">新增宠物</a>
        </div>

        <!-- 筛选搜索栏 -->
        <div class="search-bar admin-search">
            <form action="/pet/search" method="post">
                <select name="species">
                    <option value="">全部物种</option>
                    <option value="狗" ${species == '狗' ? 'selected' : ''}>狗</option>
                    <option value="猫" ${species == '猫' ? 'selected' : ''}>猫</option>
                    <option value="其他" ${species == '其他' ? 'selected' : ''}>其他</option>
                </select>
                <select name="status">
                    <option value="">全部状态</option>
                    <option value="available" ${status == 'available' ? 'selected' : ''}>可领养</option>
                    <option value="pending" ${status == 'pending' ? 'selected' : ''}>审核中</option>
                    <option value="adopted" ${status == 'adopted' ? 'selected' : ''}>已领养</option>
                </select>
                <input type="text" name="keyword" placeholder="搜索宠物名称/品种" value="${keyword}">
                <button type="submit">搜索</button>
            </form>
        </div>

        <!-- 宠物列表表格 -->
        <div class="table-box">
            <table class="data-table">
                <thead>
                <tr>
                    <th>宠物ID</th>
                    <th>名称</th>
                    <th>物种</th>
                    <th>品种</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${petList}" var="pet">
                    <tr>
                        <td>${pet.petId}</td>
                        <td>${pet.name}</td>
                        <td>${pet.species}</td>
                        <td>${pet.breed}</td>
                        <td>${pet.age}岁</td>
                        <td>${pet.gender}</td>
                        <td>
                            <c:if test="${pet.status == 'available'}">
                                <span class="status-available">可领养</span>
                            </c:if>
                            <c:if test="${pet.status == 'pending'}">
                                <span class="status-pending">审核中</span>
                            </c:if>
                            <c:if test="${pet.status == 'adopted'}">
                                <span class="status-adopted">已领养</span>
                            </c:if>
                        </td>
                        <td class="operate-col">
                            <a href="/pet/toEdit?petId=${pet.petId}" class="edit-btn">编辑</a>
                            <a href="/pet/delete?petId=${pet.petId}" class="delete-btn" onclick="return confirm('确定要删除该宠物吗？')">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${petList.isEmpty()}">
            <div class="empty-tip">暂无符合条件的宠物</div>
        </c:if>
    </div>
</div>
</body>
</html>