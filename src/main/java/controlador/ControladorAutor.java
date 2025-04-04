package controlador;

import modelo.ModeloAutor;
import modelo.ModeloGeneroLiterario;
import modelo.entidad.Autor;
import modelo.entidad.GeneroLiterario;
import modelo.util.BD;

import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * ManagedBean para operaciones de autores
 */
@ManagedBean(name = "controladorAutor")
@ViewScoped
public class ControladorAutor implements Serializable {
    
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(ControladorAutor.class.getName());
    
    private ModeloAutor modeloAutor;
    private ModeloGeneroLiterario modeloGenero;
    
    private List<Autor> autores;
    private List<GeneroLiterario> generos;
    private Autor autor;
    private Long generoSeleccionadoId;
    private String filtroNombre;
    private int contadorAutores;
    private boolean conexionExitosa;
    
    @PostConstruct
    public void init() {
        try {
            // Probar la conexión a la base de datos
            conexionExitosa = BD.probarConexion();
            
            if (conexionExitosa) {
                modeloAutor = new ModeloAutor();
                modeloGenero = new ModeloGeneroLiterario();
                autor = new Autor();
                cargarAutores();
                cargarGeneros();
            } else {
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                    "Error de conexión", "No se pudo conectar a la base de datos. Verifique la configuración."));
                autores = new ArrayList<>();
                generos = new ArrayList<>();
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al inicializar el controlador: {0}", e.getMessage());
            FacesContext.getCurrentInstance().addMessage(null, 
                new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                "Error", "Ocurrió un error al inicializar la aplicación: " + e.getMessage()));
            autores = new ArrayList<>();
            generos = new ArrayList<>();
        }
    }
    
    /**
     * Cargar todos los autores
     */
    public void cargarAutores() {
        if (conexionExitosa) {
            try {
                autores = modeloAutor.obtenerTodosLosAutores();
                contadorAutores = autores.size();
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error al cargar autores: {0}", e.getMessage());
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                    "Error", "Ocurrió un error al cargar los autores: " + e.getMessage()));
                autores = new ArrayList<>();
            }
        }
    }
    
    /**
     * Cargar autores por género
     */
    public void cargarAutoresPorGenero() {
        if (conexionExitosa) {
            try {
                if (generoSeleccionadoId != null && generoSeleccionadoId > 0) {
                    autores = modeloAutor.obtenerAutoresPorGenero(generoSeleccionadoId);
                } else {
                    cargarAutores();
                }
                contadorAutores = autores.size();
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error al cargar autores por género: {0}", e.getMessage());
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                    "Error", "Ocurrió un error al filtrar por género: " + e.getMessage()));
            }
        }
    }
    
    /**
     * Filtrar autores por nombre
     */
    public void filtrarAutoresPorNombre() {
        if (conexionExitosa) {
            try {
                if (filtroNombre != null && !filtroNombre.trim().isEmpty()) {
                    autores = modeloAutor.obtenerAutoresPorFiltroNombre(filtroNombre);
                } else {
                    cargarAutores();
                }
                contadorAutores = autores.size();
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error al filtrar autores por nombre: {0}", e.getMessage());
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                    "Error", "Ocurrió un error al filtrar por nombre: " + e.getMessage()));
            }
        }
    }
    
    /**
     * Contar autores visibles
     */
    public void contarAutores() {
        contadorAutores = autores.size();
    }
    
    /**
     * Cargar todos los géneros literarios
     */
    public void cargarGeneros() {
        if (conexionExitosa) {
            try {
                generos = modeloGenero.obtenerTodosLosGeneros();
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error al cargar géneros: {0}", e.getMessage());
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                    "Error", "Ocurrió un error al cargar los géneros literarios: " + e.getMessage()));
                generos = new ArrayList<>();
            }
        }
    }
    
    /**
     * Guardar un autor
     */
    public void guardarAutor() {
        if (conexionExitosa) {
            try {
                if (generoSeleccionadoId != null) {
                    GeneroLiterario genero = modeloGenero.obtenerGeneroPorId(generoSeleccionadoId);
                    autor.setGenero(genero);
                }
                
                boolean esNuevo = (autor.getId() == null);
                boolean nombreExiste = modeloAutor.existeNombreAutor(autor.getNombre());
                
                modeloAutor.guardarAutor(autor);
                
                if (esNuevo && nombreExiste) {
                    FacesContext.getCurrentInstance().addMessage(null, 
                        new FacesMessage(FacesMessage.SEVERITY_WARN, 
                        "Advertencia", "El autor ya existe en la base de datos, pero se ha agregado de todos modos."));
                } else {
                    FacesContext.getCurrentInstance().addMessage(null, 
                        new FacesMessage(FacesMessage.SEVERITY_INFO, 
                        "Éxito", esNuevo ? "Autor agregado correctamente." : "Autor actualizado correctamente."));
                }
                
                autor = new Autor();
                generoSeleccionadoId = null;
                cargarAutores();
                
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error al guardar autor: {0}", e.getMessage());
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                    "Error", "Ocurrió un error al guardar el autor: " + e.getMessage()));
            }
        }
    }
    
    /**
     * Editar un autor
     * @param autor Autor a editar
     */
    public void editarAutor(Autor autor) {
        if (conexionExitosa) {
            try {
                this.autor = autor;
                this.generoSeleccionadoId = autor.getGenero().getId();
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error al editar autor: {0}", e.getMessage());
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                    "Error", "Ocurrió un error al editar el autor: " + e.getMessage()));
            }
        }
    }
    
    /**
     * Eliminar un autor
     * @param id ID del autor a eliminar
     */
    public void eliminarAutor(Long id) {
        if (conexionExitosa) {
            try {
                modeloAutor.eliminarAutor(id);
                cargarAutores();
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_INFO, 
                    "Éxito", "Autor eliminado correctamente."));
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error al eliminar autor: {0}", e.getMessage());
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                    "Error", "Ocurrió un error al eliminar el autor: " + e.getMessage()));
            }
        }
    }
    
    /**
     * Reiniciar el formulario
     */
    public void reiniciar() {
        autor = new Autor();
        generoSeleccionadoId = null;
    }
    
    /**
     * Probar la conexión a la base de datos
     */
    public void probarConexion() {
        conexionExitosa = BD.probarConexion();
        
        if (conexionExitosa) {
            FacesContext.getCurrentInstance().addMessage(null, 
                new FacesMessage(FacesMessage.SEVERITY_INFO, 
                "Éxito", "Conexión a la base de datos establecida correctamente."));
        } else {
            FacesContext.getCurrentInstance().addMessage(null, 
                new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                "Error", "No se pudo conectar a la base de datos. Verifique la configuración."));
        }
    }
    
    // Getters y Setters
    
    public Autor getAutor() {
        return autor;
    }
    
    public void setAutor(Autor autor) {
        this.autor = autor;
    }
    
    public List<Autor> getAutores() {
        return autores;
    }
    
    public List<GeneroLiterario> getGeneros() {
        return generos;
    }
    
    public Long getGeneroSeleccionadoId() {
        return generoSeleccionadoId;
    }
    
    public void setGeneroSeleccionadoId(Long generoSeleccionadoId) {
        this.generoSeleccionadoId = generoSeleccionadoId;
    }
    
    public String getFiltroNombre() {
        return filtroNombre;
    }
    
    public void setFiltroNombre(String filtroNombre) {
        this.filtroNombre = filtroNombre;
    }
    
    public int getContadorAutores() {
        return contadorAutores;
    }
    
    public boolean isConexionExitosa() {
        return conexionExitosa;
    }
}

