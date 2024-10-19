package com.example.lab13.command.authorization;

import com.example.lab13.command.Command;
import com.example.lab13.command.CommandResult;
import com.example.lab13.exception.IncorrectDataException;
import com.example.lab13.exception.ServiceException;
import com.example.lab13.service.UserService;
import com.example.lab13.util.HashPassword;
import com.example.lab13.util.SessionAttribute;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.util.Optional;
import java.util.logging.Logger;

import static com.example.lab13.command.authorization.constants.AuthConstants.*;
import static java.util.Optional.of;

public class LoginCommand implements Command {
    private static final Logger LOGGER = Logger.getLogger(LoginCommand.class.getName());
    private static final String PAGE_LOGIN = "/WEB-INF/views/login.jsp";  // Path to the login page

    private void setAttributesToSession(String name, HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute(SessionAttribute.NAME, name);
    }

    @Override
    public CommandResult execute(HttpServletRequest request, HttpServletResponse response) throws ServiceException, IncorrectDataException {
        Optional<String> login = of(request).map(httpServletRequest -> httpServletRequest.getParameter(LOGIN));
        Optional<String> password = of(request).map(httpServletRequest -> httpServletRequest.getParameter(PASSWORD));

        if (login.orElse("").isEmpty() || password.orElse("").isEmpty()) {
            return forwardLoginWithError(request, ERROR_MESSAGE, ERROR_MESSAGE_TEXT);
        }

        String hashedPassword = HashPassword.getHash(password.get());
        boolean isUserFound = initializeUserIfExist(login.get(), hashedPassword, request);

        if (!isUserFound) {
            LOGGER.info("User with such login and password doesn't exist");
            return forwardLoginWithError(request, ERROR_MESSAGE, AUTHENTICATION_ERROR_TEXT);
        } else {
            LOGGER.info("User has been authorized: login=" + login.get());
            return new CommandResult(COMMAND_WELCOME, false);
        }
    }

    public boolean initializeUserIfExist(String login, String password, HttpServletRequest request) throws ServiceException, ServiceException {
        UserService userService = new UserService();
        Optional<User> user = userService.login(login, password);
        if (user.isPresent()) {
            setAttributesToSession(user.get().getLogin(), request);
            return true;
        }
        return false;
    }

    private CommandResult forwardLoginWithError(HttpServletRequest request, final String error, final String errorMessage) {
        request.setAttribute(error, errorMessage);
        return new CommandResult(PAGE_LOGIN, true);
    }
}
