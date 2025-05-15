package net.jhonyretro.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue
    @Column(name = "user_id")
    private int id;

    @Column(name = "user_name")
    private String user_name;

    @Column(name = "user_image")
    private String user_image;

    @Column(name = "email")
    private String email;

    @Column(name = "passwd")
    private String passwd;

    @Column(name = "creation_date")
    private LocalDate date;

    public User() {

    }

    public User(int id, String user_name, String user_image, String email, String passwd, LocalDate date) {
        this.id = id;
        this.user_name = user_name;
        this.user_image = user_image;
        this.email = email;
        this.passwd = passwd;
        this.date = date;
    }

    public int getId() {
        return this.id;
    }

    public String getUsername() {
        return this.user_name;
    }

    public void setUsername(String userName) {
        this.user_name = userName;
    }

    public String getUserImage() {
        return this.user_image;
    }

    public void setUserImage(String userImage) {
        this.user_image = userImage;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return this.passwd;
    }

    public void setPassword(String password) {
        this.passwd = password;
    }

    public LocalDate getCreationDate() {
        return this.date;
    }
}
