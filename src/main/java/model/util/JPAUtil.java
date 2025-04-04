package model.util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * Utility class for JPA operations
 */
public class JPAUtil {
    private static final String PERSISTENCE_UNIT_NAME = "AuthorsPU";
    private static EntityManagerFactory factory;
    
    /**
     * Get the entity manager factory
     * @return EntityManagerFactory instance
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        if (factory == null) {
            factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        }
        return factory;
    }
    
    /**
     * Get a new entity manager
     * @return EntityManager instance
     */
    public static EntityManager getEntityManager() {
        return getEntityManagerFactory().createEntityManager();
    }
    
    /**
     * Close the entity manager factory
     */
    public static void shutdown() {
        if (factory != null) {
            factory.close();
        }
    }
}

