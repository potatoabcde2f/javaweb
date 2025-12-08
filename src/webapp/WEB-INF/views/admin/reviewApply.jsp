<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>审核领养申请 - 管理员后台</title>
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
            <li><a href="/pet/list" class="menu-item">宠物管理</a></li>
            <li><a href="/adoption/manage" class="menu-item active">领养申请管理</a></li>
            <li><a href="/admin/statistics" class="menu-item">统计分析</a></li>
        </ul>
    </div>

    <div class="admin-content">
        <div class="content-header">
            <h2>审核领养申请</h2>
            <a href="/adoption/manage" class="back-btn">返回列表</a>
        </div>

        <div class="review-box">
            <form action="/adoption/doReview" method="post">
                <input type="hidden" name="appId" value="${app.applicationId}">
                <input type="hidden" name="petId" value="${app.pet.petId}">

                <div class="review-section">
                    <h3>申请基本信息</h3>
                    <div class="info-group">
                        <div class="info-item">
                            <span class="label">申请ID：</span>
                            <span class="value">${app.applicationId}</span>
                        </div>
                        <div class="info-item">
                            <span class="label">申请时间：</span>
                            <span class="value"><fmt:formatDate value="${app.applicationDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                        </div>
                    </div>
                </div>

                <div class="review-section">
                    <h3>宠物信息</h3>
                    <div class="pet-info">
                        <img src="${app.pet.imageUrl}" alt="${app.pet.name}" class="pet-thumb">
                        <div class="pet-detail">
                            <p>名称：${app.pet.name}</p>
                            <p>物种：${app.pet.species} | 品种：${app.pet.breed}</p>
                            <p>年龄：${app.pet.age}岁 | 性别：${app.pet.gender}</p>
                            <p>状态：${app.pet.status}</p>
                        </div>
                    </div>
                </div>

                <div class="review-section">
                    <h3>申请人信息</h3>
                    <div class="info-group">
                        <div class="info-item">
                            <span class="label">姓名：</span>
                            <span class="value">${app.contactPerson.name}</span>
                        </div>
                        <div class="info-item">
                            <span class="label">联系电话：</span>
                            <span class="value">${app.contactPerson.phone}</span>
                        </div>
                        <div class="info-item">
                            <span class="label">电子邮箱：</span>
                            <span class="value">${app.contactPerson.email == null ? '无' : app.contactPerson.email}</span>
                        </div>
                        <div class="info-item">
                            <span class="label">居住地址：</span>
                            <span class="value">${app.contactPerson.address}</span>
                        </div>
                    </div>
                </div>

                <div class="review-section">
                    <h3>申请详情</h3>
                    <div class="apply-detail">
                        <div class="detail-item">
                            <span class="label">领养动机：</span>
                            <span class="value">${app.adoptMotive}</span>
                        </div>
                    </div>
                </div>

                <div class="review-section">
                    <h3>审核操作</h3>
                    <div class="review-operate">
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="status" value="approved" required> 审核通过
                            </label>
                            <label>
                                <input type="radio" name="status" value="rejected" required> 审核拒绝
                            </label>
                        </div>
                        <div class="btn-group">
                            <button type="submit">提交审核</button>
                            <a href="/adoption/manage" class="cancel-btn">取消</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>