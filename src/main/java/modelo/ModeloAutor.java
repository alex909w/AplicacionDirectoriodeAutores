package modelo;

import modelo.entidad.Autor;
import modelo.entidad.GeneroLiterario;
import util.BD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Clase modelo para operaciones de autores
 */
public class ModeloAutor {
    
    private static final Logger logger = Logger.getLogger(ModeloAutor.class.getName());
    private ModeloGeneroLiterario modeloGenero;
    
    public ModeloAutor() {
        modeloGenero = new ModeloGeneroLiterario();
    }
    
    /**
     * Obtener todos los autores
     * @return Lista de autores
     */
    public List<Autor> obtenerTodosLosAutores() {
        List<Autor> autores = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conexion = BD.obtenerConexion();
            String sql = "SELECT a.id, a.nombre, a.telefono, a.fecha_nacimiento, a.genero_id " +
                         "FROM autor a ORDER BY a.nombre";
            ps = conexion.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Autor autor = new Autor();
                autor.setId(rs.getLong("id"));
                autor.setNombre(rs.getString("nombre"));
                autor.setTelefono(rs.getString("telefono"));
                autor.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                
                // Obtener el género literario
                Long generoId = rs.getLong("genero_id");
                GeneroLiterario genero = modeloGenero.obtenerGeneroPorId(generoId);
                autor.setGenero(genero);
                
                autores.add(autor);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al obtener todos los autores: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, rs);
        }
        
        return autores;
    }
    
    /**
     * Obtener autores por género
     * @param generoId ID del género
     * @return Lista de autores en el género especificado
     */
    public List<Autor> obtenerAutoresPorGenero(Long generoId) {
        List<Autor> autores = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conexion = BD.obtenerConexion();
            String sql = "SELECT a.id, a.nombre, a.telefono, a.fecha_nacimiento, a.genero_id " +
                         "FROM autor a WHERE a.genero_id = ? ORDER BY a.nombre";
            ps = conexion.prepareStatement(sql);
            ps.setLong(1, generoId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Autor autor = new Autor();
                autor.setId(rs.getLong("id"));
                autor.setNombre(rs.getString("nombre"));
                autor.setTelefono(rs.getString("telefono"));
                autor.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                
                // Obtener el género literario
                GeneroLiterario genero = modeloGenero.obtenerGeneroPorId(generoId);
                autor.setGenero(genero);
                
                autores.add(autor);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al obtener autores por género: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, rs);
        }
        
        return autores;
    }
    
    /**
     * Obtener autores por filtro de nombre
     * @param filtroNombre Filtro de nombre
     * @return Lista de autores que coinciden con el filtro
     */
    public List<Autor> obtenerAutoresPorFiltroNombre(String filtroNombre) {
        List<Autor> autores = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conexion = BD.obtenerConexion();
            String sql = "SELECT a.id, a.nombre, a.telefono, a.fecha_nacimiento, a.genero_id " +
                         "FROM autor a WHERE LOWER(a.nombre) LIKE ? ORDER BY a.nombre";
            ps = conexion.prepareStatement(sql);
            ps.setString(1, "%" + filtroNombre.toLowerCase() + "%");
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Autor autor = new Autor();
                autor.setId(rs.getLong("id"));
                autor.setNombre(rs.getString("nombre"));
                autor.setTelefono(rs.getString("telefono"));
                autor.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                
                // Obtener el género literario
                Long generoId = rs.getLong("genero_id");
                GeneroLiterario genero = modeloGenero.obtenerGeneroPorId(generoId);
                autor.setGenero(genero);
                
                autores.add(autor);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al obtener autores por filtro de nombre: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, rs);
        }
        
        return autores;
    }
    
    /**
     * Obtener un autor por ID
     * @param id ID del autor
     * @return Objeto Autor
     */
    public Autor obtenerAutorPorId(Long id) {
        Autor autor = null;
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conexion = BD.obtenerConexion();
            String sql = "SELECT a.id, a.nombre, a.telefono, a.fecha_nacimiento, a.genero_id " +
                         "FROM autor a WHERE a.id = ?";
            ps = conexion.prepareStatement(sql);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                autor = new Autor();
                autor.setId(rs.getLong("id"));
                autor.setNombre(rs.getString("nombre"));
                autor.setTelefono(rs.getString("telefono"));
                autor.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                
                // Obtener el género literario
                Long generoId = rs.getLong("genero_id");
                GeneroLiterario genero = modeloGenero.obtenerGeneroPorId(generoId);
                autor.setGenero(genero);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al obtener autor por ID: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, rs);
        }
        
        return autor;
    }
    
    /**
     * Verificar si existe un autor con el mismo nombre
     * @param nombre Nombre del autor
     * @return true si existe, false en caso contrario
     */
    public boolean existeNombreAutor(String nombre) {
        boolean existe = false;
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conexion = BD.obtenerConexion();
            String sql = "SELECT COUNT(*) FROM autor WHERE LOWER(nombre) = ?";
            ps = conexion.prepareStatement(sql);
            ps.setString(1, nombre.toLowerCase());
            rs = ps.executeQuery();
            
            if (rs.next()) {
                existe = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al verificar si existe el nombre de autor: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, rs);
        }
        
        return existe;
    }
    
    /**
     * Guardar un autor
     * @param autor Autor a guardar
     * @return Autor guardado
     */
    public Autor guardarAutor(Autor autor) {
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conexion = BD.obtenerConexion();
            
            if (autor.getId() == null) {
                // Insertar nuevo autor
                String sql = "INSERT INTO autor (nombre, telefono, fecha_nacimiento, genero_id) VALUES (?, ?, ?, ?)";
                ps = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, autor.getNombre());
                ps.setString(2, autor.getTelefono());
                ps.setDate(3, autor.getFechaNacimiento() != null ? new java.sql.Date(autor.getFechaNacimiento().getTime()) : null);
                ps.setLong(4, autor.getGenero().getId());
                
                ps.executeUpdate();
                
                // Obtener el ID generado
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    autor.setId(rs.getLong(1));
                }
            } else {
                // Actualizar autor existente
                String sql = "UPDATE autor SET nombre = ?, telefono = ?, fecha_nacimiento = ?, genero_id = ? WHERE id = ?";
                ps = conexion.prepareStatement(sql);
                ps.setString(1, autor.getNombre());
                ps.setString(2, autor.getTelefono());
                ps.setDate(3, autor.getFechaNacimiento() != null ? new java.sql.Date(autor.getFechaNacimiento().getTime()) : null);
                ps.setLong(4, autor.getGenero().getId());
                ps.setLong(5, autor.getId());
                
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al guardar autor: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, rs);
        }
        
        return autor;
    }
    
    /**
     * Eliminar un autor
     * @param id ID del autor a eliminar
     */
    public void eliminarAutor(Long id) {
        Connection conexion = null;
        PreparedStatement ps = null;
        
        try {
            conexion = BD.obtenerConexion();
            String sql = "DELETE FROM autor WHERE id = ?";
            ps = conexion.prepareStatement(sql);
            ps.setLong(1, id);
            
            ps.executeUpdate();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al eliminar autor: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, null);
        }
    }
}

