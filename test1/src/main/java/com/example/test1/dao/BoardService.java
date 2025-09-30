package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;


@Service

public class BoardService {
	 @Autowired
	 BoardMapper boardMapper; 
	
	public HashMap<String, Object> boardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		List <Board> list= boardMapper.selectboardList(map);
		
		resultMap.put("list",list);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	public HashMap<String, Object> removeBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		int cnt= boardMapper.deleteBoard(map);
		
		resultMap.put("result","sucess");
		return resultMap;
	}
	

	public HashMap<String, Object> addBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		int cnt= boardMapper.insertBoard(map);
		resultMap.put("result","success");
		return resultMap;
	}
	
	//1.这个map是方法参数，是从controller里面传进来的map，controller里面的map也只负责传进来，都是只负责输入不负责传出
	//
	public HashMap<String, Object> getBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		Board board= boardMapper.selectBoard(map);
		List <Comment> commentList=boardMapper.selectCommentList(map);
		
		resultMap.put("info",board);
		resultMap.put("commentList", commentList);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	
	
	

	


	
}
