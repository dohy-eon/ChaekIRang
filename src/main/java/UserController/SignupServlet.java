package UserController;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.UserDAO;
import DTO.UserDTO;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/signup") // 어노테이션 방식으로 매핑
public class SignupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 사용자 입력 데이터 수집
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String nickname = request.getParameter("nickname");
        String email = request.getParameter("email");

        if(password.length() < 8) {
        	UserDAO.alertAndBack(response, "비밀번호는 8자 이상이어야 합니다.");
        	return;
        }
        if(!password.equals(confirmPassword)) {
        	UserDAO.alertAndBack(response, "비밀번호가 서로 다릅니다.");
        	return;
        }
        
        
        // User 객체 생성
        UserDTO user = new UserDTO();
        user.setUser_id(id);
        user.setUser_pw(password);
        user.setNickname(nickname);
        user.setEmail(email);
        user.setProfile_img("0");
        user.setIs_admin("0");
        
        
        
        
        // (예시) 회원가입 성공 로직
        UserDAO DAO = new UserDAO();
        boolean checkId = DAO.checkId(user.getUser_id());
        boolean isSuccess = DAO.userInsert(user);
        
        if(checkId) {
        	DAO.alertAndBack(response, "중복된 ID 입니다.");
        }
        if(!DAO.isValidId(user.getUser_id())) {
        	DAO.alertAndBack(response, "ID는 특수문자와 공백이 불가능합니다.");
        }
        if (isSuccess) {
            DAO.alertAndGo(response, "회원가입에 성공했습니다.", "pages/signupSuccessPage.jsp");
        } else {
        	DAO.alertAndGo(response, "회원가입에 실패했습니다.", "pages/loginSignupPage.jsp");
        }
        
    }


}
