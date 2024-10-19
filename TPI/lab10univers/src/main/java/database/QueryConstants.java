package database;

public class QueryConstants {
    static String SELECT_ALL_UNIVER = "SELECT * FROM univer";
    static String SELECT_ALL_USER = "SELECT * FROM users";
    static String ADD_USER = "INSERT INTO users (login, password) " +
                                "VALUES (?, ?);\n";
    static String ADD_UNIVER = "INSERT INTO univer (name, city, foundation) \n" +
            "VALUES (?, ?, ?);\n";
}
