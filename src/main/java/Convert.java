import com.convertapi.client.Config;
import com.convertapi.client.ConvertApi;
import com.convertapi.client.Param;

import userinfo.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.ExecutionException;

@WebServlet("/convert")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,    // 1MB
                 maxFileSize = 1024 * 1024 * 50,     // 50MB
                 maxRequestSize = 1024 * 1024 * 50)  // 50MB
public class Convert extends HttpServlet {
	
    private static final String UPLOAD_DIR = "C:/upload/";
    private static final String DOWNLOAD_DIR = "C:/Book/";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/pdf;charset=UTF-8");
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("idSession") + "/";
        UserDAO DAO = new UserDAO();
        if (userId == null || userId.isEmpty()) {
            DAO.alertAndGo(response, "로그인 상태가 아닙니다.", "pages/loginSignupPage.jsp");
        }
        
        // ConvertAPI 설정

        Config.setDefaultApiCredentials("secret_r8O4nRyjlCetWiB1");


        // 업로드된 파일을 가져오기
        Part filePart = request.getPart("file");
        
        // 파일 이름 가져오기
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        // 파일 이름 정규화 (불필요한 문자를 제거)
        fileName = fileName.replaceAll("[\\\\/:*?\"<>|]", "_");
        
        // 파일 저장 경로 설정
        File uploadFile = new File(UPLOAD_DIR + fileName);
        if (!uploadFile.exists()) {
        	uploadFile.mkdirs();
        }
        
        // 파일 저장
        filePart.write(uploadFile.getAbsolutePath());

        try {
            // EPUB 파일을 PDF로 변환
            var conversionResult = ConvertApi.convert("epub", "pdf",
                new Param("File", uploadFile.toPath())
            ).get();

            // 변환된 파일 저장 경로 설정
            File downloadDirectory = new File(DOWNLOAD_DIR+userId);

            // 원본 이름으로 저장된 파일을 타임스탬프 추가된 이름으로 변경
            String uniqueFileName = addTimestampToFileName(fileName); 
            File pdfFile = new File(DOWNLOAD_DIR+userId + uniqueFileName.replace(".epub", ".pdf"));

            // 변환된 파일 저장
            conversionResult.saveFilesSync(Paths.get(DOWNLOAD_DIR+userId));

            // 파일 이름 변경
            File convertedFile = new File(DOWNLOAD_DIR+userId + uniqueFileName.replace(".epub", ".pdf"));
            Files.move(Paths.get(DOWNLOAD_DIR+userId + fileName.replace(".epub", ".pdf")), convertedFile.toPath());

            // PDF 파일을 클라이언트에 다운로드로 제공
            response.setContentType("application/pdf");

            // 파일 이름을 URL 인코딩하여 한글 이름을 인식하도록 설정
            String encodedFileName = new String(convertedFile.getName().getBytes("UTF-8"), "ISO-8859-1");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");

            Files.copy(convertedFile.toPath(), response.getOutputStream());
            response.getOutputStream().flush();

        } catch (InterruptedException | ExecutionException | IOException e) {
            e.printStackTrace();
            response.getWriter().write("File conversion failed: " + e.getMessage());
        } finally {
            // 임시 파일 삭제
            // uploadFile.delete();
        }
    }

    // 파일 이름에 현재 날짜와 시간, 분, 초를 추가하는 메서드
    private String addTimestampToFileName(String fileName) {
        // 현재 날짜 및 시간 (년-월-일-시-분-초)
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmss");
        String timestamp = sdf.format(new Date());

        // 파일 이름에서 확장자 추출
        String baseName = fileName.substring(0, fileName.lastIndexOf('.'));
        String extension = fileName.substring(fileName.lastIndexOf('.'));

        // 파일 이름에 타임스탬프 추가
        return baseName + "_" + timestamp + extension;
    }
}
