import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/logout")
public class Logout extends HttpServlet {
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      UserDAO DAO = new UserDAO();
      
      request.setCharacterEncoding("UTF-8");
      HttpSession session = request.getSession();
      session.invalidate();
      DAO.alertAndGo(response, "로그아웃 되었습니다.", "pages/loginSignupPage.jsp");
         
      
      
   }

}
