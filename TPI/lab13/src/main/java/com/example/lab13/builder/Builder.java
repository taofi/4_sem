package com.example.lab13.builder;

import com.example.lab13.exception.RepositoryException;

import java.sql.ResultSet;

public interface Builder <T> {
    T build(ResultSet resultSet) throws
            RepositoryException, RepositoryException;
}