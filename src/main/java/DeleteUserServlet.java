import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("user_id");

        UserDAO dao = new UserDAO();
        boolean result = dao.deleteUser(userId);

        if (result) {
            response.getWriter().write("{\"message\": \"회원이 삭제되었습니다.\"}");
        } else {
            response.getWriter().write("{\"error\": \"삭제 실패\"}");
        }
    }
}
