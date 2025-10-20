package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
	//login
	Member memberLogin ( HashMap <String, Object> map);
	//id check
	Member memberCheck ( HashMap <String, Object> map);
	int memberAdd (HashMap <String, Object> map);
	
	List <Member> memberList(HashMap <String, Object> map);
	
	int cntInit(HashMap<String, Object> map);
	int cntIncrease(HashMap<String, Object> map);
	
	
	Member memberSearch ( HashMap <String, Object> map);
	
	int pwdUpdate(HashMap <String, Object> map);
	
	int pwdCheck(HashMap <String, Object> map);
	
	int memberCount(HashMap <String, Object> map);
	
	int memberListDelete (HashMap<String, Object> map);
	
	Member memberSelect(HashMap<String, Object> map);

}
