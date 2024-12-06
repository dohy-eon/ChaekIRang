import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.JDBCUtil;
import discussion.DiscussInfo;

@WebServlet("/SearchDiscussions")
public class SearchDiscussions extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        // 검색어가 없으면 400 오류 반환
        if (keyword == null || keyword.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<DiscussInfo> discussions = new ArrayList<>();

        try {
            conn = JDBCUtil.getConnection();
            
            // 제목과 설명에서 키워드를 검색
            String sql = "SELECT disc_id, title, description, book_image, book_name, genre, time_created FROM discussions WHERE title LIKE ? OR description LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");

            rs = stmt.executeQuery();

            // 결과를 DiscussInfo 리스트에 저장
            while (rs.next()) {
                DiscussInfo discussInfo = new DiscussInfo(
                    rs.getString("disc_id"),
                    rs.getString("title"),
                    rs.getString("book_name"),
                    rs.getString("book_image"),
                    rs.getString("description"),
                    rs.getString("genre"),
                    rs.getString("time_created"),
                    rs.getInt("comment")
                );
                discussions.add(discussInfo);
            }

            // 검색된 토론 데이터를 request에 저장
            request.setAttribute("discussionList", discussions);
            request.setAttribute("searchKeyword", keyword); // 검색어도 전달 (필요하면)

            // JSP로 포워딩
            RequestDispatcher dispatcher = request.getRequestDispatcher("pages/discussSearchPage.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();  // 예외 로그 출력
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);  // 500 에러 반환
        } finally {
            JDBCUtil.close(rs, stmt, conn);
        }
    }
}
