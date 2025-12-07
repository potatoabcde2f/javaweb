<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>申请成功 - 宠物领养系统</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container">
    <div class="success-box">
        <h2>领养申请提交成功！</h2>
        <p class="success-msg">${successMsg}</p>
        <p>您可以通过以下方式查询申请进度：</p>
        <ul class="tips-list">
            <li>1. 前往「我的申请」页面，输入申请时的联系电话查询</li>
            <li>2. 我们会通过电话/邮箱通知您审核结果，请保持通讯畅通</li>
        </ul>
        <div class="btn-group">
            <a href="/pet/list" class="btn">返回宠物列表</a>
            <a href="/adoption/myApply" class="btn">查询申请进度</a>
        </div>
    </div>
</div>
</body>
</html>