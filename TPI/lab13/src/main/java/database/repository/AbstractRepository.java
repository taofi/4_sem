package database.repository;

import com.example.lab13.builder.Builder;
import com.example.lab13.builder.BuilderFactory;
import com.example.lab13.exception.RepositoryException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.logging.Logger;

public abstract class AbstractRepository<T> implements Repository<T> {
    private static final Logger LOGGER = Logger.getLogger(AbstractRepository.class.getName());
    private static final String GET_ALL_QUERY = "SELECT * FROM ";
    private final String WHERE_ID_CONDITION = " WHERE id_" + getTableName() + "=?";
    protected final String DELETE_QUERY = "DELETE FROM " + getTableName() + WHERE_ID_CONDITION;
    private Connection connection;

    protected abstract String getTableName();

    public AbstractRepository(Connection connection) {
        this.connection = connection;
    }

    // Prepare request with parameters
    public static void prepare(PreparedStatement preparedStatement, List<Object> parameters) throws SQLException {
        for (int i = 0; i < parameters.size(); i++) {
            preparedStatement.setObject(i + 1, parameters.get(i));
        }
    }

    public static void prepare(PreparedStatement preparedStatement, Map<String, Object> fields) throws SQLException {
        int i = 1;
        for (Map.Entry<String, Object> entry : fields.entrySet()) {
            Object value = entry.getValue();
            if (value != null) {
                preparedStatement.setObject(i++, value);
            } else {
                preparedStatement.setNull(i++, java.sql.Types.NULL); // General null type, consider refining based on actual field type
            }
        }
    }

    List<T> executeQuery(String sql, Builder<T> builder, List<Object> parameters) throws RepositoryException {
        List<T> objects = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            prepare(preparedStatement, parameters);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                T item = builder.build(resultSet);
                objects.add(item);
            }
        } catch (SQLException e) {
            throw new RepositoryException(e.getMessage(), e);
        }
        return objects;
    }

    protected Optional<T> executeQueryForSingleResult(String query, Builder<T> builder, List<Object> parameters) throws RepositoryException {
        List<T> items = executeQuery(query, builder, parameters);
        return items.size() == 1 ? Optional.of(items.get(0)) : Optional.empty();
    }

    protected abstract Map<String, Object> getFields(T obj);

    @Override
    public Integer save(T object) throws RepositoryException {
        Map<String, Object> fields = getFields(object);
        String sql = SQLHelper.makeInsertQuery(fields, getTableName());
        return executeSave(sql, fields);
    }

    private Integer executeSave(String query, Map<String, Object> fields) throws RepositoryException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            prepare(preparedStatement, fields);
            LOGGER.info(preparedStatement.toString());
            preparedStatement.executeUpdate();
            ResultSet resultSet = preparedStatement.getGeneratedKeys();
            Integer generatedId = null;
            if (resultSet.next()) {
                generatedId = resultSet.getInt(1);
            }
            return generatedId;
        } catch (SQLException e) {
            throw new RepositoryException(e.getMessage(), e);
        }
    }

    @Override
    public List<T> findAll() throws RepositoryException {
        Builder<T> builder = BuilderFactory.create(getTableName());
        String query = GET_ALL_QUERY + getTableName();
        return executeQuery(query, builder, Collections.emptyList());
    }
}
