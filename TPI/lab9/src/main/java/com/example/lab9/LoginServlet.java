package com.example.lab9;

import database.UserDao;
import database.UserDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
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

@WebServlet(name = "loginServlet", value = "/loginServlet")
public class LoginServlet extends HttpServlet {
//    private Connection connection = null;
//    private UserDao UserDaoImpl = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        LocalDateTime currentDate = LocalDateTime.now();
        LocalTime currentTime = LocalTime.now();


        Cookie[] cookies = request.getCookies();
        if (findCookieByName(cookies, "VisitingCount") == null) {
            response.addCookie(new Cookie("LastSessionDate", currentDate.toString()));
            response.addCookie(new Cookie("LastSessionTime", currentTime.toString()));
            response.addCookie(new Cookie("VisitingCount", "0"));
        }

//        try {
//            connection = ConnectionFactory.getConnection();
//            UserDaoImpl = new UserDaoImpl(connection);
//        } catch (SQLException e) {
//            System.out.println(e.getMessage());
//        }



//        User inputUser = new User(login, password, "");
//        inputUser.setPassword(inputUser.getEncodedPassword());
//
//        ArrayList<User> users = new ArrayList<>();
//
//        try {
//            users = UserDaoImpl.getAllUsers();
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }

        cookies = request.getCookies();

        Cookie lastSessionDateCookie = findCookieByName(cookies, "LastSessionDate");
        Cookie lastSessionTimeCookie = findCookieByName(cookies, "LastSessionTime");
        Cookie visitingCountCookie = findCookieByName(cookies, "VisitingCount");
        Cookie countCookie = findCookieByName(cookies, "VisitingCount");



//        for(User user: users) {
//            if (user.equals(inputUser)) {
//                currentUser = user;
//                currentUser.setPassword(password);
//                break;
//            }
//        }
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        out.println("<html>");
        out.println("<body>");
        out.println("<h1>Welcome!</h1>");
        out.println("<p>Login: " + login + "</p>");
        out.println("<p>Password: " + password + "</p>");
        out.println("<p>Role: " + role + "</p>");
        out.println("<p>Current time: " + LocalTime.now() + "</p>");
        out.println("<p>Current date: " + LocalDateTime.now() + "</p>");
        out.println("<p>Last session date: " + lastSessionDateCookie.getValue() + "</p>");
        out.println("<p>Last session time: " + lastSessionTimeCookie.getValue() + "</p>");
        out.println("<p>Visiting count: " + visitingCountCookie.getValue() + "</p>");
        out.println("</body>");
        out.println("</html>");

//        boolean isCurrentForm = false;
//        User currentUser = null;
//
//        for(User user: users) {
//            if (user.equals(inputUser)) {
//                isCurrentForm = true;
//                currentUser = user;
//                currentUser.setPassword(password);
//                break;
//            }
//        }
//
//        if (isCurrentForm) {
//            out.println("<html>");
//            out.println("<body>");
//            out.println("<h1>Welcome!</h1>");
//            out.println("<p>Login: " + currentUser.getLogin() + "</p>");
//            out.println("<p>Password: " + currentUser.getPassword() + "</p>");
//            out.println("<p>Role: " + currentUser.getRole() + "</p>");
//            out.println("<p>Current time: " + LocalTime.now() + "</p>");
//            out.println("<p>Current date: " + LocalDateTime.now() + "</p>");
//            out.println("<p>Last session date: " + lastSessionDateCookie.getValue() + "</p>");
//            out.println("<p>Last session time: " + lastSessionTimeCookie.getValue() + "</p>");
//            out.println("<p>Visiting count: " + visitingCountCookie.getValue() + "</p>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//        else {
//            out.println("<html>");
//            out.println("<body>");
//            out.println("<h1>Access denied!</h1>");
//            out.println("<a href=\"ex2.jsp\">Back to form</a>");
//            out.println("<p>Last session date: " + lastSessionDateCookie.getValue() + "</p>");
//            out.println("<p>Last session time: " + lastSessionTimeCookie.getValue() + "</p>");
//            out.println("<p>Visiting count: " + visitingCountCookie.getValue() + "</p>");
//            out.println("</body>");
//            out.println("</html>");
//        }
        lastSessionDateCookie.setValue(currentDate.toString());
        lastSessionTimeCookie.setValue(currentTime.toString());
        countCookie.setValue(String.valueOf(Integer.parseInt(countCookie.getValue()) + 1));
        response.addCookie(lastSessionDateCookie);
        response.addCookie(lastSessionTimeCookie);
        response.addCookie(countCookie);
    }

    private Cookie findCookieByName(Cookie[] cookies, String name) {
        Cookie cookie = null;
        for(Cookie c: cookies) {
            if(name.equals(c.getName())) {
                cookie = c;
                break;
            }
        }
        return  cookie;
    }
}
