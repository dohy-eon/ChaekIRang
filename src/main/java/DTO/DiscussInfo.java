package DTO;

public class DiscussInfo {
    private String disc_id;
    private String title;
    private String book_name;
    private String book_image;
    private String description;
    private String genre;
    private String time_created;
    private int comment;
    
    public DiscussInfo(String disc_id, String title, String book_name, String book_image, 
            String description, String genre, String time_created, int comment) {
		this.disc_id = disc_id;
		this.title = title;
		this.book_name = book_name;
		this.book_image = book_image;
		this.description = description;
		this.genre = genre;
		this.time_created = time_created;
		this.comment = comment;
	}
    // Getters and setters
    public String getDisc_id() {
        return disc_id;
    }

    public void setDisc_id(String disc_id) {
        this.disc_id = disc_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public String getBook_image() {
        return book_image;
    }

    public void setBook_image(String book_image) {
        this.book_image = book_image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getTime_created() {
        return time_created;
    }

    public void setTime_created(String time_created) {
        this.time_created = time_created;
    }
    public int getComment() {
    	return comment;
    }
    public void setComment(int comment) {
    	this.comment = comment;
    }
}
