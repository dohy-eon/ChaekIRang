import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UserListServlet")
public class UserListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search") != null ? request.getParameter("search") : "";
        
        UserDAO userDAO = new UserDAO();
        List<UserDTO> members = userDAO.getUsers(search); // 수정된 getUsers 호출
        
        request.setAttribute("members", members);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/userManagement.jsp");
        dispatcher.forward(request, response);
    }
}
