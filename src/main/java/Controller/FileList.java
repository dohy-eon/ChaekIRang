package Controller;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;



@WebServlet("/fileList")
public class FileList extends HttpServlet {
	private static final String BASE_DIR = "C:/Book/";
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  
	      
	      request.setCharacterEncoding("UTF-8");
	      HttpSession session = request.getSession();
	      String id = (String)session.getAttribute("idSession");
	      File folder = new File(BASE_DIR + id);
	      File[] files = folder.listFiles();
	      
	      JsonArray fileList = new JsonArray();
	  
	      for (File file : files) {
              if (file.isFile()) {
                  JsonObject fileObj = new JsonObject();
                  fileObj.addProperty("fileName", file.getName());
                  fileObj.addProperty("downloadUrl", "/fileDownload?fileName=" + file.getName());
                  fileList.add(fileObj);
              }
          }
	      response.setContentType("application/json;charset=UTF-8");
	      response.getWriter().write(fileList.toString());
	}
}