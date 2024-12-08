import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;
import com.google.gson.Gson;


@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idSession = (String) request.getSession().getAttribute("idSession");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (idSession != null) {
            NotificationDAO notificationDAO = new NotificationDAO();
            List<NotificationDTO> notifications = notificationDAO.getNotificationsByUserId(idSession);

            Gson gson = new Gson();
            String jsonResponse = gson.toJson(notifications);

            response.getWriter().print(jsonResponse);
        } else {
            // 세션이 없을 경우 빈 JSON 배열 반환
            response.getWriter().print("[]");
        }
    }
}