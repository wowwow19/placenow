package com.placenow.task;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.placenow.controller.UploadController;
import com.placenow.domain.PlaceAttachVO;
import com.placenow.mapper.PlaceAttachMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	@Autowired
	private PlaceAttachMapper mapper;
	
	@Scheduled(cron="0 * * * * *")
	public void checkFiles() {
		log.warn("File Check Task run...");
		log.warn("======================");
		
		List<PlaceAttachVO> fileList = mapper.getOldFiles();
		fileList.forEach(log::warn);
		
		List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get(UploadController.UPLOAD_PATH, vo.getDownloadPath())).collect(Collectors.toList());
		fileList.stream().filter(vo -> vo.isImage()).map(vo -> Paths.get(UploadController.UPLOAD_PATH, vo.getThumbnailPath())).forEach(fileListPaths::add);
		
		// 삭제될 파일이 없을 경우
		if(fileList.size() == 0) return;
		
		File targetDir = Paths.get(UploadController.UPLOAD_PATH, fileList.get(0).getUploadPath()).toFile();
		List<File> removeFiles = Arrays.asList(targetDir.listFiles(file -> !fileListPaths.contains(file.toPath())));
		removeFiles.forEach(file -> {
			log.warn("삭제될 파일...");
			log.warn(file.getAbsolutePath());
			file.delete();
		});
		
	}
}
