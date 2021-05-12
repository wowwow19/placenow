package com.placenow.domain;


import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class PlaceVO {
	private Integer pno;
	private Integer region;
	private Integer category;
	private String pname;
	private String address;
	private Integer popularity;
	private Integer replyNum;
	private Integer favNum;
	private String updateDate;
	
	private List<PlaceAttachVO> attachList = new ArrayList<PlaceAttachVO>();
}
