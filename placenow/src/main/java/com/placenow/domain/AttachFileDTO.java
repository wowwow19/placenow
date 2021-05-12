package com.placenow.domain;


import lombok.Data;

@Data
public class AttachFileDTO {
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
	
	public String getDownloadPath() {
		return uploadPath + "/" + uuid + "_" + fileName;
	}
	
	public String getThumbnailPath() {
		return uploadPath + "/s_" + uuid + "_" + fileName;
	}
	
}
