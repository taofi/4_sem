<%@ page import="com.example.lab12.ConfigLoader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<html>
<head>
    <title>SQL</title>
</head>
<body>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                   url="<%= ConfigLoader.getProperty("url") %>"
                   user="<%= ConfigLoader.getProperty("user") %>"
                   password="<%= ConfigLoader.getProperty("password") %>" />

<sql:query dataSource = "${snapshot}" var = "result">
    SELECT * from univer;
</sql:query>
<table>
    <tr>
        <th>ID</th>
        <th>login</th>
    </tr>

    <c:forEach var = "row" items = "${result.rows}">
        <tr>
            <td> <c:out value = "${row.id}"/></td>
            <td> <c:out value = "${row.name}"/></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
