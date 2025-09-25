package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;


@Service

public class BoardService {
	 @Autowired
	 BoardMapper boardMapper; 
	
	public HashMap<String, Object> boardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>"+map);
		List <Board> list= boardMapper.boardList(map);
		
		resultMap.put("list",list);
		resultMap.put("result","sucess");
		return resultMap;
	}


	
}
