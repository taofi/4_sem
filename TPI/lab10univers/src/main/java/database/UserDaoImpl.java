package database;

import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static database.QueryConstants.*;

public class UserDaoImpl implements UserDao {
    private final Connection connection;

    public UserDaoImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public ArrayList<User> getAllUsers() throws SQLException {
        PreparedStatement statement = connection.prepareStatement(SELECT_ALL_USER);
        ResultSet resultSet = statement.executeQuery();
        return convertResultSetToUserArrayList(resultSet);
    }


    @Override
    public boolean add(User entity) throws SQLException {
        PreparedStatement statement = connection.prepareStatement(ADD_USER);
        statement.setString(1, entity.getLogin());
        statement.setString(2, entity.getPassword());
        int rows = statement.executeUpdate();
        return rows > 0;
    }

    public ArrayList<User> convertResultSetToUserArrayList(ResultSet resultSet) throws SQLException {
        if (!resultSet.next()) {
            return new ArrayList<User>();
        }

        ArrayList<User> users = new ArrayList<User>();

        do {
            String login = resultSet.getString(1);
            String password = resultSet.getString(2);
            users.add(new User(login, password));
        } while (resultSet.next());

        return users;
    }

}
