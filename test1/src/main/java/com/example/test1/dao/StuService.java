package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.StuMapper;
import com.example.test1.model.Student;


@Service

public class StuService {
	 @Autowired
	 StuMapper stuMapper; 
	
	
	public HashMap<String, Object> stuInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		Student stu= stuMapper. stuInfo(map);
		if (stu!=null) {
			System.out.println(stu.getStuName());
			System.out.println(stu.getStuNo());
			System.out.println(stu.getStuDept());
		}
		resultMap.put("info",stu);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	public HashMap<String, Object> getStuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String,Object>resultMap=new HashMap<String,Object>();
		List <Student> stuList=stuMapper.stuList(map);
		
		resultMap.put("list", stuList);
		resultMap.put("result", "success");
		
		return resultMap;
		
	}


	public HashMap<String, Object> removeStu(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		int cnt=stuMapper.deleteStu(map);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	public HashMap<String, Object> getView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String,Object>resultMap=new HashMap<String,Object>();
		Student stu=stuMapper.getStuView(map);
		
		resultMap.put("info",stu);
		resultMap.put("result","sucess");
		
		
		return resultMap;
		
	}
	
	public HashMap<String, Object> getEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		int cnt= stuMapper.updateStu(map);
		resultMap.put("result","sucess");
		return resultMap;
	}


	
}
