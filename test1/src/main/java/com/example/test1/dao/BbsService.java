package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BbsMapper;
import com.example.test1.mapper.BoardMapper;
import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.BBS;
import com.example.test1.model.Board;
import com.example.test1.model.Member;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Service
public class BbsService {
	
	@Autowired
	BbsMapper bbsMapper; 
	
	@Autowired
	MemberMapper memberMapper; 
	
	@Autowired
	HttpSession session;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	public HashMap<String, Object> SelectBbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		//제품 목록
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		 
		
		try {
			List <BBS> bbsList= bbsMapper.bbsListSelect(map);
			resultMap.put("bbsList",bbsList);
			int totalRows=bbsMapper.bbsCount(map);
			resultMap.put("totalRows",totalRows);
			resultMap.put("result","sucess");
		}catch(Exception e) {
			resultMap.put("result","fail");
			System.out.println(e.getMessage());
			
		}
		
		 return resultMap;
		
		
	}
	
	public HashMap<String, Object> InsertBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("service=>"+map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt= bbsMapper.bbsInsert(map);
		resultMap.put("bbsNum", map.get("bbsNum"));
		resultMap.put("result","success");
		return resultMap;
		
	}
	
	public HashMap<String, Object> DeleteBbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		int cnt=bbsMapper.bbsListDelete(map);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	
	public HashMap<String, Object> SelectBBS(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("service=>"+map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//1.从controller传入，传给mapper的过程
		//1.1这个map是方法参数，是从controller里面传进来的map，controller里面的map也只负责传进来，都是只负责输入不负责传出
		
		map.put("bbsNum", map.get("bbsNum"));
		BBS bbs= bbsMapper.bbsSelect(map);//这段的作用是告诉mapper从哪里查询数据   map：从controller传来的查询条件 
													//返回的结果给再装到board里面	
		
		List <BBS> fileList=bbsMapper.fileListSelect(map);
		
		//2.返回过程	
		resultMap.put("bbs",bbs);
		resultMap.put("fileList",fileList);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	public HashMap<String, Object> UpdateBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("service=>"+map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt= bbsMapper.bbsUpdate(map);
		resultMap.put("result","success");
		return resultMap;
	}
	
	public void InsertBbsImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		int cnt= bbsMapper.bbsImgInsert(map);
	}
	
	
}
