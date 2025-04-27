package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Clase utilitaria para manejar la conexión a la base de datos
 */
public class BD {
    
    // Configuración de la base de datos
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/Authors?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USUARIO = "root";
    private static final String PASSWORD = "";
    
    private static final Logger logger = Logger.getLogger(BD.class.getName());
    
    /**
     * Obtiene una conexión a la base de datos
     * @return Conexión a la base de datos
     * @throws SQLException Si ocurre un error al conectar
     */
    public static Connection obtenerConexion() throws SQLException {
        Connection conexion = null;
        try {
            // Cargar el driver
            Class.forName(DRIVER);
            
            // Establecer la conexión
            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            
            if (conexion != null) {
                logger.log(Level.INFO, "Conexión exitosa a la base de datos");
            }
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Error al cargar el driver: {0}", e.getMessage());
            throw new SQLException("Error al cargar el driver: " + e.getMessage());
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al conectar a la base de datos: {0}", e.getMessage());
            throw e;
        }
        return conexion;
    }
    
    /**
     * Cierra los recursos de la base de datos
     * @param conexion Conexión a cerrar
     * @param ps PreparedStatement a cerrar
     * @param rs ResultSet a cerrar
     */
    public static void cerrarRecursos(Connection conexion, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Error al cerrar recursos: {0}", e.getMessage());
        }
    }
    
    /**
     * Ejecuta una consulta de prueba para verificar la conexión
     * @return true si la conexión es exitosa, false en caso contrario
     */
    public static boolean probarConexion() {
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conexion = obtenerConexion();
            ps = conexion.prepareStatement("SELECT 1");
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al probar la conexión: {0}", e.getMessage());
            return false;
        } finally {
            cerrarRecursos(conexion, ps, rs);
        }
    }
}

