<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="views/styles/loginStyle.css">
    <link rel="stylesheet" href="styles/loginStyle.css">
</head>
</body>
<div class = "login-page">
    <div class="form">
        <p><span style="color: red; ">${errorMessage}</span></p>
        <form class="login-form" action="${pageContext.servletContext.contextPath}/controller?command=login" method="POST">
            <p> Вход в систему </p>
             <label>
                 Имя :
                <input class="text_field" name="loginName" type="text" />
            </label>
             Пароль : <label>
                <input class="text_field" name="password" type="password" />
            </label>
            <input class="button_style" type="submit" value="Войти"/>
        </form>
        <div>
            <form action="${pageContext.servletContext.contextPath}/controller?command=registration_page" method="post">
                <input class="button_style" type="submit" value="Регистрация"/>
            </form>
        </div>
    </div>
</div>
</body>
</html>