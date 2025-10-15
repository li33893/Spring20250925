package com.example.test1.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.test1.dao.PointService;

@Controller
public class MapController {
	
	@RequestMapping("/map.do") 
    public String pointList(Model model) throws Exception{
		
        return "/map/map4";   
	}
	
	

	
	

}