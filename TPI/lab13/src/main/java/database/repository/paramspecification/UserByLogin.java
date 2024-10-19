package database.repository.paramspecification;

import java.util.Arrays;
import java.util.List;

public class UserByLogin implements Parameter {
    private final String login;
    public UserByLogin(String login) {
        this.login = login;
    }
    @Override
    public List<Object> getParameters() {
        return Arrays.asList(login);
    }
}