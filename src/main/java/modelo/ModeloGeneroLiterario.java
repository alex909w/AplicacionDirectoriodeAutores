package modelo;

import modelo.entidad.GeneroLiterario;
import modelo.util.BD;

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
 * Clase modelo para operaciones de géneros literarios
 */
public class ModeloGeneroLiterario {
    
    private static final Logger logger = Logger.getLogger(ModeloGeneroLiterario.class.getName());
    
    /**
     * Obtener todos los géneros literarios
     * @return Lista de géneros literarios
     */
    public List<GeneroLiterario> obtenerTodosLosGeneros() {
        List<GeneroLiterario> generos = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conexion = BD.obtenerConexion();
            String sql = "SELECT id, nombre FROM genero_literario ORDER BY nombre";
            ps = conexion.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                GeneroLiterario genero = new GeneroLiterario();
                genero.setId(rs.getLong("id"));
                genero.setNombre(rs.getString("nombre"));
                
                generos.add(genero);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al obtener todos los géneros: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, rs);
        }
        
        return generos;
    }
    
    /**
     * Obtener un género literario por ID
     * @param id ID del género
     * @return Objeto GeneroLiterario
     */
    public GeneroLiterario obtenerGeneroPorId(Long id) {
        GeneroLiterario genero = null;
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conexion = BD.obtenerConexion();
            String sql = "SELECT id, nombre FROM genero_literario WHERE id = ?";
            ps = conexion.prepareStatement(sql);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                genero = new GeneroLiterario();
                genero.setId(rs.getLong("id"));
                genero.setNombre(rs.getString("nombre"));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al obtener género por ID: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, rs);
        }
        
        return genero;
    }
    
    /**
     * Guardar un género literario
     * @param genero GeneroLiterario a guardar
     * @return GeneroLiterario guardado
     */
    public GeneroLiterario guardarGenero(GeneroLiterario genero) {
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conexion = BD.obtenerConexion();
            
            if (genero.getId() == null) {
                // Insertar nuevo género
                String sql = "INSERT INTO genero_literario (nombre) VALUES (?)";
                ps = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, genero.getNombre());
                
                ps.executeUpdate();
                
                // Obtener el ID generado
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    genero.setId(rs.getLong(1));
                }
            } else {
                // Actualizar género existente
                String sql = "UPDATE genero_literario SET nombre = ? WHERE id = ?";
                ps = conexion.prepareStatement(sql);
                ps.setString(1, genero.getNombre());
                ps.setLong(2, genero.getId());
                
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al guardar género: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, rs);
        }
        
        return genero;
    }
    
    /**
     * Eliminar un género literario
     * @param id ID del género a eliminar
     */
    public void eliminarGenero(Long id) {
        Connection conexion = null;
        PreparedStatement ps = null;
        
        try {
            conexion = BD.obtenerConexion();
            String sql = "DELETE FROM genero_literario WHERE id = ?";
            ps = conexion.prepareStatement(sql);
            ps.setLong(1, id);
            
            ps.executeUpdate();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al eliminar género: {0}", e.getMessage());
        } finally {
            BD.cerrarRecursos(conexion, ps, null);
        }
    }
}

