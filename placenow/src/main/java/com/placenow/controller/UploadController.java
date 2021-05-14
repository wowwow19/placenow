package com.placenow.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import com.placenow.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController implements ServletContextAware {
	private ServletContext servletContext;
//	public static final String UPLOAD_PATH = "/Users/user/upload/placenow/";
	public static final String UPLOAD_PATH = "c:/upload/placenow/";
	
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	@GetMapping("upload")
	public void uploadForm() {
		log.info("upload get...");
	}
	
	@GetMapping("uploadAjax")
	public void uploadAjax() {
		log.info("uploadAjax get...");
	}
	
	@PostMapping("uploadAction")
	public @ResponseBody List<AttachFileDTO> upload(MultipartFile[] files, Model model) throws IllegalStateException, IOException {
		log.info("upload post...");
		
		// 폴더 생성
		File uploadPath = new File(UPLOAD_PATH, getFolder());
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		for(MultipartFile mf : files) {
			AttachFileDTO dto = new AttachFileDTO();
			log.info(".........................");
			log.info("upload file name..." + mf.getOriginalFilename());
			log.info("upload file size..." + mf.getSize());
			
			String uuid = UUID.randomUUID().toString();
			String uploadFileName = uuid + "_" + mf.getOriginalFilename();
			File saveFile = new File(uploadPath, uploadFileName);
			mf.transferTo(saveFile);
			
			dto.setFileName(mf.getOriginalFilename());
			dto.setUuid(uuid);
			dto.setUploadPath(getFolder());
			
			// 업로드된 파일이 이미지일 경우 : 썸네일 이미지로 제작
			if(isImageType(saveFile)) {
				FileOutputStream fos = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(mf.getInputStream(), fos, 100, 100);
				dto.setImage(true);
				fos.close();
			}
			list.add(dto);
		}
		return list;
	}
	
	@GetMapping("display")
	public @ResponseBody ResponseEntity<byte[]> getFile(String fileName) throws IOException {
		log.info("getFile...");
		log.info("fileName..." + fileName);
		
		File file = new File(UPLOAD_PATH + fileName);
		log.info("file..." + file);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", Files.probeContentType(file.toPath()));
		return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
	}
	
	@GetMapping(value="download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> download(String fileName) throws UnsupportedEncodingException {
		log.info("download..." + fileName);
		
		Resource resource = new FileSystemResource(UPLOAD_PATH + fileName);
		log.info("resource..." + resource);
		
		String sourceName = resource.getFilename();
		sourceName = sourceName.substring(sourceName.indexOf("_")+1);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; fileName=" + new String(sourceName.getBytes("utf-8"), "iso-8859-1"));
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PostMapping("deleteFile")
	public @ResponseBody String deleteFile(@RequestBody AttachFileDTO dto) {
		log.info("deleteFile..." + dto);
		
		new File(UPLOAD_PATH, dto.getDownloadPath()).delete();
		if(dto.isImage()) {
			new File(UPLOAD_PATH, dto.getThumbnailPath()).delete();
		}
		return "deleted";
	}
	
	private String getFolder() {
		return new SimpleDateFormat("yyyy/MM/dd").format(new Date());
	}
	
	private boolean isImageType(File file) throws IOException {
		String mime = Files.probeContentType(file.toPath());
		return mime != null && mime.startsWith("image");
	}
}
