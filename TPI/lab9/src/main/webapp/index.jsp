<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Lab9" %>
</h1>
<br/>
<a href="currentTime">get current Time</a>
<br/>
<a href="ex2.jsp">Login or Register</a>
<br/>
<a href="firstServlet">ex 6</a>
<br/>
<form action="firstServlet" method="post">
    <input type="submit" value="ex6a Send post"/>
</form>
<br/>
<form action="getFirstServlet" method="GET">
    <label for="forwardCheckbox">Использовать переопределение</label>
    <input type="checkbox" id="forwardCheckbox" name="forward" value="true">
    <br>
    <input type="submit" value="Отправить">
</form>
<br/>
<br/>
<a href="first7Servlet">ex7</a>
</body>
</html>