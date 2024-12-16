package UserController;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.UserDAO;


@WebServlet("/nickUpdate")
public class NickUpdateServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO DAO = new UserDAO();
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String cNickname = (String)session.getAttribute("userNickname");
		String id = (String)session.getAttribute("idSession");
		String nNickname = request.getParameter("newNickname");

		
		


		if(cNickname.equals(nNickname)) {
			DAO.alertAndBack(response, "현재 닉네임과 새로운 닉네임이 같습니다.");
		} else {
			//DAO.passUpdate(id, newPassword);
			DAO.nickUpdate(id, nNickname);
			//session.invalidate();
			session.setAttribute("userNickname", nNickname);
			DAO.alertAndGo(response, "닉네임 변경이 완료되었습니다.", "pages/profilePage.jsp");
			
		}
		
		
	}

}
