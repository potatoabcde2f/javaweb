<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>统计报表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .report-section {
            background: var(--zen-surface);
            border: var(--border-thin);
            padding: 40px;
            margin-bottom: 30px;
        }
        .report-title {
            font-family: 'Noto Serif SC', serif;
            font-size: 1.2rem;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px dashed #DDD;
        }
        .bar-group { margin-bottom: 25px; }
        .bar-label {
            display: flex;
            justify-content: space-between;
            font-size: 0.9rem;
            color: var(--zen-ink);
            margin-bottom: 8px;
        }
        .bar-track {
            width: 100%;
            height: 4px;
            background-color: #EEE;
            border-radius: 2px;
            overflow: hidden;
        }
        .bar-fill {
            height: 100%;
            border-radius: 2px;
            transition: width 1s ease;
        }
        .kpi-row {
            display: flex;
            gap: 40px;
            margin-bottom: 40px;
        }
        .kpi-item { flex: 1; }
        .kpi-num {
            font-size: 2.5rem;
            font-family: 'Noto Serif SC', serif;
            color: var(--zen-ink);
            line-height: 1.2;
        }
        .kpi-desc {
            font-size: 0.85rem;
            color: var(--zen-gray);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
    </style>
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
                <li><a href="${pageContext.request.contextPath}/adoption/manage" class="menu-item">领养审核</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/statistics" class="menu-item active">统计报表</a></li>
            </ul>
        </div>

        <div class="admin-content">
            <div class="report-section">
                <div class="report-title">领养转化漏斗</div>
                <div class="kpi-row">
                    <div class="kpi-item">
                        <div class="kpi-num">${pendingCount + approvedCount + rejectedCount}</div>
                        <div class="kpi-desc">累计申请</div>
                    </div>
                    <div class="kpi-item">
                        <div class="kpi-num" style="color: var(--zen-matcha);">
                            <c:choose>
                                <c:when test="${(pendingCount+approvedCount+rejectedCount) > 0}">
                                    <fmt:formatNumber value="${approvedCount / (pendingCount+approvedCount+rejectedCount)}" type="percent" maxFractionDigits="0"/>
                                </c:when>
                                <c:otherwise>0%</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="kpi-desc">成功率</div>
                    </div>
                    <div class="kpi-item">
                        <div class="kpi-num" style="color: var(--zen-gold);">${pendingCount}</div>
                        <div class="kpi-desc">积压审核</div>
                    </div>
                </div>

                <div class="bar-group">
                    <div class="bar-label">
                        <span><i class="fas fa-check-circle" style="color:var(--zen-matcha)"></i> 审核通过</span>
                        <span>${approvedCount}</span>
                    </div>
                    <div class="bar-track">
                        <div class="bar-fill" style="width: ${(pendingCount+approvedCount+rejectedCount) > 0 ? approvedCount * 100 / (pendingCount+approvedCount+rejectedCount) : 0}%; background-color: var(--zen-matcha);"></div>
                    </div>
                </div>
            </div>

            <div class="report-section">
                <div class="report-title">库存概览</div>
                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; text-align: center;">
                    <div style="padding: 20px; background: #F9F9F9;">
                        <i class="fas fa-dog" style="font-size: 20px; color: var(--zen-gray); margin-bottom: 10px;"></i>
                        <div style="font-size: 1.5rem; font-weight: 600;">${dogCount}</div>
                        <div style="font-size: 0.8rem; color: var(--zen-gray);">狗狗</div>
                    </div>
                    <div style="padding: 20px; background: #F9F9F9;">
                        <i class="fas fa-cat" style="font-size: 20px; color: var(--zen-gray); margin-bottom: 10px;"></i>
                        <div style="font-size: 1.5rem; font-weight: 600;">${catCount}</div>
                        <div style="font-size: 0.8rem; color: var(--zen-gray);">猫咪</div>
                    </div>
                    <div style="padding: 20px; background: #F9F9F9;">
                        <i class="fas fa-dove" style="font-size: 20px; color: var(--zen-gray); margin-bottom: 10px;"></i>
                        <div style="font-size: 1.5rem; font-weight: 600;">${otherCount}</div>
                        <div style="font-size: 0.8rem; color: var(--zen-gray);">其他</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>