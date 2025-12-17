<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增宠物</title>
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
                <li><a href="${pageContext.request.contextPath}/pet/list" class="menu-item active">宠物信息</a></li>
                <li><a href="${pageContext.request.contextPath}/adoption/manage" class="menu-item">领养审核</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/statistics" class="menu-item">统计报表</a></li>
            </ul>
        </div>

        <div class="admin-content">
            <div class="content-header">
                <h2>新增档案</h2>
                <a href="${pageContext.request.contextPath}/pet/list" class="btn cancel-btn">返回列表</a>
            </div>

            <div class="form-box" style="max-width: 800px;">
                <form action="${pageContext.request.contextPath}/pet/add" method="post">
                    <div class="form-group">
                        <label>宠物昵称</label>
                        <input type="text" name="name" required placeholder="请输入名称">
                    </div>
                    <div class="form-group">
                        <label>物种</label>
                        <select name="species" required>
                            <option value="">请选择...</option>
                            <option value="狗">狗</option>
                            <option value="猫">猫</option>
                            <option value="其他">其他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>品种</label>
                        <input type="text" name="breed" placeholder="例如：金毛、英短">
                    </div>
                    <div class="form-group">
                        <label>年龄</label>
                        <input type="number" name="age" min="0" required placeholder="岁">
                    </div>
                    <div class="form-group">
                        <label>性别</label>
                        <select name="gender" required>
                            <option value="">请选择...</option>
                            <option value="公">公</option>
                            <option value="母">母</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>照片 URL</label>
                        <input type="text" name="imageUrl" required placeholder="http://...">
                    </div>
                    <div class="form-group">
                        <label>详细描述</label>
                        <textarea name="description" rows="5" required placeholder="性格、健康状况等..."></textarea>
                    </div>

                    <div style="margin-top: 30px;">
                        <button type="submit" class="primary-solid">确认添加</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>