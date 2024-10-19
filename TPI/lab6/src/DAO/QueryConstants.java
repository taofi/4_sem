package DAO;

public class QueryConstants {
    static String SELECT_PERSON_MIN_LETTER_SIZE = "SELECT u.*, MIN(LENGTH(l.text)) AS min_letter_length\n" +
            "FROM mail.person u\n" +
            "JOIN mail.letter l ON u.full_name = l.sender\n" +
            "GROUP BY u.full_name\n" +
            "ORDER BY min_letter_length\n" +
            "LIMIT 1;\n";
    static String SELECT_USER_INFO = "SELECT u.full_name, \n" +
            "       COUNT(DISTINCT l1.id) AS sent_letters,\n" +
            "       COUNT(DISTINCT l2.id) AS received_letters\n" +
            "FROM mail.person u\n" +
            "LEFT JOIN mail.letter l1 ON u.Full_name = l1.sender\n" +
            "LEFT JOIN mail.letter l2 ON u.Full_name = l2.recipient\n" +
            "GROUP BY u.Full_name;";
    static String SELECT_PERSON_GET_LETTER_WITH_SUBJECT = "SELECT u.*\n" +
            "FROM mail.person u\n" +
            "JOIN mail.letter l ON u.Full_name = l.recipient\n" +
            "WHERE l.subject_of_letter = ?;\n" +
            "\n";
    static String SELECT_PERSON_NOT_GET_LETTER_WITH_SUBJECT = "SELECT u.*\n" +
            "FROM mail.person u\n" +
            "WHERE NOT EXISTS (\n" +
            "    SELECT 1\n" +
            "    FROM mail.letter l\n" +
            "    WHERE l.recipient = u.Full_name AND l.subject_of_letter = ?\n" +
            ");\n";
    static String SELECT_LETTER_WITH_SENDER_AND_SUBJECT = "SELECT l.*\n" +
            "FROM mail.letter l\n" +
            "JOIN mail.person p ON l.sender = p.full_name\n" +
            "WHERE p.Full_name = ? AND l.subject_of_letter = ?\n" +
            "LIMIT 1;";
   static String SEND_LETTER_TO_ALL = "\n" +
           "INSERT INTO mail.letter (sender, recipient, subject_of_letter, text, date)\n" +
           "SELECT ?, u.Full_name, ?, ?, ?\n" +
           "FROM mail.person u;\n";
}
