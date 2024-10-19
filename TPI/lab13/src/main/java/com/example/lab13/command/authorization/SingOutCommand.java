package com.example.lab13.command.authorization;

import com.example.lab13.command.Command;
import com.example.lab13.command.CommandResult;
import com.example.lab13.exception.IncorrectDataException;
import com.example.lab13.exception.ServiceException;
import com.example.lab13.util.Page;
import com.example.lab13.util.SessionAttribute;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.util.logging.Logger;

public class SingOutCommand implements Command {
    private static final Logger LOGGER = Logger.getLogger(SingOutCommand.class.getName());
    @Override
    public CommandResult execute(HttpServletRequest request, HttpServletResponse response) throws ServiceException, IncorrectDataException {
        HttpSession session = request.getSession();
        String username = (String)session.getAttribute(SessionAttribute.NAME);
        LOGGER.info("user was above: name:" + username);
        session.removeAttribute(SessionAttribute.NAME);
        return new CommandResult(Page.LOGIN_PAGE.getPage(), false);
    }
}

