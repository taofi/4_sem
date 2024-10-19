package database;

import model.Univer;

import java.sql.SQLException;
import java.util.ArrayList;

public interface UniverDao {

    ArrayList<Univer> getAllUniver() throws SQLException;
    void deleteById(int id) throws SQLException;
    void addUniver(Univer schedule) throws SQLException;
}
