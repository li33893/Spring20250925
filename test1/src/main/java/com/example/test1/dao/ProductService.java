package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
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


}
