package com.example.lab10univers;

import java.io.*;
import java.sql.Connection;
import java.util.ArrayList;

import database.ConnectionFactory;
import database.UserDao;
import database.UserDaoImpl;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;

@WebServlet(name = "loginServlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {
    private UserDao UserDaoImpl = null;

    public void init() {

    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        User inputUser = new User(login, password);
        inputUser.setPassword(inputUser.getEncodedPassword());

        try {
            Connection connection = ConnectionFactory.getConnection();
            UserDaoImpl = new UserDaoImpl(connection);

            ArrayList<User> users = UserDaoImpl.getAllUsers();

            if (hasUser(users, inputUser)) {
                HttpSession session = request.getSession();
                session.setAttribute("isLoggedIn", true);
                session.setAttribute("login", inputUser.getLogin());
                response.sendRedirect("views/welcome.jsp");
            }
            else {
                response.sendRedirect("views/login.jsp?error=true");
            }
        }
        catch(Exception e) {
            request.setAttribute("exception", e);
            request.setAttribute("errorMessage", e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }

    private boolean hasUser(ArrayList<User> users, User user) {
        for (User u: users)
            if (u.equals(user))
                return true;

        return false;
    }
}