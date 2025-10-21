package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Prof;

@Mapper
public interface ProfMapper {
	
	//list
	List <Prof> profListSelect(HashMap <String, Object> map);
	
	//count
	int profCount(HashMap <String, Object> map);
	
	
	//deleteall
	int profListDelete (HashMap<String, Object> map);
	
	//view
	Prof profSelect(HashMap<String, Object> map);
	
	//update
	int profUpdate(HashMap<String, Object> map);
	
	//repcheck
	Prof profCheck ( HashMap <String, Object> map);
	
	//add
	int profAdd( HashMap <String, Object> map);
	
	//update d
	int dUpdate(HashMap<String, Object> map);
	

}