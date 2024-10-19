package com.example.lab9;

import java.io.*;
import java.time.LocalTime;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "currentTime", value = "/currentTime")
public class CurrentTimeServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        LocalTime now = LocalTime.now();
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h2>Current time is: </h2>");
        out.println("<h2>" + now + "</h2>");
        out.println("<h3>" + "Protocol: " + request.getProtocol() + "</h3>");
        out.println("<h3>" + "IP Address: " + request.getRemoteAddr() + "</h3>");
        out.println("<h3>" + "Client Name: " + request.getRemoteHost() + "</h3>");
        out.println("<h3>" + "Method: " + request.getMethod() + "</h3>");
        out.println("<h3>" + "URL: " + request.getRequestURL().toString() + "</h3>");
        out.println("<h3>" + "Parameters: " + request.getQueryString() + "</h3>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}