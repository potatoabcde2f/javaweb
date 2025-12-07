<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我的领养申请 - 宠物领养系统</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <a href="/pet/list" class="back-btn">返回列表</a>
        <h1>我的领养申请</h1>
    </header>

    <div class="search-apply">
        <form action="/adoption/myApply" method="get">
            <input type="tel" name="phone" required placeholder="请输入申请时的联系电话" value="${phone}">
            <button type="submit">查询申请</button>
        </form>
        <div class="error-msg">${errorMsg}</div>
    </div>

    <c:if test="${not empty appList}">
        <div class="apply-table-box">
            <table class="apply-table">
                <thead>
                <tr>
                    <th>申请ID</th>
                    <th>领养宠物</th>
                    <th>申请时间</th>
                    <th>申请状态</th>
                    <th>领养动机</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${appList}" var="app">
                    <tr>
                        <td>${app.applicationId}</td>
                        <td>
                            <c:set var="pet" value="${petService.getPetById(app.petId)}" />
                                ${pet.name}（${pet.species}）
                        </td>
                        <td><fmt:formatDate value="${app.applicationDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>
                            <c:if test="${app.status == 'pending'}">
                                <span class="status-pending">审核中</span>
                            </c:if>
                            <c:if test="${app.status == 'approved'}">
                                <span class="status-approved">已通过</span>
                            </c:if>
                            <c:if test="${app.status == 'rejected'}">
                                <span class="status-rejected">已拒绝</span>
                            </c:if>
                        </td>
                        <td class="motive">${app.adoptMotive}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <c:if test="${empty appList and not empty phone}">
        <div class="empty-tip">未查询到您的领养申请记录</div>
    </c:if>
</div>
</body>
</html>