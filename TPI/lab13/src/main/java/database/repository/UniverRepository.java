package database.repository;

import com.example.lab13.builder.UniverBuilder;
import com.example.lab13.connection.ConnectionPool;
import com.example.lab13.exception.IncorrectDataException;
import com.example.lab13.exception.RepositoryException;
import database.repository.bdconstants.UniverConstants;
import database.repository.paramspecification.Parameter;
import model.Univer;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class UniverRepository extends AbstractRepository<Univer> {
    public UniverRepository(Connection connection){
        super(connection);
    }
    @Override
    protected String getTableName() {
        return SQLHelper.UNIVER_TABLE ;
    }
    @Override
    public List<Univer> query(String sqlString, Parameter paramater) throws RepositoryException {
        List<Univer> persons = executeQuery(sqlString,new UniverBuilder(), paramater.getParameters());
        return persons;
    }
    @Override
    public Optional<Univer> queryForSingleResult(String sqlString, Parameter parameter) throws RepositoryException {
        List<Univer> person = query(sqlString, parameter);
        return person.size() == 1 ?
                Optional.of(person.get(0)) :
                Optional.empty();
    }
    public static void deleteById(int id) throws RepositoryException {
        ConnectionPool connection = ConnectionPool.getInstance();
        try {
            Statement statement = connection.getConnection().createStatement();
            statement.executeUpdate(SQLHelper.SQL_DELETE_UNIVER + id);
            throw new IncorrectDataException("Ошибка при удаление");
        } catch (SQLException e) {
            System.out.println("Ошибка при удалении расписания по id");
            throw new RepositoryException(e.getMessage());
        } catch (IncorrectDataException e) {
            System.out.println(e.getMessage());
        }

    }

    public Map<String,Object> getFields(Univer person) {
        Map<String,Object> fields = new HashMap<>();
        fields.put(UniverConstants.NAME.getFieldName(), person.getName());
        fields.put(UniverConstants.CITY.getFieldName(), person.getCity());
        fields.put(UniverConstants.FOUNDATION.getFieldName(), person.getYear());
        return fields;
    }
}
