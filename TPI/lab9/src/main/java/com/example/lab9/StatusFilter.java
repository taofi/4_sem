package com.example.lab9;

import database.UserDao;
import database.UserDaoImpl;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;
import Connection.ConnectionFactory;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;


@WebFilter(filterName = "StatusFilter")
public class StatusFilter implements Filter {
    private UserDao UserDaoImpl = null;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        String login = request.getParameter("login");
        String password = request.getParameter("password");

        User inputUser = new User(login, password, "");
        System.out.println(inputUser.getPassword());
        inputUser.setPassword(inputUser.getEncodedPassword());
        System.out.println(inputUser.getPassword());
        ArrayList<User> users = new ArrayList<>();


        try {
            Connection connection = ConnectionFactory.getConnection();
            UserDaoImpl = new UserDaoImpl(connection);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            System.out.println("Can't connect to database");
            out.println("<html>");
            out.println("<body>");
            out.println("<h1>Can't connect to database</h1>");
            out.println("<p>Current time: " + LocalTime.now() + "</p>");
            out.println("<p>Current date: " + LocalDateTime.now() + "</p>");
            out.println("</body>");
            out.println("</html>");
        }

        try {
            users = UserDaoImpl.getAllUsers();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        boolean isRegistered = false;
        User currentUser = null;
        for(User user: users) {
            if (user.equals(inputUser)) {
                isRegistered = true;
                currentUser = user;
                currentUser.setPassword(password);
                break;
            }
        }
        if (isRegistered) {


            request.setAttribute("password", currentUser.getPassword());
            request.setAttribute("login", currentUser.getLogin());
            request.setAttribute("role", currentUser.getRole());
            RequestDispatcher rd = request.getRequestDispatcher("loginServlet");
            rd.forward(request, response);
        }
        else {
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            httpResponse.sendRedirect("registrat.jsp");
        }
    }
}
