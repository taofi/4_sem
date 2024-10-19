package database.repository.bdconstants;

public enum UserConstants {
    LOGIN("login"),
    PASSWORD("password");
    private final String fieldName;

    private UserConstants(String fieldName) {
        this.fieldName = fieldName;
    }
    public String getFieldName() {
        return fieldName;
    }
}
