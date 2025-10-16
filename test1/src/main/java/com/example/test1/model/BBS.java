package com.example.test1.model;

import lombok.Data;

@Data
public class BBS {
	
	private int bbsNum;
	private String title;
	private String contents;
	private int hit;
	private String userId;
	private String cdate;
	private String udate;

}
