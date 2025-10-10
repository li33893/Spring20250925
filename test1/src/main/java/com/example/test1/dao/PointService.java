package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.PointMapper;
import com.example.test1.model.Member;
import com.example.test1.model.Point;

@Service
public class PointService {


	 @Autowired
	 PointMapper pointMapper; 
	
	public HashMap<String, Object> getPointList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		
		try {
			List <Point> customerList= pointMapper.selectPointList(map);
			resultMap.put("customerList",customerList);
			resultMap.put("result","sucess");
		}catch(Exception e) {
			resultMap.put("result","fail");
			System.out.println(e.getMessage());
			
		}
		
		 return resultMap;
		
		
	}

}
