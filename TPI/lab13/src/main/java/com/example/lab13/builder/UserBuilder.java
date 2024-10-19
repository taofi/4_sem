package com.example.lab13.builder;

import com.example.lab13.exception.RepositoryException;
import database.repository.bdconstants.UserConstants;
import model.User;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserBuilder implements Builder<User> {
    @Override
    public User build(ResultSet resultSet) throws RepositoryException {
        try {
            String login = resultSet.getString(UserConstants.LOGIN.getFieldName());
            String password = resultSet.getString(UserConstants.PASSWORD.getFieldName());
            return new User(login, password);
        }
        catch (SQLException exception) {
            throw new RepositoryException(exception.getMessage(), exception);
        }
    }
}

