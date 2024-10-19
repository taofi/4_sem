package com.example.lab13.command;

import com.example.lab13.exception.IncorrectDataException;
import com.example.lab13.exception.ServiceException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface Command {
    CommandResult execute(HttpServletRequest request, HttpServletResponse response) throws ServiceException, IncorrectDataException;
}
