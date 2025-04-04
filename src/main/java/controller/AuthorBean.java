package controller;

import model.AuthorModel;
import model.LiteraryGenreModel;
import model.entity.Author;
import model.entity.LiteraryGenre;

import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import java.io.Serializable;
import java.util.Date;
import java.util.List;


@ManagedBean
@ViewScoped
public class AuthorBean implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private AuthorModel authorModel;
    private LiteraryGenreModel genreModel;
    
    private List<Author> authors;
    private List<LiteraryGenre> genres;
    private Author author;
    private Long selectedGenreId;
    private String nameFilter;
    private int authorCount;
    
    @PostConstruct
    public void init() {
        authorModel = new AuthorModel();
        genreModel = new LiteraryGenreModel();
        author = new Author();
        loadAuthors();
        loadGenres();
    }
    

    public void loadAuthors() {
        authors = authorModel.getAllAuthors();
        authorCount = authors.size();
    }
    
    /**
     * Load authors by genre
     */
    public void loadAuthorsByGenre() {
        if (selectedGenreId != null && selectedGenreId > 0) {
            authors = authorModel.getAuthorsByGenre(selectedGenreId);
        } else {
            loadAuthors();
        }
        authorCount = authors.size();
    }
    
    /**
     * Filter authors by name
     */
    public void filterAuthorsByName() {
        if (nameFilter != null && !nameFilter.trim().isEmpty()) {
            authors = authorModel.getAuthorsByNameFilter(nameFilter);
        } else {
            loadAuthors();
        }
        authorCount = authors.size();
    }
    
    /**
     * Count visible authors
     */
    public void countAuthors() {
        authorCount = authors.size();
    }
    
    /**
     * Load all literary genres
     */
    public void loadGenres() {
        genres = genreModel.getAllGenres();
    }
    
    /**
     * Save an author
     */
    public void saveAuthor() {
        try {
            if (selectedGenreId != null) {
                LiteraryGenre genre = genreModel.getGenreById(selectedGenreId);
                author.setGenre(genre);
            }
            
            boolean isNew = (author.getId() == null);
            boolean nameExists = authorModel.authorNameExists(author.getName());
            
            authorModel.saveAuthor(author);
            
            if (isNew && nameExists) {
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_WARN, 
                    "Advertencia", "El autor ya existe en la base de datos, pero se ha agregado de todos modos."));
            } else {
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_INFO, 
                    "Éxito", isNew ? "Autor agregado correctamente." : "Autor actualizado correctamente."));
            }
            
            author = new Author();
            selectedGenreId = null;
            loadAuthors();
            
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, 
                new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                "Error", "Ocurrió un error al guardar el autor: " + e.getMessage()));
        }
    }
    
    /**
     * Edit an author
     * @param author Author to edit
     */
    public void editAuthor(Author author) {
        this.author = author;
        this.selectedGenreId = author.getGenre().getId();
    }
    
    /**
     * Delete an author
     * @param id Author ID to delete
     */
    public void deleteAuthor(Long id) {
        try {
            authorModel.deleteAuthor(id);
            loadAuthors();
            FacesContext.getCurrentInstance().addMessage(null, 
                new FacesMessage(FacesMessage.SEVERITY_INFO, 
                "Éxito", "Autor eliminado correctamente."));
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, 
                new FacesMessage(FacesMessage.SEVERITY_ERROR, 
                "Error", "Ocurrió un error al eliminar el autor: " + e.getMessage()));
        }
    }
    
    /**
     * Reset the form
     */
    public void reset() {
        author = new Author();
        selectedGenreId = null;
    }
    
    // Getters and Setters
    
    public Author getAuthor() {
        return author;
    }
    
    public void setAuthor(Author author) {
        this.author = author;
    }
    
    public List<Author> getAuthors() {
        return authors;
    }
    
    public List<LiteraryGenre> getGenres() {
        return genres;
    }
    
    public Long getSelectedGenreId() {
        return selectedGenreId;
    }
    
    public void setSelectedGenreId(Long selectedGenreId) {
        this.selectedGenreId = selectedGenreId;
    }
    
    public String getNameFilter() {
        return nameFilter;
    }
    
    public void setNameFilter(String nameFilter) {
        this.nameFilter = nameFilter;
    }
    
    public int getAuthorCount() {
        return authorCount;
    }
}

