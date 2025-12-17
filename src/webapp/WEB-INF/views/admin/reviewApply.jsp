<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>审核详情</title>
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
                <li><a href="${pageContext.request.contextPath}/pet/list" class="menu-item">宠物信息</a></li>
                <li><a href="${pageContext.request.contextPath}/adoption/manage" class="menu-item active">领养审核</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/statistics" class="menu-item">统计报表</a></li>
            </ul>
        </div>

        <div class="admin-content">
            <div class="content-header">
                <h2>申请详情 #${app.applicationId}</h2>
                <a href="${pageContext.request.contextPath}/adoption/manage" class="btn cancel-btn">返回列表</a>
            </div>

            <div class="form-box" style="max-width: 900px; display: grid; grid-template-columns: 1fr 1fr; gap: 40px;">
                <div>
                    <h3 style="border-bottom: 1px solid #CCC; padding-bottom: 10px; margin-bottom: 20px;">申请信息</h3>
                    <div class="form-group">
                        <label>申请人</label>
                        <p>${app.contactPerson.name}</p>
                    </div>
                    <div class="form-group">
                        <label>联系电话</label>
                        <p>${app.contactPerson.phone}</p>
                    </div>
                    <div class="form-group">
                        <label>邮箱</label>
                        <p>${app.contactPerson.email}</p>
                    </div>
                    <div class="form-group">
                        <label>居住地址</label>
                        <p>${app.contactPerson.address}</p>
                    </div>
                    <div class="form-group">
                        <label>目标宠物</label>
                        <div style="display: flex; align-items: center; gap: 15px; margin-top: 10px;">
                            <img src="${app.pet.imageUrl}" style="width: 60px; height: 60px; border-radius: 4px; object-fit: cover;">
                            <div>
                                <div style="font-weight: 600;">${app.pet.name}</div>
                                <div style="font-size: 0.85rem; color: #666;">${app.pet.species} / ${app.pet.breed}</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <h3 style="border-bottom: 1px solid #CCC; padding-bottom: 10px; margin-bottom: 20px;">领养意愿</h3>
                    <div class="form-group">
                        <label>领养动机</label>
                        <p style="background: #FAFAFA; padding: 15px; border-radius: 4px; line-height: 1.6;">
                            ${app.adoptMotive}
                        </p>
                    </div>

                    <div style="margin-top: 50px; border-top: 1px solid #EEE; padding-top: 30px;">
                        <form action="${pageContext.request.contextPath}/adoption/doReview" method="post">
                            <input type="hidden" name="appId" value="${app.applicationId}">
                            <input type="hidden" name="petId" value="${app.pet.petId}">

                            <label style="display: block; margin-bottom: 15px; font-weight: 500;">审核决定：</label>
                            <div style="display: flex; gap: 20px; margin-bottom: 30px;">
                                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                                    <input type="radio" name="status" value="approved" required>
                                    <span style="color: var(--zen-matcha);">通过</span>
                                </label>
                                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                                    <input type="radio" name="status" value="rejected" required>
                                    <span style="color: var(--zen-clay);">拒绝</span>
                                </label>
                            </div>

                            <button type="submit" class="primary-solid">提交结果</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>