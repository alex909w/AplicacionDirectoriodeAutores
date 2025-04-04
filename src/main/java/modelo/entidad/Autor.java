package modelo.entidad;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Clase entidad para autores
 */
@Entity
@Table(name = "autor")
public class Autor implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "nombre", nullable = false)
    private String nombre;
    
    @Column(name = "telefono")
    private String telefono;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "fecha_nacimiento")
    private Date fechaNacimiento;
    
    @ManyToOne
    @JoinColumn(name = "genero_id", nullable = false)
    private GeneroLiterario genero;
    
    // Constructores
    public Autor() {
    }
    
    public Autor(String nombre, String telefono, Date fechaNacimiento, GeneroLiterario genero) {
        this.nombre = nombre;
        this.telefono = telefono;
        this.fechaNacimiento = fechaNacimiento;
        this.genero = genero;
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
    
    public String getTelefono() {
        return telefono;
    }
    
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }
    
    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
    
    public GeneroLiterario getGenero() {
        return genero;
    }
    
    public void setGenero(GeneroLiterario genero) {
        this.genero = genero;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        Autor autor = (Autor) obj;
        
        return id != null ? id.equals(autor.id) : autor.id == null;
    }
    
    @Override
    public int hashCode() {
        return id != null ? id.hashCode() : 0;
    }
}

