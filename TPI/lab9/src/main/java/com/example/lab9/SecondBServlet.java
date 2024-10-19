package com.example.lab9;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "SecondServletB", value = "/getSecondServlet")
public class SecondBServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        boolean useForward = request.getParameter("forward") != null && request.getParameter("forward").equals("true");
        if (useForward) {
            request.setAttribute("secondMessage", "second servlet");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/result.jsp");
            dispatcher.forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("secondMessage", "second servlet");
            response.sendRedirect("result.jsp");
        }
    }
}
