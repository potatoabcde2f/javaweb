<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>宠物管理</title>
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
                <h2>宠物信息</h2>
                <a href="${pageContext.request.contextPath}/pet/toAdd" class="btn primary-solid">
                    <i class="fas fa-plus"></i> 新增
                </a>
            </div>

            <div class="search-bar" style="margin-bottom: 30px; border-bottom: none; padding: 0;">
                <form action="${pageContext.request.contextPath}/pet/search" method="post">
                    <select name="species">
                        <option value="">物种</option>
                        <option value="狗" ${species == '狗' ? 'selected' : ''}>狗</option>
                        <option value="猫" ${species == '猫' ? 'selected' : ''}>猫</option>
                        <option value="其他" ${species == '其他' ? 'selected' : ''}>其他</option>
                    </select>
                    <select name="status">
                        <option value="">状态</option>
                        <option value="available" ${status == 'available' ? 'selected' : ''}>可领养</option>
                        <option value="pending" ${status == 'pending' ? 'selected' : ''}>审核中</option>
                        <option value="adopted" ${status == 'adopted' ? 'selected' : ''}>已领养</option>
                    </select>
                    <input type="text" name="keyword" placeholder="关键词..." value="${keyword}">
                    <button type="submit" class="btn">筛选</button>
                </form>
            </div>

            <div class="table-box">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th style="width: 50px;">ID</th>
                        <th style="width: 70px;"></th>
                        <th>名称</th>
                        <th>基本信息</th>
                        <th>当前状态</th>
                        <th style="text-align: right;">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${petList}" var="pet">
                        <tr>
                            <td>${pet.petId}</td>
                            <td>
                                <img src="${pet.imageUrl}" onerror="this.src='https://placehold.co/100x100?text=Img'"
                                     style="width: 36px; height: 36px; border-radius: 50%; object-fit: cover;">
                            </td>
                            <td style="font-family: 'Noto Serif SC', serif; font-size: 1.05rem;">${pet.name}</td>
                            <td style="color: var(--zen-gray); font-size: 0.9rem;">
                                    ${pet.species} / ${pet.breed} / ${pet.gender}
                            </td>
                            <td>
                                <c:if test="${pet.status == 'available'}"><span class="status-available">可领养</span></c:if>
                                <c:if test="${pet.status == 'pending'}"><span class="status-pending">审核中</span></c:if>
                                <c:if test="${pet.status == 'adopted'}"><span class="status-adopted">已领养</span></c:if>
                            </td>
                            <td style="text-align: right;">
                                <a href="${pageContext.request.contextPath}/pet/toEdit?petId=${pet.petId}" class="edit-btn" style="border: none; padding: 5px;">
                                    <i class="fas fa-pen"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/pet/delete?petId=${pet.petId}"
                                   class="delete-btn"
                                   onclick="return confirm('确认删除？')"
                                   style="border: none; padding: 5px; color: #999;">
                                    <i class="fas fa-times"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${petList.isEmpty()}">
                <div class="empty-tip">空</div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>