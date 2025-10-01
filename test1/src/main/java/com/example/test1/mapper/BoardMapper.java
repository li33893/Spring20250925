package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;
import com.example.test1.model.Board; 

@Mapper
public interface BoardMapper {
	
	List <Board> selectboardList(HashMap<String, Object> map);
	
	Board selectBoard(HashMap<String, Object> map);
	
	int deleteBoard(HashMap<String, Object> map);
	int insertBoard(HashMap<String, Object> map);
	//add comment
	int insertComment(HashMap<String, Object> map);

	List <Board> searchBoard(HashMap<String, Object> map);
	
	//comment list
	List<Comment> selectCommentList(HashMap<String, Object> map);
	
	//게시글 전체 개수
	int selectBoardCnt(HashMap<String, Object> map);
	
	int updateCnt(HashMap<String, Object> map);
}