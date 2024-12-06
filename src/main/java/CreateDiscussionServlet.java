import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;

import db.JDBCUtil;

@WebServlet("/CreateDiscussionServlet")
public class CreateDiscussionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String bookName = request.getParameter("bookName");
        String description = request.getParameter("description");
        String genre = request.getParameter("genre");
        String bookImage = request.getParameter("bookImage");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = JDBCUtil.getConnection();
            String sql = "INSERT INTO discussions (title, book_name, book_image, description, genre) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, title);
            pstmt.setString(2, bookName);
            pstmt.setString(3, bookImage);
            pstmt.setString(4, description);
            pstmt.setString(5, genre);

            int rows = pstmt.executeUpdate();

            String message = "";
            String redirectUrl = "/Chaek/pages/discussMainPage.jsp"; // 리디렉션할 URL 기본값

            if (rows > 0) {
                message = "토론 주제가 성공적으로 생성되었습니다!";
            } else {
                message = "토론 주제 생성에 실패했습니다. 다시 시도해주세요.";
            }

            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('" + message + "');");
            out.println("setTimeout(function(){ window.location.href='" + redirectUrl + "'; }, 1000);"); // 1초 후 리디렉션
            out.println("</script>");
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('오류가 발생했습니다. 관리자에게 문의하세요.');");
            out.println("setTimeout(function(){ window.location.href='discussMainPage.jsp'; }, 1000);"); // 오류 후 리디렉션
            out.println("</script>");
            out.flush();
        } finally {
            JDBCUtil.close(pstmt, conn);
        }
    }
}
