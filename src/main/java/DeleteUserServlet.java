import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("user_id");

        // UserDAO를 통해 사용자 삭제
        UserDAO userDAO = new UserDAO();
        boolean isDeleted = userDAO.deleteUser(userId);

        // 삭제 결과에 따른 처리
        if (isDeleted) {
            response.sendRedirect("UserListServlet");  // 삭제 후 사용자 목록으로 리다이렉트
        } else {
            response.sendRedirect("errorPage.jsp");  // 삭제 실패 시 에러 페이지로 리다이렉트
        }
    }
}
