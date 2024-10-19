package com.example.lab10univers;

import database.ConnectionFactory;
import database.UniverDao;
import database.UniverDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;


@WebServlet(name = "DeleteServlet", value = "/delete_servlet")
public class DeleteServlet extends HttpServlet {

    private UniverDao univerDao = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("delete_id"));

        try {
            Connection connection = ConnectionFactory.getConnection();
            univerDao = new UniverDaoImpl(connection);
            univerDao.deleteById(id);
        }
        catch(Exception e) {
            request.setAttribute("exception", e);
            request.setAttribute("errorMessage", e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        response.sendRedirect("views/welcome.jsp");
    }

}
