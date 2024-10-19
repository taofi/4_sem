package com.example.lab9;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "First7Servlet", value = "/first7Servlet")
public class First7Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (request.getAttribute("param1") == null) {
            ServletContext servletContext = getServletContext();
            RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher("/Second7Servlet");

            request.setAttribute("param1", "first param");
            request.setAttribute("param2", "server");

            requestDispatcher.include(request, response);
        }
        else {
            String attr1 = (String) request.getAttribute("param1");
            String attr2 = (String) request.getAttribute("param2");
            String attr3 = (String) request.getAttribute("param3");

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            out.println("<h1>" + attr1 + "</h1>");
            out.println("<h1>" + attr2 + "</h1>");
            out.println("<h1>" + attr3 + "</h1>");
        }
    }
}
