package DAO;

import Objects.Letter;
import Objects.Person;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static DAO.QueryConstants.*;

public class MailDaoImpl implements MailDao<Person> {
    private final Connection connection;
    public MailDaoImpl(Connection connection) {
        this.connection = connection;
    }
    public Person convertResultSetToPerson(ResultSet resultSet) throws SQLException {
        if (!resultSet.next()) {
            return null;
        }
        String fullname = resultSet.getString(1);
        Date date = resultSet.getDate(2);
        return new Person(fullname, date);
    }
    public Letter convertResultSetToLetter(ResultSet resultSet) throws SQLException {
        if (!resultSet.next()) {
            return null;
        }
        int id = resultSet.getInt(1);
        String sender = resultSet.getString(2);
        String recipient = resultSet.getString(3);
        String subject = resultSet.getString(4);
        String text = resultSet.getString(5);
        Date date = resultSet.getDate(6);
        return new Letter(id, sender, recipient, subject, text, date);
    }
    public ArrayList<Person> convertResultSetToPersonArrayList(ResultSet resultSet) throws SQLException {
        if (!resultSet.next()) {
            return null;
        }
        ArrayList<Person> weathers = new ArrayList<Person>();
        do {
            String fullname = resultSet.getString(1);
            Date dateValue =resultSet.getDate(2);
            weathers.add(new Person(fullname, dateValue));
        } while (resultSet.next());
        return weathers;
    }
    public ArrayList<Person> convertResultSetToPersonArrayListSendGet(ResultSet resultSet) throws SQLException {
        if (!resultSet.next()) {
            return null;
        }
        ArrayList<Person> weathers = new ArrayList<Person>();
        do {
            String fullname = resultSet.getString(1);
            java.sql.Date dateValue = new java.sql.Date(resultSet.getLong(2));
            int sentLetters = resultSet.getInt("sent_letters");
            int receivedLetters = resultSet.getInt("received_letters");
            Person pers = new Person(fullname, dateValue);
            weathers.add(pers);
            System.out.println(pers + " send: " + sentLetters + " get: " + receivedLetters);
        } while (resultSet.next());
        return weathers;
    }
    @Override
    public Person getPersonWithMinLetterSize() throws SQLException {
        PreparedStatement statement = connection.prepareStatement(SELECT_PERSON_MIN_LETTER_SIZE);
        ResultSet resultSet = statement.executeQuery();
        return convertResultSetToPerson(resultSet);
     //   return null;
    }

    @Override
    public List<Person> getAllUserInfo() throws SQLException {
        PreparedStatement statement = connection.prepareStatement(SELECT_USER_INFO);
        ResultSet resultSet = statement.executeQuery();
        System.out.println(resultSet);
        return convertResultSetToPersonArrayListSendGet(resultSet);
    }

    @Override
    public List<Person> getAllPersonGetSubjectLetter(String SubjectLetter) throws SQLException {
        PreparedStatement statement = connection.prepareStatement(SELECT_PERSON_GET_LETTER_WITH_SUBJECT);
        statement.setString(1, SubjectLetter);
        ResultSet resultSet = statement.executeQuery();
        return convertResultSetToPersonArrayList(resultSet);
    }

    @Override
    public List<Person> getAllPersonNotGetSubjectLetter(String SubjectLetter) throws SQLException {
        PreparedStatement statement = connection.prepareStatement(SELECT_PERSON_NOT_GET_LETTER_WITH_SUBJECT);
        statement.setString(1, SubjectLetter);
        ResultSet resultSet = statement.executeQuery();
        return convertResultSetToPersonArrayList(resultSet);
    }
    public Letter findLetterWintSunderAndSubject(Person person, String SubjectLetter) throws SQLException
    {
        PreparedStatement statement = connection.prepareStatement(SELECT_LETTER_WITH_SENDER_AND_SUBJECT);
        statement.setString(1, person.getFullName());
        statement.setString(2, SubjectLetter);
        ResultSet resultSet = statement.executeQuery();
       return convertResultSetToLetter(resultSet);
    }
    @Override
    public boolean sendLetterToAllWithSubject(Person person, String SubjectLetter) throws SQLException {
        Letter letter = findLetterWintSunderAndSubject(person, SubjectLetter);
        System.out.println(letter);
        PreparedStatement statement = connection.prepareStatement(SEND_LETTER_TO_ALL);
        statement.setString(1, person.getFullName());
        statement.setString(2, letter.getSubject_of_letter());
        statement.setString(3, letter.getText());
        java.util.Date utilDate = letter.getDate();
        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
        statement.setDate(4, sqlDate);
        int count = statement.executeUpdate();
        System.out.println("Sent letter " + count);
        return count > 0;
    }
}
