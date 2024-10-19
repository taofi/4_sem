<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        form.form-example {
            display: table;
        }
        div.form-example {
            display: table-row;
        }
        label, input {
            display: table-cell;
            margin-bottom: 10px;
        }
        label {
            padding-right: 10px;
        }
    </style>
</head>
<body>
    <form action="loginServlet" class="form-example" method="post">
        <div class="form-example">
            <label for="login">Enter your login: </label>
            <input type="text" name="login" id="login" required />
        </div>
        <div class="form-example">
            <label for="password">Enter your password: </label>
            <input type="text" name="password" id="password" required />
        </div>
        <div class="form-example">
            <input type="submit" value="Send" name="button" />
        </div>
    </form>
</body>
</html>
