import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("user_id");
        String nickname = request.getParameter("nickname");
        String email = request.getParameter("email");

        UserDAO userDAO = new UserDAO();
        UserDTO user = new UserDTO();
        user.setUser_id(userId);
        user.setNickname(nickname);
        user.setEmail(email);

        boolean result = userDAO.updateUserInfo(user);
        if (result) {
            response.sendRedirect("MemberListServlet"); // 수정 후 회원 목록으로 이동
        } else {
            response.getWriter().println("회원 정보 수정 실패");
        }
    }
}
