<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<p><span style="color: red; ">${errorRegister}</span></p>
<form action="${pageContext.servletContext.contextPath}/controller?command=register_new_user" method="POST">
    <p> Регистрация нового пользователя </p>
    <label>
        Введите имя :
        <input name="newLoginName" type="text" />
    </label>
    <label>
        Введите пароль :
        <input name="newPassword" type="password" />
    </label>
    <input class ="button-main-page" type="submit" value="Зарегистрировать"/>
</form>
</body>
</html>
