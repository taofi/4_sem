<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
    <link rel="stylesheet" href="styles/loginStyle.css">
</head>
<body>
<form action="../register-servlet" method="post" style="height: 415px">
    <div class="form_container">
        <h1 style="margin-bottom: 50px;">Registration</h1>

        <% if (request.getParameter("error") != null && request.getParameter("error").equals("true")) { %>
        <p style="position: absolute; top: 140px;">this login is already in use</p>
        <% } %>

        <label>
            <input type="text" class="text_field" name="login" placeholder="login" required>
        </label>

        <label>
            <input type="text" class="text_field" name="password" placeholder="password" required>
        </label>

        <div class="button_container">
            <input type="submit" value="Sign up" class="button_style">
        </div>
    </div>
</form>
</body>
</html>
