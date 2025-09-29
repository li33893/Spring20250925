package com.example.test1.controller;

import java.util.Random;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String ranstr="";
		Random ran =new Random();
		for (int i=1;i<7;i++) {
			ranstr+=ran.nextInt(10);
		}
		System.out.println(ranstr);	
	}
	

}
