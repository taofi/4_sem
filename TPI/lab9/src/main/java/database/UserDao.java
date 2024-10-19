package database;

import model.User;

import java.sql.SQLException;
import java.util.ArrayList;

public interface UserDao {
    ArrayList<User> getAllUsers() throws SQLException;
    boolean add(User entity) throws  SQLException;
}
