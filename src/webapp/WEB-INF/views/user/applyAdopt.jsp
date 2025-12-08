<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>申请领养 - 宠物领养系统</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <a href="/pet/list" class="back-btn">返回列表</a>
        <h1>领养申请</h1>
    </header>

    <div class="apply-form-box">
        <form action="/adoption/submit" method="post">
            <input type="hidden" name="petId" value="${petId}">
            <div class="form-group">
                <label>联系人姓名：</label>
                <input type="text" name="contactName" required placeholder="请输入您的姓名">
            </div>
            <div class="form-group">
                <label>联系电话：</label>
                <input type="tel" name="phone" required placeholder="请输入您的电话（用于查询申请进度）">
            </div>
            <div class="form-group">
                <label>电子邮箱：</label>
                <input type="email" name="email" placeholder="请输入您的邮箱（可选）">
            </div>
            <div class="form-group">
                <label>居住地址：</label>
                <input type="text" name="address" required placeholder="请输入您的居住地址">
            </div>
            <div class="form-group">
                <label>领养动机：</label>
                <textarea name="adoptMotive" required rows="4" placeholder="请说明您想要领养该宠物的原因"></textarea>
            </div>
            <div class="error-msg">${errorMsg}</div>
            <div class="btn-group">
                <button type="submit">提交申请</button>
                <a href="/pet/detail?petId=${petId}" class="cancel-btn">取消</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>