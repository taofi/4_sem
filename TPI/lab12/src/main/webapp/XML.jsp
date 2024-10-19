<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "x" uri = "http://java.sun.com/jsp/jstl/xml" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>ъ


<html>
<head>
    <title>XML</title>
</head>
<body>
<c:set var="xmlData">
    <users>
        <user>
            <name>John Doe</name>
            <email>john@example.com</email>
        </user>
        <user>
            <name>Jane Doe</name>
            <email>jane@example.com</email>
        </user>
    </users>
    </c:set>
<x:parse xml="${xmlData}" var="doc"/>


<ul>
    <x:forEach select="$doc/users/user" var="user">
        <li>Name: <x:out select="$user/name"/>, Email: <x:out select="$user/email"/></li>
    </x:forEach>
</ul>
<x:if select="$doc/users/user[name='John Doe']">
    <p>John Doe is in the user list.</p>
</x:if>

<x:choose>
    <x:when select="count($doc/users/user) > 5">
        <p>More than 5 users.</p>
    </x:when>
    <x:otherwise>
        <p>5 or less users.</p>
    </x:otherwise>
</x:choose>
</body>
</html>
