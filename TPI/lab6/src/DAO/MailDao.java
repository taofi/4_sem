package DAO;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

public interface MailDao<E> {
    E getPersonWithMinLetterSize() throws SQLException;
    List<E> getAllUserInfo() throws SQLException;
    List<E> getAllPersonGetSubjectLetter(String SubjectLetter) throws SQLException;
    List<E>  getAllPersonNotGetSubjectLetter(String SubjectLetter) throws SQLException;
    boolean sendLetterToAllWithSubject(E person, String SubjectLetter) throws SQLException;
}