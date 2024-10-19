package com.example.lab9;

import Connection.ConnectionFactory;
import database.UserDao;
import database.UserDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;

@WebServlet(name = "registerServlet", value = "/registerServlet")
public class RegisterServlet extends HttpServlet {
    private Connection connection = null;
    private UserDao UserDaoImpl = null;

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        try{
            Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
            System.out.println("Connection succesfull!");
        }
        catch(Exception ex){
            System.out.println("Connection failed...");

            System.out.println(ex);
        }


        try {
            connection = ConnectionFactory.getConnection();
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


        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User inputUser = new User(login, password, role);
        inputUser.setPassword(inputUser.getEncodedPassword());
        System.out.println(inputUser.getPassword());
        System.out.println(password);
        out.println("<html>");
        out.println("<body>");
        out.println("<h1>You have successfully registered!</h1>");
        out.println("</body>");
        out.println("</html>");

        try {
            UserDaoImpl.add(inputUser);
        } catch (SQLException e) {
            System.out.println("Quarry of adding is denied!");
            System.out.println(e.getMessage());
        }

        session.setAttribute("isRegistered", true);
    }
}
