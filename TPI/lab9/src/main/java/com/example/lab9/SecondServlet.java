package com.example.lab9;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "SecondServlet", value = "/secondServlet")
public class SecondServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter writer = response.getWriter();
        String p1 = (String) request.getAttribute("message");
        String p2 = (String) request.getAttribute("secondMessage");

        writer.println("<h2>" + p1 + "</h2>");
        writer.println("<h2>" + p2 + "</h2>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("secondMessage", "server");
        request.getRequestDispatcher("/result.jsp").forward(request, response);
    }
}
