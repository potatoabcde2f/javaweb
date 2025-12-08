<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>领养申请管理 - 管理员后台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="admin-container">
    <header class="admin-header">
        <h1>宠物领养系统 - 管理后台</h1>
        <div class="admin-operate">
            <span>欢迎您，管理员</span>
            <a href="${pageContext.request.contextPath}/user/logout">退出登录</a>
        </div>
    </header>

    <div class="admin-sidebar">
        <ul class="menu-list">
            <li><a href="${pageContext.request.contextPath}/admin/index" class="menu-item">数据概览</a></li>
            <li><a href="${pageContext.request.contextPath}/pet/list" class="menu-item">宠物管理</a></li>
            <li><a href="${pageContext.request.contextPath}/adoption/manage" class="menu-item active">领养申请管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/statistics" class="menu-item">统计分析</a></li>
        </ul>
    </div>

    <div class="admin-content">
        <div class="content-header">
            <h2>领养申请管理</h2>
        </div>

        <div class="filter-bar">
            <form action="${pageContext.request.contextPath}/adoption/manage" method="get">
                <select name="status">
                    <option value="" ${empty status ? 'selected' : ''}>全部申请</option>
                    <option value="pending" ${status == 'pending' ? 'selected' : ''}>待审核</option>
                    <option value="approved" ${status == 'approved' ? 'selected' : ''}>已通过</option>
                    <option value="rejected" ${status == 'rejected' ? 'selected' : ''}>已拒绝</option>
                </select>
                <button type="submit">筛选</button>
            </form>
        </div>

        <div class="table-box">
            <table class="data-table">
                <thead>
                <tr>
                    <th>申请ID</th>
                    <th>领养宠物</th>
                    <th>申请人</th>
                    <th>联系电话</th>
                    <th>申请时间</th>
                    <th>申请状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${appList}" var="app">
                    <tr>
                        <td>${app.applicationId}</td>
                        <td>${app.pet.name}（${app.pet.species}）</td>
                        <td>${app.contactPerson.name}</td>
                        <td>${app.contactPerson.phone}</td>
                        <td><fmt:formatDate value="${app.applicationDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>
                            <c:if test="${app.status == 'pending'}">
                                <span class="status-pending">待审核</span>
                            </c:if>
                            <c:if test="${app.status == 'approved'}">
                                <span class="status-approved">已通过</span>
                            </c:if>
                            <c:if test="${app.status == 'rejected'}">
                                <span class="status-rejected">已拒绝</span>
                            </c:if>
                        </td>
                        <td class="operate-col">
                            <a href="${pageContext.request.contextPath}/adoption/review?appId=${app.applicationId}" class="review-btn">审核</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${appList.isEmpty()}">
            <div class="empty-tip">暂无符合条件的领养申请</div>
        </c:if>
    </div>
</div>
</body>
</html>