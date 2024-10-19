package com.example.lab12;
import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader {
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = ConfigLoader.class.getClassLoader().getResourceAsStream("database.properties")) {
            if (input == null) {
                throw new RuntimeException("Unable to find database.properties");
            }
            properties.load(input);
        } catch (Exception e) {
            throw new RuntimeException("Error loading database properties", e);
        }
    }
    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
    public static String getName() {
        return properties.getProperty("name");
    }
}
