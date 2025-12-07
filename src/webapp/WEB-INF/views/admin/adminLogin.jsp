<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员登录 - 宠物领养系统</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container">
    <div class="login-box admin-login">
        <h2>管理员登录</h2>
        <form action="/user/login" method="post">
            <div class="form-group">
                <label>管理员账号：</label>
                <input type="text" name="username" required placeholder="请输入管理员账号">
            </div>
            <div class="form-group">
                <label>密码：</label>
                <input type="password" name="password" required placeholder="请输入密码">
            </div>
            <div class="error-msg">${errorMsg}</div>
            <div class="btn-group">
                <button type="submit">登录</button>
                <a href="/WEB-INF/views/user/login.jsp">返回用户登录</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>