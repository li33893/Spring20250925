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
		int cnt=boardMapper.selectBoardCnt(map);
		
		
		resultMap.put("list",list);
		resultMap.put("cnt", cnt);
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
		System.out.println("service=>"+map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt= boardMapper.insertBoard(map);
		resultMap.put("result","success");
		return resultMap;
	}
	
	
	public HashMap<String, Object> getBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("service=>"+map);
		//1.从controller传入，传给mapper的过程
		//1.1这个map是方法参数，是从controller里面传进来的map，controller里面的map也只负责传进来，都是只负责输入不负责传出
		
		int cnt=boardMapper.updateCnt(map);
		Board board= boardMapper.selectBoard(map);//这段的作用是告诉mapper从哪里查询数据   map：从controller传来的查询条件 
													//返回的结果给再装到board里面
		
		List <Comment> commentList=boardMapper.selectCommentList(map);
		//2.返回过程	
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("info",board);
		resultMap.put("commentList", commentList);
		resultMap.put("result","sucess");
		return resultMap;
	}
	
	public HashMap<String, Object> addComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("service=>"+map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			System.out.println(map);
			int cnt= boardMapper.insertComment(map);
			resultMap.put("result","success");
			resultMap.put("msg","게시글이 등록되었습니다");
		}catch(Exception e) {
			System.out.println(e);
			resultMap.put("result","fail");
			resultMap.put("msg","서버 오류가 발생되었습니다. 다시 시도 해주세요.");
		}
		
		
		
		return resultMap;
	}
	
	
	
	

	


	
}
