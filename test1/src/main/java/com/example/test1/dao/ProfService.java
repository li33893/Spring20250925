package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProfMapper;
import com.example.test1.model.Prof;

@Service
public class ProfService{
	
	@Autowired
	ProfMapper profMapper;

	public HashMap<String, Object> SelectProfList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		//제품 목록
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List <Prof> profList= profMapper.profListSelect(map);
			resultMap.put("profList",profList);
			int totalRows=profMapper.profCount(map);
			resultMap.put("totalRows",totalRows);
			resultMap.put("result","sucess");
		}catch(Exception e) {
			resultMap.put("result","fail");
			System.out.println(e.getMessage());		
		}	
		 return resultMap;
				
	}
	
	public HashMap<String, Object> DeleteProfList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		int cnt=profMapper.profListDelete(map);
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> SelectProf(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("service=>"+map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//1.从controller传入，传给mapper的过程
		//1.1这个map是方法参数，是从controller里面传进来的map，controller里面的map也只负责传进来，都是只负责输入不负责传出
		
		
		Prof prof= profMapper.profSelect(map);//这段的作用是告诉mapper从哪里查询数据   map：从controller传来的查询条件 
													//返回的结果给再装到board里面	
		
		//2.返回过程	
		resultMap.put("prof",prof);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	public HashMap<String, Object> UpdateProf(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
	       int cnt = profMapper.profUpdate(map);
	       int cnt2 = profMapper.dUpdate(map);

	        // ⭐ 检查是否更新成功
	        if (cnt > 0 && cnt2 > 0) {
	            resultMap.put("result", "success");
	        } else if (cnt > 0) {
	            resultMap.put("result", "fail");
	        } else {
	            resultMap.put("result", "fail");
	        }
	        
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        System.out.println(e.getMessage());
	    }
	    
	    return resultMap;
	}
	
	
	public HashMap<String, Object> CheckProf( HashMap<String, Object> map){
		
		HashMap<String, Object> resultMap=new HashMap<String, Object>();
		Prof prof=profMapper.profCheck(map);
		String message=prof != null?"이미 사용중인 아이디 입니다":"사용 가능한 아이디 입니다";
		String result=prof != null?"true":"false";
		
		resultMap.put("msg",message);
		resultMap.put("result",result);

			
		return resultMap;
		
	}
	
	public HashMap<String, Object> AddProf(HashMap<String, Object> map) {
		// TODO Auto-generated method stub		
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		System.out.println("service=>"+map);
		int cnt= profMapper.profAdd(map);
		if(cnt<1) {
			resultMap.put("result","fail");
		}else {
			//！！！以后明明不报错后台插入成功了还出现fail，先怀疑是不是自己的success打错了
			resultMap.put("result","success");
		}
		return resultMap;
	}
	
	
	
	
	
	
}
