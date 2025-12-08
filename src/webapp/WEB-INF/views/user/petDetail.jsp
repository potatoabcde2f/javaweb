<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${pet.name} - 宠物详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="container">
    <header class="header">
        <a href="${pageContext.request.contextPath}/pet/list" class="back-btn">
            <i class="fas fa-arrow-left"></i> 返回列表
        </a>
    </header>

    <div class="pet-detail">
        <div class="pet-img-box">
            <img src="${pet.imageUrl}"
                 alt="${pet.name}"
                 class="detail-img"
                 onerror="this.src='https://placehold.co/800x600/e2e8f0/1e293b?text=Pet+Image';">
        </div>

        <div class="pet-detail-info form-box" style="border: none; box-shadow: none; padding: 0;">
            <h2 style="font-size: 2rem; margin-bottom: 20px;">${pet.name}</h2>

            <div style="margin-bottom: 20px;">
                <c:if test="${pet.status == 'available'}">
                    <span class="status-available" style="font-size: 1rem; padding: 6px 12px;">✨ 当前可领养</span>
                </c:if>
                <c:if test="${pet.status == 'pending'}">
                    <span class="status-pending" style="font-size: 1rem; padding: 6px 12px;">⏳ 审核中</span>
                </c:if>
                <c:if test="${pet.status == 'adopted'}">
                    <span class="status-adopted" style="font-size: 1rem; padding: 6px 12px;">🏠 已被领养</span>
                </c:if>
            </div>

            <div class="info-item">
                <span class="label">物种</span>
                <span class="value">${pet.species}</span>
            </div>
            <div class="info-item">
                <span class="label">品种</span>
                <span class="value">${pet.breed}</span>
            </div>
            <div class="info-item">
                <span class="label">年龄</span>
                <span class="value">${pet.age} 岁</span>
            </div>
            <div class="info-item">
                <span class="label">性别</span>
                <span class="value">${pet.gender}</span>
            </div>

            <div style="margin-top: 20px;">
                <label style="color: var(--text-secondary); font-weight: 500; display: block; margin-bottom: 8px;">关于TA</label>
                <p style="line-height: 1.8; color: var(--text-main); background: #f9fafb; padding: 15px; border-radius: 8px;">
                    ${pet.description}
                </p>
            </div>

            <div style="margin-top: 30px;">
                <c:if test="${pet.status == 'available'}">
                    <a href="${pageContext.request.contextPath}/adoption/toApply?petId=${pet.petId}" class="apply-btn" style="padding: 12px 30px; font-size: 1.1rem;">
                        <i class="fas fa-heart" style="margin-right: 8px;"></i> 申请领养
                    </a>
                </c:if>
                <c:if test="${pet.status != 'available'}">
                    <button disabled style="background-color: #ccc; cursor: not-allowed; padding: 12px 30px;">暂不可申请</button>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>