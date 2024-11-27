import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

@WebServlet("/getMembers")
public class GetMembersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String search = request.getParameter("search"); // 검색 키워드

        UserDAO dao = new UserDAO();
        List<UserDTO> users;

        try {
            // 검색 키워드에 따라 사용자 조회
            users = dao.getUsers(search != null ? search : "");
            // JSON 응답 생성
            String json = new Gson().toJson(users);
            response.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"서버 에러가 발생했습니다.\"}");
        }
    }
}
