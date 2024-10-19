<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int[] nums = {1, 2, 3, 4, 5};
    session.setAttribute("nums", nums);
%>
<html>
<head>
    <title>Core</title>
</head>
<body>
    <h1>Set and out</h1>
    <c:set var="user" scope="session" value="Sergey" />
    <c:out value="${user}" />

    <h1>Remove</h1>
    <c:remove var="user" scope="request" />

    <h1>If</h1>
    <c:set var="salary" scope="session" value="${23400*2}"/>
    <c:if test="${salary > 45000}">
    <p>Salary = <c:out value="${salary}"/><p>
        </c:if>

    <h1>Choose</h1>
    <c:set var="alter" scope="session" value="${param.age}"/>
    <c:choose>
        <c:when test="${alter <= 28}">
            Переменная alter <= 0
        </c:when>
        <c:when test="${alter > 28}">
            Переменная alter > 28
        </c:when>
        <c:otherwise>
            Не выбрано ни одно условие.
        </c:otherwise>
    </c:choose>

    <h1>ForEach</h1>
    <c:forEach var="num" items="${nums}">
        <h2><c:out value="${num}"/></h2>
    </c:forEach>
</body>
</html>
