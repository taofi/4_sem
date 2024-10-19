package database;

import model.Univer;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Date;

import static database.QueryConstants.ADD_UNIVER;
import static database.QueryConstants.SELECT_ALL_UNIVER;

public class UniverDaoImpl implements UniverDao{

    private final Connection connection;
    public UniverDaoImpl(Connection connection) {
        this.connection = connection;
    }

    public ArrayList<Univer> convertResultSetToUniverArrayList(ResultSet resultSet) throws SQLException {
        if (!resultSet.next()) {
            return new ArrayList<Univer>();
        }

        ArrayList<Univer> univer = new ArrayList<Univer>();

        do {
            int id = resultSet.getInt(1);
            String name = resultSet.getString(2);
            String recipient = resultSet.getString(3);
            Date date = resultSet.getDate(4);
            univer.add(new Univer(id, name, recipient, date));
        } while (resultSet.next());

        return univer;
    }
    @Override
    public void deleteById(int id) throws SQLException {
        Statement statement = connection.createStatement();
        statement.executeUpdate(String.format("delete from univer where Id = %d", id));
    }

    @Override
    public ArrayList<Univer> getAllUniver() throws SQLException {
        PreparedStatement statement = connection.prepareStatement(SELECT_ALL_UNIVER);
        ResultSet resultSet = statement.executeQuery();
        return convertResultSetToUniverArrayList(resultSet);
    }
    @Override
    public void addUniver(Univer univer) throws SQLException {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(ADD_UNIVER);

            preparedStatement.setString(1, univer.getName());
            preparedStatement.setString(2, univer.getCity());
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String dateString = dateFormat.format(univer.getYear());
            preparedStatement.setDate(3, java.sql.Date.valueOf(dateString));

            preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
