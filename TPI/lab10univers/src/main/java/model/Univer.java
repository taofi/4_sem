package model;

import java.util.Date;

public class Univer {
    private int id;
    private String name;
    private String city;
    private Date year;

    public Univer(int id, String name, String city, Date year) {
        this.id = id;
        this.name = name;
        this.city = city;
        this.year = year;
    }
    public int getId() {
        return id;        
    }                       
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Date getYear() {
        return year;
    }

    public void setYear(Date year) {
        this.year = year;
    }
}
