import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("user_id");
        String newNickname = request.getParameter("nickname");
        String newEmail = request.getParameter("email");

        UserDAO dao = new UserDAO();
        UserDTO user = new UserDTO();
        user.setUser_id(userId);
        user.setNickname(newNickname);
        user.setEmail(newEmail);

        boolean result = dao.updateUserInfo(user);
        if (result) {
            response.getWriter().write("{\"message\": \"회원 정보가 수정되었습니다.\"}");
        } else {
            response.getWriter().write("{\"error\": \"수정 실패\"}");
        }
    }
}
