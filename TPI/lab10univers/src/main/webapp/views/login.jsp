<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        body{
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form_container{
            display: grid;
            grid-template-columns: repeat(2, 120px);
            grid-template-rows: 70px repeat(2, 40px);
        }

        .form_container label{
            grid-column: span 2;
        }

        .form_container input{
            margin: 10px;
        }
    </style>
</head>
<body>
<form action="login-servlet" method="post" style="height: 415px">
    <div class="form_container">
        <h1 style="margin-bottom: 50px;">Authorization</h1>

        <% if (request.getParameter("error") != null && request.getParameter("error").equals("true")) { %>
            <p style="position: absolute; top: 140px;">login/password is incorrect</p>
        <% } %>

        <label>
            <input type="text" class="text_field" name="login" placeholder="login" required>
        </label>
        <label>
            <input type="text" class="text_field" name="password" placeholder="password" required>
        </label>

        <div class="button_container">
            <input type="submit" value="Login" class="button_style">
            <input type="button" value="Sign up" class="button_style" onclick="window.location='views/register.jsp'">
        </div>
    </div>
</form>
</body>
</html>