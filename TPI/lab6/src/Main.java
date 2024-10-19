import DAO.MailDaoImpl;
import Objects.Person;
import Connection.ConnectionFactory;

import java.sql.*;
import java.util.*;


public class Main {
    public static void main(String[] args) {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
            try (Connection conn = ConnectionFactory.getConnection()){
                System.out.println("Connection to Store DB succesfull!");
                MailDaoImpl mailimpl = new MailDaoImpl(conn);
                Person pers = mailimpl.getPersonWithMinLetterSize();
                System.out.println(pers.toString() + '\n');
                List<Person> ListPers =  mailimpl.getAllUserInfo();
                System.out.println("\nget c#");
                for (Person person :  mailimpl.getAllPersonGetSubjectLetter("c#"))
                    System.out.println(person);
                System.out.println("\nnot get c++");
                List<Person> ListCpp =  mailimpl.getAllPersonNotGetSubjectLetter("c++");
                if(ListCpp!= null)
                {
                    for (Person person : ListCpp)
                        System.out.println(person);
                }
                else System.out.println("empty");
                //mailimpl.sendLetterToAllWithSubject(pers, "c++");
            }
        }
        catch(Exception ex){
            System.out.println("Connection failed...");
            System.out.println(ex);
        }
    }
}