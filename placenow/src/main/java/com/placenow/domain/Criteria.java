package com.placenow.domain;


import org.springframework.web.util.UriComponentsBuilder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Criteria {
	private Integer pno = 1;
	private Integer region;
	private Integer category;
	
	private String keyword;

	public Criteria(Integer region, Integer category, String keyword) {
		super();
		this.region = region;
		this.category = category;
		this.keyword = keyword;
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pno", pno)
				.queryParam("region", region)
				.queryParam("category", category)
				.queryParam("keyword", keyword);
		return builder.toUriString();
	}
	
	public String getListLink2() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("region", region)
				.queryParam("category", category)
				.queryParam("keyword", keyword);
		return builder.toUriString();
	}
	
}
