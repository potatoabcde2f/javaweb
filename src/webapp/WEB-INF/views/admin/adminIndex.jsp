<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>工作台 - 宠物领养系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 工作台专属样式 */
        .welcome-banner {
            background-color: var(--zen-surface);
            border: var(--border-thin);
            padding: 40px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
        }
        .action-card {
            background: var(--zen-surface);
            border: var(--border-thin);
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            display: block; /* 让a标签填满 */
        }
        .action-card:hover {
            background-color: var(--zen-ink);
            transform: translateY(-4px);
        }
        /* 悬停时文字变白 */
        .action-card:hover h3, .action-card:hover p, .action-card:hover i {
            color: var(--zen-surface) !important;
        }

        .action-icon {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: var(--zen-matcha);
            display: inline-block;
        }

        /* 待办事项提醒 */
        .todo-badge {
            background-color: var(--zen-gold);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-left: 10px;
        }
    </style>
</head>
<body>

<div class="admin-container">
    <header class="admin-header">
        <h1>工作台</h1>
        <div class="admin-operate">
            <a href="${pageContext.request.contextPath}/user/logout" class="btn cancel-btn" style="border: none; padding: 0;">退出</a>
        </div>
    </header>

    <div class="admin-body">
        <div class="admin-sidebar">
            <ul class="menu-list">
                <li><a href="${pageContext.request.contextPath}/admin/index" class="menu-item active">工作台</a></li>
                <li><a href="${pageContext.request.contextPath}/pet/list" class="menu-item">宠物管理</a></li>
                <li><a href="${pageContext.request.contextPath}/adoption/manage" class="menu-item">领养审核</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/statistics" class="menu-item">统计报表</a></li>
            </ul>
        </div>

        <div class="admin-content">

            <div class="welcome-banner">
                <div>
                    <h2 style="font-size: 1.8rem; margin-bottom: 10px; font-weight: 400;">早安，管理员</h2>
                    <p style="color: var(--zen-gray);">准备好处理今天的领养事务了吗？</p>
                </div>
                <div style="text-align: right;">
                    <div style="font-size: 3rem; font-family: 'Noto Serif SC', serif; color: var(--zen-ink);">
                        ${pendingApp}
                    </div>
                    <div style="color: var(--zen-gold); font-size: 0.9rem; font-weight: 600;">个 待审核申请</div>
                </div>
            </div>

            <div class="content-header">
                <h3>快速开始</h3>
            </div>

            <div class="action-grid">
                <a href="${pageContext.request.contextPath}/adoption/manage?status=pending" class="action-card">
                    <i class="fas fa-clipboard-check action-icon" style="color: var(--zen-gold);"></i>
                    <h3 style="margin-bottom: 10px;">处理审核</h3>
                    <p style="color: var(--zen-gray); font-size: 0.9rem;">查看并审批待处理的领养申请</p>
                </a>

                <a href="${pageContext.request.contextPath}/pet/toAdd" class="action-card">
                    <i class="fas fa-plus action-icon"></i>
                    <h3 style="margin-bottom: 10px;">录入宠物</h3>
                    <p style="color: var(--zen-gray); font-size: 0.9rem;">添加新的流浪动物档案信息</p>
                </a>

                <a href="${pageContext.request.contextPath}/pet/list" class="action-card">
                    <i class="fas fa-search action-icon" style="color: var(--zen-indigo);"></i>
                    <h3 style="margin-bottom: 10px;">档案查询</h3>
                    <p style="color: var(--zen-gray); font-size: 0.9rem;">管理库中 ${totalPet} 只宠物的状态</p>
                </a>
            </div>

        </div>
    </div>
</div>
</body>
</html>