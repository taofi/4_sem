package com.example.lab9;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "FirstBServlet", value = "/getFirstServlet")
public class FirstServletB extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean useForward = request.getParameter("forward") != null && request.getParameter("forward").equals("true");
        if (useForward) {
            request.setAttribute("message", "hello");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/getSecondServlet");
            dispatcher.forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("message", "hello");

            response.sendRedirect("getSecondServlet");
        }

    }
}
