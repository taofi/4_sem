package database.repository.bdconstants;

public enum UniverConstants {
    ID("id"),
    NAME("name"),
    CITY("city"),
    FOUNDATION("foundation");
    private final String fieldName;

    private UniverConstants(String fieldName) {
        this.fieldName = fieldName;
    }
    public String getFieldName() {
        return fieldName;
    }
}
