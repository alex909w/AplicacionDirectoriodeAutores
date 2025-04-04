package model;

import model.entity.LiteraryGenre;
import model.util.JPAUtil;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

/**
 * Model class for literary genre operations
 */
public class LiteraryGenreModel {
    
    /**
     * Get all literary genres
     * @return List of literary genres
     */
    public List<LiteraryGenre> getAllGenres() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<LiteraryGenre> query = em.createQuery("SELECT g FROM LiteraryGenre g ORDER BY g.name", LiteraryGenre.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get a literary genre by ID
     * @param id Genre ID
     * @return LiteraryGenre object
     */
    public LiteraryGenre getGenreById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(LiteraryGenre.class, id);
        } finally {
            em.close();
        }
    }
    
    /**
     * Save a literary genre
     * @param genre LiteraryGenre to save
     * @return Saved LiteraryGenre
     */
    public LiteraryGenre saveGenre(LiteraryGenre genre) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (genre.getId() == null) {
                em.persist(genre);
            } else {
                genre = em.merge(genre);
            }
            em.getTransaction().commit();
            return genre;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    /**
     * Delete a literary genre
     * @param id Genre ID to delete
     */
    public void deleteGenre(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            LiteraryGenre genre = em.find(LiteraryGenre.class, id);
            if (genre != null) {
                em.remove(genre);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}

