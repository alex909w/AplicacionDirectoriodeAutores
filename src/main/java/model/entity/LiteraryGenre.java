package model.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Entity class for literary genres
 */
@Entity
@Table(name = "literary_genre")
public class LiteraryGenre implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "name", nullable = false, unique = true)
    private String name;
    
    @OneToMany(mappedBy = "genre", cascade = CascadeType.ALL)
    private List<Author> authors;
    
    // Constructors
    public LiteraryGenre() {
    }
    
    public LiteraryGenre(String name) {
        this.name = name;
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
    
    public List<Author> getAuthors() {
        return authors;
    }
    
    public void setAuthors(List<Author> authors) {
        this.authors = authors;
    }
    
    @Override
    public String toString() {
        return name;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        LiteraryGenre that = (LiteraryGenre) obj;
        
        return id != null ? id.equals(that.id) : that.id == null;
    }
    
    @Override
    public int hashCode() {
        return id != null ? id.hashCode() : 0;
    }
}

