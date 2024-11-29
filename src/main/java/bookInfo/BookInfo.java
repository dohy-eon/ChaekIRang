package bookInfo;

public class BookInfo {
    private String title;
    private String authors;
    private String img;     // 책 이미지 URL
    private boolean isEbook; // eBook 여부
    private int price;      // 가격
    
    public BookInfo(String title, String authors, String img, boolean isEbook, int price) {
        this.title = title;
        this.authors = authors;
        this.img = img;
        this.isEbook = isEbook;
        this.price = price;
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
}
