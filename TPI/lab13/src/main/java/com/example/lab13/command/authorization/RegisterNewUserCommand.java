package com.example.lab13.command.authorization;

import com.example.lab13.command.Command;
import com.example.lab13.command.CommandResult;
import com.example.lab13.exception.IncorrectDataException;
import com.example.lab13.exception.ServiceException;
import com.example.lab13.service.UserService;
import com.example.lab13.util.HashPassword;
import com.example.lab13.util.Page;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.util.Optional;
import java.util.logging.Logger;

import static com.example.lab13.command.authorization.constants.AuthConstants.*;
import static com.example.lab13.command.groupuniver.constants.GroupConstants.ERROR_MESSAGE_TEXT;
import static java.util.Optional.of;

public class RegisterNewUserCommand implements Command {
    private static final Logger LOGGER = Logger.getLogger(RegisterNewUserCommand.class.getName());

    private CommandResult forwardToRegisterWithError(HttpServletRequest request, String error, String errorMessage) {
        request.setAttribute(error, errorMessage);
        return new CommandResult(Page.REGISTER_PAGE.getPage(), false);
    }

    private CommandResult forwardToLogin(HttpServletRequest request) {
        return new CommandResult(Page.LOGIN_PAGE.getPage(), true);
    }

    @Override
    public CommandResult execute(HttpServletRequest request, HttpServletResponse response) throws ServiceException, IncorrectDataException {
        Optional<String> login = of(request).map(req -> req.getParameter(NAME_FOR_REGISTER)); // Assume "login" is the parameter name for registration
        Optional<String> password = of(request).map(req -> req.getParameter(PASSWORD_FOR_REGISTER)); // Assume "password" is the parameter name for registration

        if (login.orElse("").isEmpty() || password.orElse("").isEmpty()) {
            LOGGER.warning("Invalid login or password format was received: " + login + " " + password);
            return forwardToRegisterWithError(request, REGISTER_ERROR, ERROR_MESSAGE_TEXT);
        }

        String hashedPassword = HashPassword.getHash(password.get());
        User user = new User(login.get(), hashedPassword); // Ensure User class has appropriate constructor
        UserService userService = new UserService();

        try {
            int userCount = userService.save(user);
            if (userCount != 0) {
                LOGGER.info("User was registered successfully: login=" + login.get());
                return forwardToLogin(request);
            } else {
                LOGGER.warning("User with login " + login.get() + " already exists.");
                return forwardToRegisterWithError(request, REGISTER_ERROR, REGISTER_ERROR_MESSAGE_IF_EXIST);
            }
        } catch (ServiceException e) {
            LOGGER.severe("Error while registering user: " + e.getMessage());
            throw new ServiceException("Error while registering user", e);
        }
    }
}
