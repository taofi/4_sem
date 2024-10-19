package Objects;

import java.util.Date;

public class Person {
    private Date date_of_birth;
    private String fullName;
    public Date getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(Date date_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Person( String full_name, Date date_of_birth) {
        this.date_of_birth = date_of_birth;
        fullName = full_name;
    }

    @Override
    public String toString() {
        return "Person{" +
                "date_of_birth=" + date_of_birth +
                ", fullName='" + fullName + '\'' +
                '}';
    }
}
