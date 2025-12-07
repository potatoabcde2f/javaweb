<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>宠物列表 - 宠物领养系统</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <h1>宠物领养列表</h1>
        <div class="user-operate">
            <a href="/user/logout">退出登录</a>
        </div>
    </header>

    <!-- 筛选搜索栏 -->
    <div class="search-bar">
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

    <!-- 宠物卡片列表 -->
    <div class="pet-list">
        <c:forEach items="${petList}" var="pet">
            <div class="pet-card">
                <img src="${pet.imageUrl}" alt="${pet.name}" class="pet-img">
                <div class="pet-info">
                    <h3>${pet.name}</h3>
                    <p>物种：${pet.species} | 品种：${pet.breed}</p>
                    <p>年龄：${pet.age}岁 | 性别：${pet.gender}</p>
                    <p>状态：
                        <c:if test="${pet.status == 'available'}">
                            <span class="status-available">可领养</span>
                        </c:if>
                        <c:if test="${pet.status == 'pending'}">
                            <span class="status-pending">审核中</span>
                        </c:if>
                        <c:if test="${pet.status == 'adopted'}">
                            <span class="status-adopted">已领养</span>
                        </c:if>
                    </p>
                    <a href="/pet/detail?petId=${pet.petId}" class="detail-btn">查看详情</a>
                    <c:if test="${pet.status == 'available'}">
                        <a href="/adoption/toApply?petId=${pet.petId}" class="apply-btn">申请领养</a>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${petList.isEmpty()}">
        <div class="empty-tip">暂无符合条件的宠物</div>
    </c:if>
</div>
</body>
</html>