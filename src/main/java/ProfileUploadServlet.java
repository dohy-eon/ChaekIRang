import javax.servlet.annotation.WebServlet;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.mysql.cj.Session;

import userinfo.UserDAO;


@WebServlet("/profileUpload")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	    maxFileSize = 1024 * 1024 * 10,      // 10MB
	    maxRequestSize = 1024 * 1024 * 50    // 50MB
	)
public class ProfileUploadServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		
		
		HttpSession session = request.getSession();
	    String userId = (String) session.getAttribute("idSession");
	    Part filePart = request.getPart("profilePic");

	    if (filePart != null && filePart.getSize() > 0) {
	        try (InputStream inputStream = filePart.getInputStream()) {
	            UserDAO userDAO = new UserDAO();
	            boolean success = userDAO.updateProfilePicture(userId, inputStream);

	            if (success) {
	            
	                userDAO.alertAndGo(response, "프로필 사진이 변경되었습니다.", "/Chaek/index.jsp");
	                
	                
	                
	            } else {
	                userDAO.alertAndBack(response, "업로드 실패했습니다 유효한 파일을 선택해주세요.");
	            }
	        }
	    } else {
	        response.getWriter().println("유효하지 않은 파일입니다.");
	    }
	}
}