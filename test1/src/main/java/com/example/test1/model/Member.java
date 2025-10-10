package com.example.test1.model;

import lombok.Data;

@Data//自动完成getter和setter
public class Member {
	private String userId;
	private String passWord;
	private String name;
	private String birth;
	private String nickName;
	private String status;
	private String phone;
	private String address;
	private String gender;
	private int cnt;
	private String joinTime;
	private String email;
	private String dateofBirth;
	
}