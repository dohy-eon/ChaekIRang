

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import userinfo.UserDAO;
import userinfo.UserDTO;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        // 사용자 입력 데이터 수집
        String id = request.getParameter("username");
        String password = request.getParameter("password");
        

        
        
        UserDAO DAO = new UserDAO();
        boolean isSuccess = DAO.userLogin(id, password);
        
        if (isSuccess) {
        	UserDTO userInfo = DAO.getUserInfo(id);
        	
        	HttpSession session = request.getSession();
			session.setAttribute("idSession", id);
			session.setAttribute("userPw", userInfo.getUser_pw());
			session.setAttribute("userNickname", userInfo.getNickname());
			session.setAttribute("userEmail", userInfo.getEmail());
			session.setAttribute("userProfile", userInfo.getProfile_img());
			session.setAttribute("userAdmin", userInfo.getIs_admin());
			
			
			
			if(userInfo.getIs_admin().equals("1")) {
				DAO.alertAndGo(response, "Admin 로그인 성공.", "/Chaek/pages/adminPage.jsp");
			} else if (userInfo.getIs_admin().equals("0")){
			
            DAO.alertAndGo(response, "로그인 성공.", "index.jsp");
        } else {
        	DAO.alertAndBack(response, "아이디 또는 비밀번호가 올바르지 않습니다.");
        }
	}

	}
}
