<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>宠物管理 - 管理员后台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body style="background-color: #f1f5f9;">

<div class="admin-container">
    <header class="admin-header">
        <h1><i class="fas fa-shield-alt"></i> 宠物领养系统</h1>
        <div class="admin-operate">
            <span>管理员</span>
            <a href="${pageContext.request.contextPath}/user/logout" class="btn cancel-btn" style="padding: 4px 12px;">退出</a>
        </div>
    </header>

    <div class="admin-body">
        <div class="admin-sidebar">
            <ul class="menu-list">
                <li><a href="${pageContext.request.contextPath}/admin/index" class="menu-item"><i class="fas fa-tachometer-alt fa-fw"></i> 数据概览</a></li>
                <li><a href="${pageContext.request.contextPath}/pet/list" class="menu-item active"><i class="fas fa-dog fa-fw"></i> 宠物管理</a></li>
                <li><a href="${pageContext.request.contextPath}/adoption/manage" class="menu-item"><i class="fas fa-file-contract fa-fw"></i> 领养审核</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/statistics" class="menu-item"><i class="fas fa-chart-pie fa-fw"></i> 统计分析</a></li>
            </ul>
        </div>

        <div class="admin-content">
            <div class="content-header">
                <h2>宠物管理</h2>
                <a href="${pageContext.request.contextPath}/pet/toAdd" class="add-btn">
                    <i class="fas fa-plus"></i> 新增宠物
                </a>
            </div>

            <div class="search-bar" style="margin-bottom: 20px;">
                <form action="${pageContext.request.contextPath}/pet/search" method="post">
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
                    <input type="text" name="keyword" placeholder="搜索..." value="${keyword}">
                    <button type="submit"><i class="fas fa-search"></i> 筛选</button>
                </form>
            </div>

            <div class="table-box">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th style="width: 60px;">ID</th
                        <th style="width: 80px;">图片</th>
                        <th>名称</th>
                        <th>信息</th>
                        <th>状态</th>
                        <th style="width: 180px;">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${petList}" var="pet">
                        <tr>
                            <td>${pet.petId}</td>
                            <td>
                                <img src="${pet.imageUrl}" onerror="this.src='https://placehold.co/100x100?text=No+Img'"
                                     style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;">
                            </td>
                            <td style="font-weight: 600;">${pet.name}</td>
                            <td style="color: var(--text-secondary); font-size: 0.9rem;">
                                    ${pet.species} / ${pet.breed} / ${pet.gender} / ${pet.age}岁
                            </td>
                            <td>
                                <c:if test="${pet.status == 'available'}"><span class="status-available">可领养</span></c:if>
                                <c:if test="${pet.status == 'pending'}"><span class="status-pending">审核中</span></c:if>
                                <c:if test="${pet.status == 'adopted'}"><span class="status-adopted">已领养</span></c:if>
                            </td>
                            <td class="operate-col">
                                <a href="${pageContext.request.contextPath}/pet/toEdit?petId=${pet.petId}" class="edit-btn" style="padding: 4px 10px; font-size: 0.85rem;">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/pet/delete?petId=${pet.petId}"
                                   class="delete-btn"
                                   onclick="return confirm('确定要删除该宠物吗？')"
                                   style="padding: 4px 10px; font-size: 0.85rem;">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${petList.isEmpty()}">
                <div class="empty-tip" style="text-align: center; padding: 40px; color: var(--text-secondary);">
                    暂无数据
                </div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>