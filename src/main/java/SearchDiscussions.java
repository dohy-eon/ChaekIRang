import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import db.JDBCUtil;

@WebServlet("/SearchDiscussions")
public class SearchDiscussions extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청에서 검색 키워드 가져오기
        String keyword = request.getParameter("keyword");
        if (keyword == null || keyword.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        // 검색 결과 저장용 리스트
        ArrayList<DiscussionDTO> discussions = new ArrayList<>();

        try {
            conn = JDBCUtil.getConnection();
            String sql = "SELECT title, description, book_image, comment_count FROM discussions WHERE title LIKE ? OR description LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");

            rs = stmt.executeQuery();
            while (rs.next()) {
                DiscussionDTO discussion = new DiscussionDTO();
                discussion.setTitle(rs.getString("title"));
                discussion.setDescription(rs.getString("description"));
                discussion.setBookImage(rs.getString("book_image"));
                discussion.setComment(rs.getInt("comment_count"));
                discussions.add(discussion);
            }

            // JSON 변환
            String jsonResponse = new Gson().toJson(discussions);

            // 응답 헤더와 JSON 출력
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print(jsonResponse);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            JDBCUtil.close(rs, stmt, conn);
        }
    }
}
