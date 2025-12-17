<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>领养审核</title>
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
                <h2>领养申请列表</h2>
            </div>

            <div class="search-bar" style="border-bottom: none; margin-bottom: 30px; padding: 0;">
                <form action="${pageContext.request.contextPath}/adoption/manage" method="get">
                    <select name="status">
                        <option value="" ${empty status ? 'selected' : ''}>全部申请</option>
                        <option value="pending" ${status == 'pending' ? 'selected' : ''}>待审核</option>
                        <option value="approved" ${status == 'approved' ? 'selected' : ''}>已通过</option>
                        <option value="rejected" ${status == 'rejected' ? 'selected' : ''}>已拒绝</option>
                    </select>
                    <button type="submit" class="btn">筛选</button>
                </form>
            </div>

            <div class="table-box">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>宠物</th>
                        <th>申请人</th>
                        <th>联系电话</th>
                        <th>日期</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${appList}" var="app">
                        <tr>
                            <td>${app.applicationId}</td>
                            <td>${app.pet.name}</td>
                            <td>${app.contactPerson.name}</td>
                            <td>${app.contactPerson.phone}</td>
                            <td><fmt:formatDate value="${app.applicationDate}" pattern="yyyy-MM-dd" /></td>
                            <td>
                                <c:if test="${app.status == 'pending'}"><span class="status-pending">待审核</span></c:if>
                                <c:if test="${app.status == 'approved'}"><span class="status-approved">已通过</span></c:if>
                                <c:if test="${app.status == 'rejected'}"><span class="status-rejected">已拒绝</span></c:if>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/adoption/review?appId=${app.applicationId}" class="btn" style="padding: 2px 10px; font-size: 0.8rem;">
                                    审核
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${appList.isEmpty()}">
                <div class="empty-tip">暂无申请数据</div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>