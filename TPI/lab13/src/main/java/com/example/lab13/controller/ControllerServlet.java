package com.example.lab13.controller;


import com.example.lab13.command.Command;
import com.example.lab13.command.CommandResult;
import com.example.lab13.command.factory.CommandFactory;
import com.example.lab13.util.Page;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalTime;
import java.util.logging.Logger;

public class ControllerServlet extends HttpServlet {
    private static final String COMMAND = "command";
    private static final String ERROR_MESSAGE = "error";
    private static final Logger LOG = Logger.getLogger(ControllerServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String command = request.getParameter(COMMAND);
        Command action = CommandFactory.create(command);

        String timeStamp = LocalTime.now().toString();
        LOG.info("Log: " + command + "; " + timeStamp);

        CommandResult commandResult;
        try {
            commandResult = action.execute(request, response);
        } catch (Exception e) {
            request.setAttribute(ERROR_MESSAGE, e.getMessage());
            System.out.println(e.getMessage());
            commandResult = new CommandResult(Page.ERROR_PAGE.getPage(), false);
        }

        String page = commandResult.getPage();
        if (commandResult.isRedirect()) {
            sendDirect(response, page);
        }
        else {
            dispatch(request, response, page);
        }
    }

    private void sendDirect(HttpServletResponse response, String page) throws IOException {
        response.sendRedirect(page);
    }

    private void dispatch(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
        ServletContext servletContext = getServletContext();
        RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher(page);
        requestDispatcher.forward(request, response);
    }
    private void sendRedirect(HttpServletResponse response, String page) throws IOException {
        response.sendRedirect(page);
    }
}
