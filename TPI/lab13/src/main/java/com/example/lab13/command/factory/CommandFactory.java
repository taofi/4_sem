package com.example.lab13.command.factory;


import com.example.lab13.command.Command;
import com.example.lab13.command.LoginPageCommand;
import com.example.lab13.command.RegisterPageCommand;
import com.example.lab13.command.authorization.LoginCommand;
import com.example.lab13.command.authorization.RegisterNewUserCommand;
import com.example.lab13.command.authorization.SingOutCommand;
import com.example.lab13.command.groupuniver.WelcomeCommand;
import com.example.lab13.command.univer.AddUniverCommand;
import com.example.lab13.command.univer.EditUniverCommand;
import com.example.lab13.command.univer.RemoveUniverCommand;

public class CommandFactory {
    public static Command create(String command) {
        command = command.toUpperCase();
        CommandType commandEnum = CommandType.valueOf(command);
        Command resultCommand;
        switch (commandEnum) {
            case LOGIN: {
                resultCommand = new LoginCommand(); break;
            }
            case REGISTER_NEW_USER: {
                resultCommand = new RegisterNewUserCommand(); break;
            }
            case SIGN_OUT: {
                resultCommand = new SingOutCommand(); break;
            }
            case ADD_SCHEDULE:{
                resultCommand = new AddUniverCommand(); break;
            }
            case REMOVE_SCHEDULE:{
                resultCommand = new RemoveUniverCommand(); break;
            }
            case EDIT_SCHEDULE:{
                resultCommand = new EditUniverCommand(); break;
            }
            case LOGIN_PAGE:{
                resultCommand = new LoginPageCommand(); break;
            }
            case WELCOME:{
                resultCommand = new WelcomeCommand(); break;
            }
            case REGISTRATION_PAGE:{
                resultCommand = new RegisterPageCommand(); break;
            }
            default: {
                throw new IllegalArgumentException("Invalid command" + commandEnum);
            }
        }
        return resultCommand;
    }

}
