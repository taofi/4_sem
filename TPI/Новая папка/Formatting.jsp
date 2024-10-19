<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Formatting</title>
</head>
<body>
<jsp:useBean id="now" class="java.util.Date"/>

<fmt:setLocale value="en-EN"/>
Date now: <fmt:formatDate value="${now}" /><br/>
<fmt:setLocale value="ru-RU"/>
Date now: <fmt:formatDate value="${now}" /><br/>
<br/>

<fmt:formatDate value="${now}" type="time" timeStyle="short"/><br/>
<fmt:formatDate value="${now}" type="time" timeStyle="medium"/><br/>
<fmt:formatDate value="${now}" type="time" timeStyle="long"/><br/>
<br/>

<c:set var="num" value="161610" scope="page"/>
Вывод числа <c:out value=" ${num}"/>  в разных форматах<br>
<br/>

Процентны:
<fmt:formatNumber value="${num}" type="percent"/><br/>
<br/>

<fmt:setLocale value="be-BY"/>
Бел рубль:
<fmt:formatNumber value="${num}" type="currency"/><br/>
<br/>

<fmt:setLocale value="en-EN"/>
Доллар:
<fmt:formatNumber value="${num}" type="currency"/><br/>
</body>
</html>
