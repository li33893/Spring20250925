package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.AreaService;
import com.google.gson.Gson;

@Controller
public class AreaController {
	
	//【返回】
	@Autowired
	AreaService areaService;
	
	@RequestMapping("/area/list.do") 
    public String getList(Model model) throws Exception{

        return "/area/area-list";
    }
	
	//【发送】:只做了两件事：找到方法，把参数给service的方法
	//告诉spring，这个areaList方法是处理/area-list。dox的请求
	//发送的时候的requestParam，也就是map是ajax里面的data里面的param
	@RequestMapping(value = "/area-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String AreaList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//【发送】
		//只是把map给service里的getAreaList
		resultMap = areaService.getAreaList(map);
		
		
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "/si-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String SiList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//【发送】
		//只是把map给service里的getAreaList
		resultMap = areaService.getSiList(map);
		
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/gu-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String GuList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//【发送】
		//只是把map给service里的getAreaList
		resultMap = areaService.getGuList(map);
		
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/dong-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String DongList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//【发送】
		//只是把map给service里的getAreaList
		resultMap = areaService.getDongList(map);
		
		
		return new Gson().toJson(resultMap);
	}


}
