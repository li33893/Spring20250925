package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.StuService;
import com.example.test1.dao.UserService;
import com.google.gson.Gson;

@Controller
public class StuController {

	@Autowired
	StuService stuService;
	
	@RequestMapping("/stu-list.do") 
    public String login(Model model) throws Exception{

        return "/stu-list";
    
	}
	
	@RequestMapping(value = "/stu-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stulist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.stuInfo(map);
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.getStuList(map);
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.removeStu(map);
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/stu-view.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		request.setAttribute("stuNo",map.get("stuNo"));
        return "/stu-view";
	}
	
	@RequestMapping(value = "/stu-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.getStu(map);
		
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
}
