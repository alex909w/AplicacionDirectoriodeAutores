package modelo.util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * Clase de utilidad para operaciones JPA
 */
public class JPAUtil {
    private static final String PERSISTENCE_UNIT_NAME = "AutoresPU";
    private static EntityManagerFactory factory;
    
    /**
     * Obtener la fábrica de entity manager
     * @return Instancia de EntityManagerFactory
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        if (factory == null) {
            factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        }
        return factory;
    }
    
    /**
     * Obtener un nuevo entity manager
     * @return Instancia de EntityManager
     */
    public static EntityManager getEntityManager() {
        return getEntityManagerFactory().createEntityManager();
    }
    
    /**
     * Cerrar la fábrica de entity manager
     */
    public static void shutdown() {
        if (factory != null) {
            factory.close();
        }
    }
}

