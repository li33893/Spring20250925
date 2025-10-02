package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student; 

@Mapper
public interface StuMapper{
	//返回带student泛型的list
	 List <Student> stuList(HashMap <String,Object>map);
	 Student getStuView(HashMap <String,Object>map);
	 int updateStu(HashMap<String, Object> map);
	 int deleteStu(HashMap<String, Object> map);
	 Student stuInfo(HashMap<String, Object> map);
	 int deleteStuList(HashMap<String, Object> map);
	
}
