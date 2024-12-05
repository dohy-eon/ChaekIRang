import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




@WebServlet("/fileDownload")
public class FileDownload extends HttpServlet {
	private static final String BASE_DIR = "C:/Book/";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName = request.getParameter("fileName");
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("idSession");
        System.out.println(fileName + " ");
        if (fileName == null || id == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 요청입니다.");
            return;
        }

        // 파일 경로 설정
        File file = new File(BASE_DIR + id, fileName);

        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일을 찾을 수 없습니다.");
            return;
        }

        String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replace("+", "%20");

        // 다운로드 응답 설정
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment;filename*=UTF-8''" + encodedFileName);


        try (FileInputStream fis = new FileInputStream(file);
            OutputStream os = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}