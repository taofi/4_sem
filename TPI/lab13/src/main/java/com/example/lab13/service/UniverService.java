package com.example.lab13.service;

import com.example.lab13.exception.RepositoryException;
import com.example.lab13.exception.ServiceException;
import database.repository.RepositoryCreator;
import database.repository.UniverRepository;
import model.Univer;

import java.util.List;

public class UniverService {
    public List<Univer> findAll() throws ServiceException {
        try (RepositoryCreator repositoryCreator = new RepositoryCreator()) {
            UniverRepository personRepository = repositoryCreator.getUniverRepository();
            return personRepository.findAll();
        } catch (RepositoryException e) {
            throw new ServiceException(e.getMessage(), e);
        }
    }
    public void save(Univer univer) throws ServiceException {
        try (RepositoryCreator repositoryCreator = new RepositoryCreator()) {
            UniverRepository univerRepository = repositoryCreator.getUniverRepository();
            univerRepository.save(univer);
        } catch (RepositoryException exception) {
            throw new ServiceException(exception.getMessage(), exception);
        }
    }
    public void remove(int id) throws ServiceException {
        try (RepositoryCreator repositoryCreator = new RepositoryCreator()) {
            UniverRepository personRepository = repositoryCreator.getUniverRepository();
            personRepository.deleteById(id);
        } catch (RepositoryException exception) {
            throw new ServiceException(exception.getMessage(), exception);
        }
    }

}
