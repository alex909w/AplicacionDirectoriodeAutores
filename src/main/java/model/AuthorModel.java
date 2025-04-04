package model;

import model.entity.Author;
import model.entity.LiteraryGenre;
import model.util.JPAUtil;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

/**
 * Model class for author operations
 */
public class AuthorModel {
    
    /**
     * Get all authors
     * @return List of authors
     */
    public List<Author> getAllAuthors() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Author> query = em.createQuery("SELECT a FROM Author a ORDER BY a.name", Author.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get authors by genre
     * @param genreId Genre ID
     * @return List of authors in the specified genre
     */
    public List<Author> getAuthorsByGenre(Long genreId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Author> query = em.createQuery(
                "SELECT a FROM Author a WHERE a.genre.id = :genreId ORDER BY a.name", Author.class);
            query.setParameter("genreId", genreId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get authors by name filter
     * @param nameFilter Name filter
     * @return List of authors matching the filter
     */
    public List<Author> getAuthorsByNameFilter(String nameFilter) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Author> query = em.createQuery(
                "SELECT a FROM Author a WHERE LOWER(a.name) LIKE :nameFilter ORDER BY a.name", Author.class);
            query.setParameter("nameFilter", "%" + nameFilter.toLowerCase() + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get an author by ID
     * @param id Author ID
     * @return Author object
     */
    public Author getAuthorById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Author.class, id);
        } finally {
            em.close();
        }
    }
    
    /**
     * Check if an author with the same name exists
     * @param name Author name
     * @return true if exists, false otherwise
     */
    public boolean authorNameExists(String name) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(a) FROM Author a WHERE LOWER(a.name) = :name", Long.class);
            query.setParameter("name", name.toLowerCase());
            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }
    
    /**
     * Save an author
     * @param author Author to save
     * @return Saved Author
     */
    public Author saveAuthor(Author author) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (author.getId() == null) {
                em.persist(author);
            } else {
                author = em.merge(author);
            }
            em.getTransaction().commit();
            return author;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    /**
     * Delete an author
     * @param id Author ID to delete
     */
    public void deleteAuthor(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Author author = em.find(Author.class, id);
            if (author != null) {
                em.remove(author);
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

