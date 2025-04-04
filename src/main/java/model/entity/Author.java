package model.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Entity class for authors
 */
@Entity
@Table(name = "author")
public class Author implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "name", nullable = false)
    private String name;
    
    @Column(name = "phone")
    private String phone;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "birth_date")
    private Date birthDate;
    
    @ManyToOne
    @JoinColumn(name = "genre_id", nullable = false)
    private LiteraryGenre genre;
    
    // Constructors
    public Author() {
    }
    
    public Author(String name, String phone, Date birthDate, LiteraryGenre genre) {
        this.name = name;
        this.phone = phone;
        this.birthDate = birthDate;
        this.genre = genre;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public Date getBirthDate() {
        return birthDate;
    }
    
    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }
    
    public LiteraryGenre getGenre() {
        return genre;
    }
    
    public void setGenre(LiteraryGenre genre) {
        this.genre = genre;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        Author author = (Author) obj;
        
        return id != null ? id.equals(author.id) : author.id == null;
    }
    
    @Override
    public int hashCode() {
        return id != null ? id.hashCode() : 0;
    }
}

