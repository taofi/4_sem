package database;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
public class ConnectionFactory{

    public static Connection getConnection() throws SQLException, IOException{
        try{
            Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
        }
        catch(Exception ex){
            System.out.println("Connection to jdbc failed...");
            System.out.println(ex);
        }
        Properties props = new Properties();
        try (InputStream input = ConnectionFactory.class.getClassLoader().getResourceAsStream("database.properties")) {
            props.load(input);
        }
        String url = props.getProperty("url");
        String username = props.getProperty("username");
        String password = props.getProperty("password");

        return DriverManager.getConnection(url, username, password);
    }
}