package com.example.lab13.command.factory;

public enum CommandType {
    LOGIN("login"),
    SIGN_OUT("sign_out"),
    WELCOME("welcome"),
    REGISTER_NEW_USER("register_new_user"),
    ADD_SCHEDULE("add_schedule"),
    REMOVE_SCHEDULE("remove_schedule"),
    EDIT_SCHEDULE("edit_schedule"),
    LOGIN_PAGE("login_page"),
    REGISTRATION_PAGE("registration_page");
    private CommandType(String command) {
    }

}
