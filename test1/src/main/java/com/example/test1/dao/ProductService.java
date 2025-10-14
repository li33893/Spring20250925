package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Service
public class ProductService {
	
	@Autowired
	ProductMapper productMapper;
	
	public HashMap<String, Object> getFoodList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		//제품 목록
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List <Product> foodList= productMapper.selectFoodList(map);
			List <Menu> menuList= productMapper.selectMenuList(map);
			resultMap.put("foodList",foodList);
			resultMap.put("menuList",menuList);
			resultMap.put("result","sucess");
		}catch(Exception e) {
			resultMap.put("result","fail");
			System.out.println(e.getMessage());
			
		}
		
		 return resultMap;
		
		
	}

	public HashMap<String, Object> getMenuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List <Menu> menuList= productMapper.selectMenuList(map);
			resultMap.put("menuList",menuList);
			resultMap.put("result","sucess");
		}catch(Exception e) {
			resultMap.put("result","fail");
			System.out.println(e.getMessage());
			
		}
		
		 return resultMap;
		
	}
	

	public HashMap<String, Object> addProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			System.out.println("service=>"+map);
			int cnt= productMapper.insertProduct(map);
			resultMap.put("foodNo", map.get("foodNo"));
			resultMap.put("result","success");
			
		}catch(Exception e) {
			resultMap.put("result","fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	
	public void addFoodImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			System.out.println("service=>"+map);
			productMapper.insertFoodImg(map);
			resultMap.put("result","success");
			
		}catch(Exception e) {
			resultMap.put("result","fail");
			System.out.println(e.getMessage());
		}
	}
	
	
	public HashMap<String, Object> getProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("service=>"+map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Product Info= productMapper.selectFoodInfo(map);
			
			//2.返回过程	
			resultMap.put("Info",Info);
			List <Product> fileList=productMapper.selectFileList(map);
			resultMap.put("fileList",fileList);
			resultMap.put("result", "success");
			
		}catch(Exception e) {
			resultMap.put("result","fail");
			System.out.println(e.getMessage());
		}
		
		
		
		return resultMap;
	}


}
