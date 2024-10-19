package test;

import DAO.MailDaoImpl;
import Objects.Person;
import Connection.ConnectionFactory;
import org.testng.annotations.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import static org.testng.Assert.*;


public class UnitTest {
    public static Connection conn;
    public static MailDaoImpl mailimpl;

    public static List<Person> allPerson;
    @BeforeSuite
    public static void showTestIsStart() {
        System.out.println("Test is started!");
    }

    @AfterSuite
    public static void showTestIsEnd() {
        System.out.println("Test is ended!");
    }

    @BeforeTest
    public static void connect() throws SQLException, IOException {
        conn = ConnectionFactory.getConnection();
        System.out.println("Connected");
    }
    @AfterTest
    public static void closeUp() throws SQLException {
        conn.close();
        System.out.println("Connection closed");
    }
    @BeforeClass
    public static void setMailimpl(){
        mailimpl =  new MailDaoImpl(conn);
    }
    @BeforeMethod
    public static void setUsers() throws SQLException {
        PreparedStatement statement = conn.prepareStatement("SELECT * FROM mail.person;");
        ResultSet resultSet = statement.executeQuery();
        //System.out.println(resultSet);
        allPerson =  mailimpl.convertResultSetToPersonArrayList(resultSet);
    }
    @AfterMethod
    public static void clearUsers(){
        allPerson.clear();
    }
    @Test
    public static void  testGetPersonWithMinLetterSize() throws SQLException {
        Person result = mailimpl.getPersonWithMinLetterSize();
        assertNotNull(result);
        assertEquals("Gladys Davis", result.getFullName(), "Full names should match");
        System.out.println(result);
    }

    @Test
    public static void testGetAllUserInfo () throws SQLException {
        List<Person> ListPers =  mailimpl.getAllUserInfo();
        assertNotNull(ListPers);
        for (int i = 0; i < allPerson.size(); i++) {
            assertEquals(allPerson.get(i).getFullName(), ListPers.get(i).getFullName(), "Full names should match");
        }
    }

    @Test(enabled = false)
    public static void testGetAllPersonNotGetSubjectLetter () throws SQLException {
        List<Person> ListPerson = mailimpl.getAllPersonNotGetSubjectLetter("c#");
        assertNull(ListPerson, "Result should be empty");
    }
    @Parameters({"findSubject", "isEmpty"})
    @Test(timeOut = 300)
    public static void testGetAllPersonGetSubjectLetter (String str, Boolean isEmpty) throws SQLException {
        List<Person> ListPerson = mailimpl.getAllPersonGetSubjectLetter(str);
        if(isEmpty)
            assertNull(ListPerson, "Result should be empty");
        else
            assertNotNull(ListPerson, "Result shouldn't be empty");
    }
}
