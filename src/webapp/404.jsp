<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>404 - 页面未找到</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* 专门为404页面定义的样式，保持与 login-box 风格一致 */
        .error-container {
            width: 600px;
            margin: 100px auto;
            background-color: #fff;
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .error-code {
            font-size: 80px;
            color: #e74c3c; /* 使用你项目中 delete-btn 的红色 */
            font-weight: bold;
            margin-bottom: 10px;
        }
        .error-title {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        .error-desc {
            color: #7f8c8d;
            margin-bottom: 40px;
            font-size: 16px;
        }
        /* 覆盖 btn-group 的默认左边距 */
        .center-btn-group {
            display: flex;
            justify-content: center;
            gap: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="error-container">
        <div class="error-code">404</div>
        <h2 class="error-title">哎呀，页面走丢了！</h2>
        <p class="error-desc">
            您正在寻找的页面可能已被移除、重命名，或者您输入的链接有误。
        </p>

        <div class="center-btn-group">
            <a href="javascript:history.back()" class="back-btn">返回上一页</a>
            <a href="${pageContext.request.contextPath}/pet/list" class="btn">返回首页</a>
        </div>
    </div>
</div>

</body>
</html>