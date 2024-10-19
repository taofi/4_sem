package Objects;

import java.util.Date;

public class Letter {
    private int id;
    private String sender;
    private String recipient;
    private String subject_of_letter;
    private String text;
    private Date date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getRecipient() {
        return recipient;
    }

    public void setRecipient(String recipient) {
        this.recipient = recipient;
    }

    public String getSubject_of_letter() {
        return subject_of_letter;
    }

    public void setSubject_of_letter(String subject_of_letter) {
        this.subject_of_letter = subject_of_letter;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Letter(int id, String sender, String recipient, String subject_of_letter, String text, Date date) {
        this.id = id;
        this.sender = sender;
        this.recipient = recipient;
        this.subject_of_letter = subject_of_letter;
        this.text = text;
        this.date = date;
    }

    @Override
    public String toString() {
        return "Letter{" +
                "id=" + id +
                ", sender='" + sender + '\'' +
                ", recipient='" + recipient + '\'' +
                ", subject_of_letter='" + subject_of_letter + '\'' +
                ", text='" + text + '\'' +
                ", date=" + date +
                '}';
    }
}
