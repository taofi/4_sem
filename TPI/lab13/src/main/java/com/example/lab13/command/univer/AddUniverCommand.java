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
import model.Univer;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;
import java.util.logging.Logger;

import static java.util.Optional.of;

public class AddUniverCommand implements Command {
    private static final Logger LOGGER = Logger.getLogger(RegisterNewUserCommand.class.getName());

    @Override
    public CommandResult execute(HttpServletRequest request, HttpServletResponse response) throws ServiceException, IncorrectDataException {
        Optional<String> name = of(request).map(req -> req.getParameter("name"));
        Optional<String> city = of(request).map(req -> req.getParameter("city"));
        Optional<String> foundation = of(request).map(req -> req.getParameter("foundation"));


        if (name.orElse("").isEmpty() || city.orElse("").isEmpty()|| foundation.orElse("").isEmpty()) {
            LOGGER.warning("Invalid name or city, foundation or  format was received: " + name + " " + city + " " + foundation);
            return new CommandResult(Page.WELCOME_PAGE.getPage(), false);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date;
        try{
            date = sdf.parse(foundation.get());
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        Univer univer = new Univer(0, name.get(), city.get(), date);
        UniverService univerService = new UniverService();

        try {
            univerService.save(univer);

        } catch (ServiceException e) {
            LOGGER.severe("Error while add univer: " + e.getMessage());
            throw new ServiceException("Error while add univer", e);
        }
        return new CommandResult(Page.WELCOME_PAGE.getPage(), true);
    }
}
