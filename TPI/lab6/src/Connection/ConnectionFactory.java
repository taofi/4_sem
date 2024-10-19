package Connection;

import org.apache.log4j.chainsaw.Main;

import java.sql.*;
import java.io.*;
import java.util.*;
public class ConnectionFactory{

    public static Connection getConnection() throws SQLException, IOException{

        Properties props = new Properties();
        try (InputStream in = Main.class.getClassLoader().getResourceAsStream("Connection/database.properties")) {
            props.load(in);
        }
        String url = props.getProperty("url");
        String username = props.getProperty("username");
        String password = props.getProperty("password");

        return DriverManager.getConnection(url, username, password);
    }
}