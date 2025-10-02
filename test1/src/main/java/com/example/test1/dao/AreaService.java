package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.AreaMapper;

import com.example.test1.model.Area;

@Service
public class AreaService {
	
	 @Autowired
	 AreaMapper areaMapper; 

	public HashMap<String, Object> areaList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		
		List <Area> list= areaMapper.selectareaList(map);
		int cnt=areaMapper.selectAreaCnt(map);
		
		
		resultMap.put("list",list);
		resultMap.put("cnt", cnt);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	public HashMap<String, Object> getSiList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		
		List <Area> list= areaMapper.selectSiList(map);
		
		resultMap.put("list",list);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	public HashMap<String, Object> getGuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		
		List <Area> list= areaMapper.selectGuList(map);
		
		resultMap.put("list",list);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	public HashMap<String, Object> getDongList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		
		List <Area> list= areaMapper.selectDongList(map);
		
		resultMap.put("list",list);
		resultMap.put("result","sucess");
		return resultMap;
	}

}
