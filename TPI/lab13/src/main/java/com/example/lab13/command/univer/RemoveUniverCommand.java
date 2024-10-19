package com.example.lab13.command.univer;

import com.example.lab13.command.Command;
import com.example.lab13.command.CommandResult;
import com.example.lab13.command.authorization.RegisterNewUserCommand;
import com.example.lab13.exception.IncorrectDataException;
import com.example.lab13.exception.ServiceException;
import com.example.lab13.service.UniverService;
import com.example.lab13.util.Page;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.Optional;
import java.util.logging.Logger;

import static java.util.Optional.of;

public class RemoveUniverCommand implements Command {
    private static final Logger LOGGER = Logger.getLogger(RegisterNewUserCommand.class.getName());

    @Override
    public CommandResult execute(HttpServletRequest request, HttpServletResponse response) throws ServiceException, IncorrectDataException {
        Optional<String> id = of(request).map(req -> req.getParameter("id"));

        if (id.orElse("").isEmpty()) {
            LOGGER.warning("Invalid id  format was received: " + id);
            return new CommandResult(Page.WELCOME_PAGE.getPage(), false);
        }

        UniverService univerService = new UniverService();
        try {
            univerService.remove( Integer.parseInt(String.valueOf(id)));
        } catch (ServiceException e) {
            LOGGER.severe("Error while remove univer: " + e.getMessage());
            throw new ServiceException("Error while remove univer", e);
        }
        return new CommandResult(Page.WELCOME_PAGE.getPage(), true);
    }
}
