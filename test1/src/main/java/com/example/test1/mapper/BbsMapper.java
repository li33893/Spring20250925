package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.BBS;
import com.example.test1.model.Board;
import com.example.test1.model.Member;

@Mapper
public interface BbsMapper {
	//list
	List <BBS> bbsListSelect(HashMap<String, Object> map);
	
	//insert
	int bbsInsert(HashMap<String, Object> map);
	
	//deleteall
	int bbsListDelete (HashMap<String, Object> map);
	
	//view
	BBS bbsSelect(HashMap<String, Object> map);
	
	//update
	int bbsUpdate(HashMap<String, Object> map);
	
	//cnt
	int bbsCount(HashMap<String, Object> map);
	
	//upload img
	int bbsImgInsert(HashMap<String, Object> map);
		
	//file content
	List <BBS> fileListSelect(HashMap<String, Object> map);
	
	
	
}
