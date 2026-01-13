<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-13
  Time: 오후 12:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Main</title>
</head>
<body class="flex flex-col h-screen w-full overflow-hidden bg-white">
<div class="flex flex-1 h-full pt-20 overflow-hidden relative">
  <!-- sidebar -->
  <%@ include file="sidebar.jsp"%>

  <!-- Main -->
  <main class="flex-1 overflow-hidden p-8 flex flex-col bg-gray-50">
    <div id="main" class="flex flex-col w-full h-full max-w-[1800px] mx-auto min-h-0">

      <h1>main</h1>

    </div>
  </main>
</div>

<script src="${cpath}/resources/js/main/main.js"></script>

</body>
</html>
