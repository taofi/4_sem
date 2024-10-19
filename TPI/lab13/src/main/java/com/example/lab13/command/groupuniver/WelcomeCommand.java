package com.example.lab13.command.groupuniver;

import com.example.lab13.command.Command;
import com.example.lab13.command.CommandResult;
import com.example.lab13.exception.IncorrectDataException;
import com.example.lab13.exception.ServiceException;
import com.example.lab13.service.UniverService;
import com.example.lab13.util.Page;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Univer;

import java.util.List;

import static com.example.lab13.command.groupuniver.constants.GroupConstants.LISTGROUP;

public class WelcomeCommand implements Command {
    @Override
    public CommandResult execute(HttpServletRequest request, HttpServletResponse response)
            throws ServiceException, IncorrectDataException{
        UniverService personService = new UniverService();
        List<Univer> clients = personService.findAll();
        if (!clients.isEmpty()) {
            request.setAttribute(LISTGROUP, clients);
        }
        return new CommandResult(Page.WELCOME_PAGE.getPage(), false);
    }
}