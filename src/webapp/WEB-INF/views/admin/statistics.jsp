<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>统计分析 - 管理员后台</title>
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
            <li><a href="/pet/list" class="menu-item">宠物管理</a></li>
            <li><a href="/adoption/manage" class="menu-item">领养申请管理</a></li>
            <li><a href="/admin/statistics" class="menu-item active">统计分析</a></li>
        </ul>
    </div>

    <div class="admin-content">
        <div class="content-header">
            <h2>统计分析</h2>
        </div>

        <div class="stats-section">
            <h3>宠物物种分布</h3>
            <div class="stats-chart-group">
                <div class="stats-chart">
                    <div class="chart-title">狗</div>
                    <div class="chart-value">${dogCount} 只</div>
                    <div class="progress-bar">
                        <div class="progress" style="width: ${dogCount/(dogCount+catCount+otherCount)*100}%"></div>
                    </div>
                </div>
                <div class="stats-chart">
                    <div class="chart-title">猫</div>
                    <div class="chart-value">${catCount} 只</div>
                    <div class="progress-bar">
                        <div class="progress" style="width: ${catCount/(dogCount+catCount+otherCount)*100}%"></div>
                    </div>
                </div>
                <div class="stats-chart">
                    <div class="chart-title">其他</div>
                    <div class="chart-value">${otherCount} 只</div>
                    <div class="progress-bar">
                        <div class="progress" style="width: ${otherCount/(dogCount+catCount+otherCount)*100}%"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="stats-section">
            <h3>领养申请状态分布</h3>
            <div class="stats-chart-group">
                <div class="stats-chart">
                    <div class="chart-title">待审核</div>
                    <div class="chart-value">${pendingCount} 条</div>
                    <div class="progress-bar">
                        <div class="progress pending-progress" style="width: ${pendingCount/(pendingCount+approvedCount+rejectedCount)*100}%"></div>
                    </div>
                </div>
                <div class="stats-chart">
                    <div class="chart-title">已通过</div>
                    <div class="chart-value">${approvedCount} 条</div>
                    <div class="progress-bar">
                        <div class="progress approved-progress" style="width: ${approvedCount/(pendingCount+approvedCount+rejectedCount)*100}%"></div>
                    </div>
                </div>
                <div class="stats-chart">
                    <div class="chart-title">已拒绝</div>
                    <div class="chart-value">${rejectedCount} 条</div>
                    <div class="progress-bar">
                        <div class="progress rejected-progress" style="width: ${rejectedCount/(pendingCount+approvedCount+rejectedCount)*100}%"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="stats-summary">
            <h3>统计总结</h3>
            <ul class="summary-list">
                <li>系统总宠物数：${dogCount+catCount+otherCount} 只</li>
                <li>总领养申请数：${pendingCount+approvedCount+rejectedCount} 条</li>
                <li>申请通过率：${(approvedCount/(pendingCount+approvedCount+rejectedCount)*100).toString().substring(0,4)}%</li>
                <li>待处理申请数：${pendingCount} 条（需尽快处理）</li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>