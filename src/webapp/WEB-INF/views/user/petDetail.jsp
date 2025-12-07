<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${pet.name} - 宠物详情</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <a href="/pet/list" class="back-btn">返回列表</a>
        <h1>宠物详情</h1>
    </header>

    <div class="pet-detail">
        <div class="pet-img-box">
            <img src="${pet.imageUrl}" alt="${pet.name}" class="detail-img">
        </div>
        <div class="pet-detail-info">
            <h2>${pet.name}</h2>
            <div class="info-item">
                <span class="label">物种：</span>
                <span class="value">${pet.species}</span>
            </div>
            <div class="info-item">
                <span class="label">品种：</span>
                <span class="value">${pet.breed}</span>
            </div>
            <div class="info-item">
                <span class="label">年龄：</span>
                <span class="value">${pet.age}岁</span>
            </div>
            <div class="info-item">
                <span class="label">性别：</span>
                <span class="value">${pet.gender}</span>
            </div>
            <div class="info-item">
                <span class="label">状态：</span>
                <span class="value">
                    <c:if test="${pet.status == 'available'}">
                        <span class="status-available">可领养</span>
                    </c:if>
                    <c:if test="${pet.status == 'pending'}">
                        <span class="status-pending">审核中</span>
                    </c:if>
                    <c:if test="${pet.status == 'adopted'}">
                        <span class="status-adopted">已领养</span>
                    </c:if>
                </span>
            </div>
            <div class="info-item">
                <span class="label">详细描述：</span>
                <span class="value desc">${pet.description}</span>
            </div>
            <div class="btn-group">
                <c:if test="${pet.status == 'available'}">
                    <a href="/adoption/toApply?petId=${pet.petId}" class="apply-btn">申请领养</a>
                </c:if>
                <a href="/pet/list" class="back-btn">返回列表</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>