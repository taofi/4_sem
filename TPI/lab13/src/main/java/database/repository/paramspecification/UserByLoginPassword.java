package database.repository.paramspecification;

import java.util.Arrays;
import java.util.List;

public class UserByLoginPassword implements Parameter {
    private final String login;
    private final String password;
    public UserByLoginPassword(String login,String password) {
        this.login = login;
        this.password = password;
    }
    @Override
    public List<Object> getParameters() {
        return Arrays.asList(login, password);
    }
}