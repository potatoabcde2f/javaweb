<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增宠物 - 管理员后台</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="admin-container">
    <header class="admin-header">
        <h1>宠物领养系统 - 管理后台</h1>
        <div class="admin-operate">
            <span>欢迎您，管理员</span>
            <a href="/user/logout">退出登录</a>
        </div>
    </header>

    <div class="admin-sidebar">
        <ul class="menu-list">
            <li><a href="/admin/index" class="menu-item">数据概览</a></li>
            <li><a href="/pet/list" class="menu-item active">宠物管理</a></li>
            <li><a href="/adoption/manage" class="menu-item">领养申请管理</a></li>
            <li><a href="/admin/statistics" class="menu-item">统计分析</a></li>
        </ul>
    </div>

    <div class="admin-content">
        <div class="content-header">
            <h2>新增宠物</h2>
            <a href="/pet/list" class="back-btn">返回列表</a>
        </div>

        <div class="form-box">
            <form action="/pet/add" method="post">
                <div class="form-group">
                    <label>宠物名称：</label>
                    <input type="text" name="name" required placeholder="请输入宠物名称">
                </div>
                <div class="form-group">
                    <label>物种：</label>
                    <select name="species" required>
                        <option value="">请选择物种</option>
                        <option value="狗">狗</option>
                        <option value="猫">猫</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>品种：</label>
                    <input type="text" name="breed" placeholder="请输入宠物品种（可选）">
                </div>
                <div class="form-group">
                    <label>年龄：</label>
                    <input type="number" name="age" min="0" required placeholder="请输入宠物年龄（单位：岁）">
                </div>
                <div class="form-group">
                    <label>性别：</label>
                    <select name="gender" required>
                        <option value="">请选择性别</option>
                        <option value="公">公</option>
                        <option value="母">母</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>宠物描述：</label>
                    <textarea name="description" rows="5" required placeholder="请输入宠物的性格、健康状况等详细描述"></textarea>
                </div>
                <div class="form-group">
                    <label>照片URL：</label>
                    <input type="text" name="imageUrl" required placeholder="请输入宠物照片的网络URL">
                    <span class="tips">提示：可使用Unsplash等免费图片网站的图片URL</span>
                </div>
                <div class="error-msg">${errorMsg}</div>
                <div class="btn-group">
                    <button type="submit">提交</button>
                    <a href="/pet/list" class="cancel-btn">取消</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>