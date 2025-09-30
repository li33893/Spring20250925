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

}
