package Controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

import DAO.UserDAO;
import DTO.UserDTO;

@WebServlet("/getUserInfo")
public class GetUserInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String userId = request.getParameter("user_id"); // Get user_id from request

        UserDAO dao = new UserDAO();
        UserDTO user;

        try {
            // Check if the user_id is provided
            if (userId != null && !userId.trim().isEmpty()) {
                // Get the user info based on user_id
                user = dao.getUserInfo(userId);
                
                if (user != null) {
                    // Convert user info (nickname and profile_img) to JSON format
                    String json = new Gson().toJson(user);
                    response.getWriter().write(json);
                } else {
                    // If user not found, send error response
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("{\"error\": \"User not found\"}");
                }
            } else {
                // If user_id is missing, send error response
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"User ID is required\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Server error occurred\"}");
        }
    }
}
