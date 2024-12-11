public class ChatMessageDTO {
    private String nickname;
    private String CommentText;
    private String createdAt;

    // Getter와 Setter 메서드
    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getCommentText() {
        return CommentText;
    }

    public void setCommentText(String CommentText) {
        this.CommentText = CommentText;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}
