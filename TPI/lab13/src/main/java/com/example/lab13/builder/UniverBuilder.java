package com.example.lab13.builder;

import com.example.lab13.exception.RepositoryException;
import database.repository.bdconstants.UniverConstants;
import model.Univer;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class UniverBuilder implements Builder <Univer>{
    @Override
    public Univer build(ResultSet resultSet) throws RepositoryException {
        try {
            int id = resultSet.getInt(UniverConstants.ID.getFieldName());
            String name = resultSet.getString(UniverConstants.NAME.getFieldName());
            String city = resultSet.getString(UniverConstants.CITY.getFieldName());
            Date date = resultSet.getDate(UniverConstants.FOUNDATION.getFieldName());
            return new Univer(id, name, city, date);
        } catch (SQLException exception) {
            throw new RepositoryException(exception.getMessage(), exception);
        }
    }
}
