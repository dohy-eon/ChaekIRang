

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import userinfo.UserDAO;


@WebServlet("/passUpdate")
public class PwUpdateServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO DAO = new UserDAO();
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String dbPw = (String)session.getAttribute("userPw");
		String id = (String)session.getAttribute("idSession");
		String currentPassword = request.getParameter("currentPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmNewPassword = request.getParameter("confirmNewPassword");
		
		
		if(!newPassword.equals(confirmNewPassword)) {
			DAO.alertAndBack(response, "새로운 비밀번호와 비밀번호 확인이 다릅니다.");
		}else if(!dbPw.equals(currentPassword)) {
			DAO.alertAndBack(response, "현재 비밀번호가 올바르지 않습니다.");
		}else if(currentPassword.equals(newPassword)) {
			DAO.alertAndBack(response, "현재 비밀번호와 새로운 비밀번호와 같습니다.");
		} else {
			DAO.passUpdate(id, newPassword);
			session.invalidate();
			DAO.alertAndGo(response, "비밀번호가 변경 완료되었습니다, 다시 로그인 하십시오.", "pages/loginSignupPage.jsp");
		}
		
		
	}

}
