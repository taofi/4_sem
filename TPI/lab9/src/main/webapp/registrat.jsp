<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="registerServlet" class="form-example" method="post">
    <div class="form-example">
        <label for="login">Enter your login: </label>
        <input type="text" name="login" id="login" required />
    </div>
    <div class="form-example">
        <label for="password">Enter your password: </label>
        <input type="text" name="password" id="password" required />
    </div>
    <div class="form-example">
        <label for="role">Enter your role: </label>
        <input type="text" name="role" id="role" required />
    </div>
    <div class="form-example">
        <input type="submit" value="Register" name="button" />
    </div>
</form>
</body>
</html>
