import java.sql.Timestamp;

public class NotificationDTO {
    private int alarmId;
    private String userId;
    private int discId;
    private String message;
    private Timestamp alarmCreated;
    private boolean status;

    // 기본 생성자 추가
    public NotificationDTO() {
    }

    // 생성자
    public NotificationDTO(String userId, int discId, String message, Timestamp alarmCreated) {
        this.userId = userId;
        this.discId = discId;
        this.message = message;
        this.alarmCreated = alarmCreated;
    }

    // getter, setter
    public int getAlarmId() {
        return alarmId;
    }

    public void setAlarmId(int alarmId) {
        this.alarmId = alarmId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getDiscId() {
        return discId;
    }

    public void setDiscId(int discId) {
        this.discId = discId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getAlarmCreated() {
        return alarmCreated;
    }

    public void setAlarmCreated(Timestamp alarmCreated) {
        this.alarmCreated = alarmCreated;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
