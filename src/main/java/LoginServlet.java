

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        // 사용자 입력 데이터 수집
        String id = request.getParameter("username");
        String password = request.getParameter("password");
        
        UserDTO user = new UserDTO();
        user.setUser_id(id);
        user.setUser_pw(password);
        
        
        UserDAO DAO = new UserDAO();
        boolean isSuccess = DAO.userLogin(user.getUser_id(), user.getUser_pw());
        System.out.println(isSuccess);
        if (isSuccess) {
        	HttpSession session = request.getSession();
			session.setAttribute("idSession", id);
			System.out.println((String)session.getAttribute("idSession"));
            DAO.alertAndGo(response, "로그인 성공.", "index.jsp");
        } else {
        	DAO.alertAndBack(response, "아이디 또는 비밀번호가 올바르지 않습니다.");
        }
	}

}
