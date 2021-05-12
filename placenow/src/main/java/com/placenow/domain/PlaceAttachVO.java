package com.placenow.domain;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper=true)
public class PlaceAttachVO extends AttachFileDTO {
	private Integer pno;
}
