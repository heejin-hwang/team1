package com.acorn.team1.Util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.Reader;
import java.net.URLEncoder;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.io.Resources;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class FileDownloadUtil 
	extends AbstractView {
	
	@Override
	protected void renderMergedOutputModel(
			Map<String, Object> model, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		@SuppressWarnings("unchecked")
		Map<String, Object> fileInfo = (Map<String, Object>)model.get("fileInfo"); // 전솔받은 모델(파일 정보)
		
		String resource = "fileupload.properties";
		Properties properties = new Properties();
		
		Reader reader = Resources.getResourceAsReader(resource);
		properties.load(reader);
		
		String fileNameKey 	= (String)fileInfo.get("fileNameKey"); // 암호화된 파일명(실제 저장된 파일 이름)
		String fileName		= (String)fileInfo.get("fileName"); // 원본 파일명(화면에 표시될 파일 이름)
		String filePath		= properties.getProperty("uploadPath")+(String)fileInfo.get("filePath"); // 파일 경로
		log.info("fileName:" + fileName);
		log.info("filePath:" + filePath);
		File file = new File(filePath, fileNameKey);
		
		// 브라우저, 운영체제정보
		String userAgent = request.getHeader("User-Agent");
		
		// IE
		if(userAgent.indexOf("MSIE") > -1) {
			
			fileName = URLEncoder.encode(fileName, "UTF-8");
		}
		
		// IE 11
		if(userAgent.indexOf("Trident") > -1) {
			
			fileName = URLEncoder.encode(fileName, "UTF-8");
		}
		
		else {
			fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		}
		response.setContentLength((int)file.length());
		// "Content-Disposition: attachment" 브라우저 인식 파일확장자를 포함하여 모든 확장자의 파일들에 대해, 
		// 다운로드시 무조건 "파일 다운로드" 대화 상자가 뜨도록 하는 헤더속성
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = response.getOutputStream();
		
		FileInputStream fis = null;
		
		try {
			
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
			
		} finally {
			
			if(fis != null) {
				fis.close();
			}
		}
		
		out.flush();
	} // end renderMergedOutputModel

} // end class
