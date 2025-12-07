<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员首页 - 宠物领养系统</title>
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
            <li><a href="/admin/index" class="menu-item active">数据概览</a></li>
            <li><a href="/pet/list" class="menu-item">宠物管理</a></li>
            <li><a href="/adoption/manage" class="menu-item">领养申请管理</a></li>
            <li><a href="/admin/statistics" class="menu-item">统计分析</a></li>
        </ul>
    </div>

    <div class="admin-content">
        <h2>数据概览</h2>
        <div class="stats-card-group">
            <div class="stats-card">
                <div class="stats-title">宠物总数</div>
                <div class="stats-value">${totalPet}</div>
                <div class="stats-desc">包含所有状态的宠物</div>
            </div>
            <div class="stats-card">
                <div class="stats-title">可领养宠物</div>
                <div class="stats-value">${availablePet}</div>
                <div class="stats-desc">状态为「可领养」的宠物</div>
            </div>
            <div class="stats-card">
                <div class="stats-title">待审核申请</div>
                <div class="stats-value">${pendingApp}</div>
                <div class="stats-desc">需要处理的领养申请</div>
            </div>
            <div class="stats-card">
                <div class="stats-title">已通过申请</div>
                <div class="stats-value">${approvedApp}</div>
                <div class="stats-desc">审核通过的领养申请</div>
            </div>
        </div>

        <div class="quick-operate">
            <h3>快捷操作</h3>
            <a href="/pet/toAdd" class="operate-btn">新增宠物</a>
            <a href="/adoption/manage?status=pending" class="operate-btn">处理待审核申请</a>
            <a href="/admin/statistics" class="operate-btn">查看详细统计</a>
        </div>
    </div>
</div>
</body>
</html>