package database.repository;

import database.repository.bdconstants.UniverConstants;
import database.repository.bdconstants.UserConstants;

import java.util.Map;

public class SQLHelper {
    public static final String ID = "id";
    private static final String INSERT_QUERY = "INSERT INTO ";
    private static final String VALUES = "VALUES";
    private static final String WHERE = "WHERE ";
    private static final String SELECT = "SELECT";
    public static final String USER_TABLE = "users";
    public static final String UNIVER_TABLE = "univer";
    public static final String SQL_DELETE_UNIVER = "delete from" + UNIVER_TABLE + WHERE +ID + "=";
    public final static String SQL_GET_UNIVER = "select * from " + UNIVER_TABLE;
    public final static String SQL_INSERT_UNIVER = "INSERT INTO " + UNIVER_TABLE + "(" + UniverConstants.NAME +
            "," + UniverConstants.CITY + "," + UniverConstants.FOUNDATION + ") VALUES (? , ?, ?)";
    public final static String SQL_GET_USER = "SELECT " +
            UserConstants.LOGIN.getFieldName() + ", " +
            UserConstants.PASSWORD.getFieldName() + " from " + USER_TABLE + " WHERE " +
            UserConstants.LOGIN.getFieldName() + " =? and " +
            UserConstants.PASSWORD.getFieldName() + " =?";
    public final static String SQL_CHECK_LOGIN = "SELECT " + UserConstants.LOGIN.getFieldName() + " FROM " +
            USER_TABLE + " WHERE " + UserConstants.LOGIN.getFieldName() + " = ?";
    public final static String SQL_INSERT_USER = "INSERT INTO " + USER_TABLE + "(" +
            UserConstants.LOGIN.getFieldName() + " ," +
            UserConstants.PASSWORD.getFieldName() + ") VALUES (? , ?)";

    public static String makeInsertQuery(Map<String, Object> fields, String table) {
        StringBuilder columns = new StringBuilder("(");
        StringBuilder values = new StringBuilder("(");
        for (Map.Entry<String, Object> entry : fields.entrySet()) {
            String column = entry.getKey();
            if (column.equals(ID)) {
                continue;
            }
            columns.append(column).append(", ");
            values.append("?, ");
        }
        values.deleteCharAt(values.lastIndexOf(","));
        columns.deleteCharAt(columns.lastIndexOf(","));
        values.append(")");
        columns.append(")");
        return INSERT_QUERY + table + " " + columns.toString() + " " + VALUES + " " + values.toString();
    }
}