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

	public HashMap<String, Object> getAreaList(HashMap<String, Object> map) {
		
		// TODO Auto-generated method stub
		HashMap<String,Object>resultMap=new HashMap<String,Object>();
		//【发送】areaMapper.areaList(map)：传递map
		List <Area> areaList=areaMapper.areaList(map);
		
		int rowNum=areaMapper.rowNum(map);
		
		resultMap.put("list", areaList);//resultMap.put("list", areaMapper.areaList(map))
		
		resultMap.put("rowNum", rowNum);
		
		resultMap.put("result", "success");
		
		return resultMap;
		
	}
	
	public HashMap<String, Object> getSiList(HashMap<String, Object> map) {
			
			// TODO Auto-generated method stub
			HashMap<String,Object>resultMap=new HashMap<String,Object>();
			//【发送】areaMapper.areaList(map)：传递map
			List <Area> siList=areaMapper.siList(map);
			
			resultMap.put("list", siList);//resultMap.put("list", areaMapper.areaList(map))
			
			resultMap.put("result", "success");
			
			return resultMap;
			
	}
	
	public HashMap<String, Object> getGuList(HashMap<String, Object> map) {
		
		// TODO Auto-generated method stub
		HashMap<String,Object>resultMap=new HashMap<String,Object>();
		//【发送】areaMapper.areaList(map)：传递map
		List <Area> guList=areaMapper.guList(map);
		
		resultMap.put("list", guList);//resultMap.put("list", areaMapper.areaList(map))
		
		resultMap.put("result", "success");
		
		return resultMap;
		
	}
	
	public HashMap<String, Object> getDongList(HashMap<String, Object> map) {
		
		// TODO Auto-generated method stub
		HashMap<String,Object>resultMap=new HashMap<String,Object>();
		//【发送】areaMapper.areaList(map)：传递map
		List <Area> dongList=areaMapper.dongList(map);
		
		resultMap.put("list", dongList);//resultMap.put("list", areaMapper.areaList(map))
		
		resultMap.put("result", "success");
		
		return resultMap;
		
	}
}
