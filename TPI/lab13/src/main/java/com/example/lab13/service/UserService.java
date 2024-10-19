package com.example.lab13.service;

import com.example.lab13.exception.RepositoryException;
import com.example.lab13.exception.ServiceException;
import database.repository.RepositoryCreator;
import database.repository.SQLHelper;
import database.repository.UserRepository;
import database.repository.paramspecification.UserByLogin;
import database.repository.paramspecification.UserByLoginPassword;
import model.User;

import java.util.Optional;
public class
UserService {
    public Optional<User> login(String login, String password) throws ServiceException {
        try (RepositoryCreator repositoryCreator = new RepositoryCreator()) {
            UserRepository userRepository = repositoryCreator.getUserRepository();
            UserByLoginPassword params = new UserByLoginPassword(login, password);
            return userRepository.queryForSingleResult(SQLHelper.SQL_GET_USER, params);
        } catch (RepositoryException e) {
            throw new ServiceException(e.getMessage(), e);
        }
    }
    public Integer save(User user) throws ServiceException {
        try (RepositoryCreator repositoryCreator = new RepositoryCreator()) {
            UserRepository userRepository = repositoryCreator.getUserRepository();
            UserByLogin param = new UserByLogin(user.getLogin());
            if (!userRepository.queryForSingleResult(SQLHelper.SQL_CHECK_LOGIN, param).isPresent()) {
                return userRepository.save(user);
            } else {
                return 0;
            }
        } catch (RepositoryException exception) {
            throw new ServiceException(exception.getMessage(), exception);
        }
    }
}
