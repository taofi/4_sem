package database.repository;

import com.example.lab13.builder.UserBuilder;
import com.example.lab13.exception.RepositoryException;
import database.repository.bdconstants.UserConstants;
import database.repository.paramspecification.Parameter;
import model.User;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class UserRepository extends AbstractRepository <User>{
    public UserRepository(Connection connection){
        super(connection);
    }
    @Override
    protected String getTableName() {
        return SQLHelper.USER_TABLE;
    }
    @Override
    public List<User> query(String sqlString, Parameter paramater) throws RepositoryException {
        List<User> users = executeQuery(sqlString,new UserBuilder(), paramater.getParameters());
        return users;
    }
    @Override
    public Optional<User> queryForSingleResult(String sqlString, Parameter parameter) throws RepositoryException {
        List<User> user = query(sqlString, parameter);
        return user.size() == 1 ?
                Optional.of(user.get(0)) :
                Optional.empty();
    }
    public Map<String,Object> getFields(User user) {
        Map<String,Object> fields = new HashMap<>();
        fields.put(UserConstants.LOGIN.getFieldName(), user.getLogin());
        fields.put(UserConstants.PASSWORD.getFieldName(), user.getPassword());
        return fields;
    }
}

