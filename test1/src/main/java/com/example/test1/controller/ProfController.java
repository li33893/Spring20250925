package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.ProfService;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class ProfController {

	@Autowired
	ProfService profService;
	

	@RequestMapping("/prof/list.do") 
    public String list(Model model) throws Exception{
		//这里的modelmodel也可以省略
        return "/prof/list";   
	}
	
	@RequestMapping("/prof/view.do")
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap = new HashMap<String, Object>();//多余
		//把map里的boardNo值放到request里面去
		request.setAttribute("profNo",map.get("profNo"));
        return "/prof/view";
	}
	
	@RequestMapping("/prof/edit.do")
    public String update(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap = new HashMap<String, Object>();//多余
		//把map里的boardNo值放到request里面去
		request.setAttribute("profNo",map.get("profNo"));
		request.setAttribute("deptNo",map.get("deptNo"));
        return "/prof/edit";
	}
	
	@RequestMapping("/prof/add.do") 
    public String join(Model model) throws Exception{
        return "/prof/add";   
	}
	
	@RequestMapping("/prof/addr.do") 
    public String addr(Model model) throws Exception{
        return "/jusoPopup";   
	}
	
	

	
	@RequestMapping(value = "/prof/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String profList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		
		resultMap = profService.SelectProfList(map);
		
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/prof/deleteall.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String DeleteList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectItem").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		System.out.println(map);
		resultMap=profService.DeleteProfList(map);
		return new Gson().toJson(resultMap);
		
	}
	
	@RequestMapping(value = "/prof/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String profview(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = profService.SelectProf(map);
		
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/prof/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String profupdate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = profService.UpdateProf(map);
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
	
	@RequestMapping(value = "/prof/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap =profService.CheckProf(map);
		
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/prof/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addMember(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = profService.AddProf(map);
		
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
}
