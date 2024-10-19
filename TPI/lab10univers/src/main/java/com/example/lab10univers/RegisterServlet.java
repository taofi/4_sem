package com.example.lab10univers;

import database.ConnectionFactory;
import database.UserDao;
import database.UserDaoImpl;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;

@WebServlet(name = "registerServlet", value = "/register-servlet")
public class RegisterServlet extends HttpServlet {

    public void init() {

    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        User inputUser = new User(login, password);
        inputUser.setPassword(inputUser.getEncodedPassword());

        try {
            Connection connection = ConnectionFactory.getConnection();
            UserDao userDaoImpl = new UserDaoImpl(connection);

            System.out.println("ab");
            ArrayList<User> users = userDaoImpl.getAllUsers();
            System.out.println("a");
            if (hasUser(users, inputUser)) {
                response.sendRedirect("views/register.jsp?error=true");
            }
            else {
                userDaoImpl.add(inputUser);
                response.sendRedirect("/lab10univers_war_exploded");
            }
        }
        catch(Exception e) {
            request.setAttribute("exception", e);
            request.setAttribute("errorMessage", e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    public void destroy() {
    }

    private boolean hasUser(ArrayList<User> users, User user) {
        for (User u: users)
            if (u.getLogin().equals(user.getLogin()))
                return true;

        return false;
    }
}