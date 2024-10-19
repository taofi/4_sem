package database;

public class QueryConstants {
    static String SELECT_ALL_USER = "SELECT * FROM user";
    static String ADD_USER = "INSERT INTO user (login, password, role) " +
                                "VALUES (?, ?, ?);\n";
}
