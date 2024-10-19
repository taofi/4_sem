package com.example.lab10univers;

import database.ConnectionFactory;
import database.UniverDao;
import database.UniverDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Univer;

import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;


@WebServlet(name = "addServlet", value = "/add_servlet")
public class AddServlet extends HttpServlet {

    private UniverDao univerDao = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection connection = ConnectionFactory.getConnection();
            univerDao = new UniverDaoImpl(connection);
            String name = request.getParameter("name");
            String city = request.getParameter("city");
            String dateStr  = request.getParameter("date");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Создаем экземпляр SimpleDateFormat
            Date date = sdf.parse(dateStr );
            Univer univer = new Univer(0, name, city, date);
            univerDao.addUniver(univer);
        }
        catch(Exception e) {
            request.setAttribute("exception", e);
            request.setAttribute("errorMessage", e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        response.sendRedirect("views/welcome.jsp");
    }

}
