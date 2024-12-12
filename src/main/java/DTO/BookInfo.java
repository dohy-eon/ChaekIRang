package DTO;

public class BookInfo {
    private String title;
    private String authors;
    private String img;
//    private String genre;
    private boolean isEbook;
    private int price;
    private String description; // 추가된 description
    private String buyLink; // 추가된 buyLink

    public BookInfo(String title, String authors, String img, boolean isEbook, int price, String description, String buyLink) {
        this.title = title;
        this.authors = authors;
        this.img = img;
        this.isEbook = isEbook;
        this.price = price;
        this.description = description;
        this.buyLink = buyLink;
    }

    // Getter 메서드
    public String getTitle() {
        return title;
    }

    public String getAuthors() {
        return authors;
    }

    public String getImg() {
        return img;
    }

    public boolean getIsEbook() {
        return isEbook;
    }

    public int getPrice() {
        return price;
    }

    public String getDescription() {
        return description;
    }

    public String getBuyLink() {
        return buyLink;
    }

    // Setter 메서드
    public void setTitle(String title) {
        this.title = title;
    }

    public void setAuthors(String authors) {
        this.authors = authors;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public void setIsEbook(boolean isEbook) {
        this.isEbook = isEbook;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setBuyLink(String buyLink) {
        this.buyLink = buyLink;
    }
}
