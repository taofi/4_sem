package com.example.lab13.command;

import com.example.lab13.util.Page;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginPageCommand implements Command {
    @Override
    public CommandResult execute(HttpServletRequest request,
                                 HttpServletResponse response) {
        System.out.println("LOGIN PAGE");
        return new CommandResult(Page.LOGIN_PAGE.getPage(),false);
    }
}
