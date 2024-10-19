
<%@ page import="java.sql.Connection" %>
<%@ page import="database.ConnectionFactory" %>
<%@ page import="database.UniverDao" %>
<%@ page import="model.Univer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="database.UniverDaoImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    UniverDao univerDao = null;

    ArrayList<Univer> univers = new ArrayList<Univer>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
        Connection connection = ConnectionFactory.getConnection();
        univerDao = new UniverDaoImpl(connection);

        univers = univerDao.getAllUniver();
    }
    catch(Exception ex) {
        response.sendRedirect("views/error.jsp?errorMessage=" + ex.getMessage());
    }
%>
<html>
<head>
    <title>Welcome</title>
    <style>
        .table_style{
            width: 100%;
        }

        .table_style th{
            border: 1px solid black;
        }

        body{
            display: grid;
            grid-template-columns: 60% 40%;
        }

        .add_from, .edit_from{
            border: 2px solid black;
            border-radius: 10px;
            padding: 10px;
            display: grid;
            grid-template-columns: 100%;
        }

        .add_from{
            grid-template-rows: 50px repeat(4, 30px);
        }
        .edit_from{
            grid-template-rows: 50px repeat(5, 30px);
        }


        .navigation_button{
            width: 150px;
        }
    </style>
</head>
<body>
<main>
    <table class="table_style">
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>City</th>
            <th>Date</th>
            <th>Delete</th>
        </tr>
        <% for (Univer univer: univers) { %>
        <tr>
            <td><%=univer.getId()%></td>
            <td><%=univer.getName()%></td>
            <td><%=univer.getCity()%></td>
            <td><%=univer.getYear()%></td>
            <td>
                <form class="delete_from" action="../delete_servlet" method="post">
                    <input type="hidden" name="delete_id" value="<%= univer.getId() %>"/>
                    <input type="submit" value="Delete" class="navigation_button">
                </form>
            </td>
        </tr>
        <% } %>
    </table>
</main>
<aside>
    <form class="add_from" action="../add_servlet" method="post">
        <h1>Add</h1>
        <label>
            <input type="text" name="name" placeholder="name" required autocomplete="off">
        </label>
        <label>
            <input type="text" name="city" placeholder="city" required>
        </label>
        <label>
            <input type="text" name="date" placeholder="date" required autocomplete="off">
        </label>
        <input type="submit" value="Add" class="navigation_button">
    </form>

    <form class="edit_from" action="../edit_servlet" method="post">
        <h1>Edit</h1>
        <label>
            <input type="text" name="id" placeholder="id" required autocomplete="off">
        </label>
        <label>
            <input type="text" name="name" placeholder="name" required autocomplete="off">
        </label>
        <label>
            <input type="text" name="city" placeholder="city" required>
        </label>
        <label>
            <input type="text" name="date" placeholder="date" required autocomplete="off">
        </label>
        <input type="submit" value="Edit" class="navigation_button">
    </form>
</aside>
</body>
</html>
