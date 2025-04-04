package modelo.entidad;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Clase entidad para géneros literarios
 */
@Entity
@Table(name = "genero_literario")
public class GeneroLiterario implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "nombre", nullable = false, unique = true)
    private String nombre;
    
    @OneToMany(mappedBy = "genero", cascade = CascadeType.ALL)
    private List<Autor> autores;
    
    // Constructores
    public GeneroLiterario() {
    }
    
    public GeneroLiterario(String nombre) {
        this.nombre = nombre;
    }
    
    // Getters y Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public List<Autor> getAutores() {
        return autores;
    }
    
    public void setAutores(List<Autor> autores) {
        this.autores = autores;
    }
    
    @Override
    public String toString() {
        return nombre;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        GeneroLiterario that = (GeneroLiterario) obj;
        
        return id != null ? id.equals(that.id) : that.id == null;
    }
    
    @Override
    public int hashCode() {
        return id != null ? id.hashCode() : 0;
    }
}

