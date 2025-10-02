package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
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
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.dao.BoardService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import javax.servlet.http.HttpServletRequest;   
import javax.servlet.http.HttpServletResponse;  

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;

	@RequestMapping("/board-list.do") 
    public String login(Model model) throws Exception{
		//这里的modelmodel也可以省略
        return "/board-list";   
	}
	
	@RequestMapping("/board-add.do") 
    public String add(Model model) throws Exception{
        return "/board-add";
	}


	//1.@RequestMapping(...)是告诉Spring MVC 这个方法对应哪个url，请求的类型是什么，返回内容类型是什么
	//代表当前的HTTP请求，允许你设置或读取request范围的属性
	//？？老师给的那个test依旧没看懂
	@RequestMapping("/board-view.do")
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap = new HashMap<String, Object>();//多余
		//把map里的boardNo值放到request里面去
		request.setAttribute("boardNo",map.get("boardNo"));
        return "/board-view";
	}
	
	//!前置知识：MVC，Servelt
	//关键理解：一个方法里返回的都是map，但是输入和返回作用的行不一样，分别在不同的时刻起作用
	//1.@RequestMapping(...)是告诉Spring MVC 这个方法对应哪个url，请求的类型是什么，返回内容类型是什么
	//value里面装的是请求的url
	//method是请求的方法，post/get
	//procedures里面装的是返回数据的格式，告诉Spring我返回的是Jason格式的“数据”（application区别于text纯文本），而且编码是utf-8
	@RequestMapping(value = "/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		//1.输入参数
		//1.1@RequestParam
		//所有传入前端的数据里面最重要的是@RequestParam，他表示前端页面发送过来的数据会自动装进这个map里面
		//e.g.,前端传的是{“boardNo”：3}，那么map.get{"boardNo"}就能取到3
		//1.2 Model model Spring MVC自带的“数据传递的容器”，可以往里面放数据，返回给前端的页面（只在返回时用）
		//？？？注意，这里用了@ResponseBody，意味着Model model根本没用上，不写也行
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		//2.返回
		resultMap = boardService.boardList(map);
		
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.removeBoard(map);
		
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	//
	@RequestMapping(value = "/board-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardInsert(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.addBoard(map);
		
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoard(map);
		
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/comment/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String commentInsert(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.addComment(map);
		
		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "board/delete-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String DeleteList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectItem").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		System.out.println(map);
		resultMap=boardService.removeBoardList(map);
		return new Gson().toJson(resultMap);
		
	}
	
	// controller
	@RequestMapping("/fileUpload.dox")
	@ResponseBody
	public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("boardNo") int boardNo, HttpServletRequest request,HttpServletResponse response, Model model)
	{
		String url = null;
		String path="c:\\img";
		try {

			//String uploadpath = request.getServletContext().getRealPath(path);
			String uploadpath = path;
			String originFilename = multi.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
			long size = multi.getSize();
			String saveFileName = genSaveFileName(extName);
			
//			System.out.println("uploadpath : " + uploadpath);
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);
			String path2 = System.getProperty("user.dir");
			System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
			if(!multi.isEmpty())
			{
				File file = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
				multi.transferTo(file);
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("filename", saveFileName);
				map.put("path", "/img/" + saveFileName);
				map.put("boardNo", boardNo);
				map.put("orgName", originFilename);
				map.put("size", size);
				map.put("ext", extName);
				
				// insert 쿼리 실행
				boardService.addBoardImg(map);
			   // testService.addBoardImg(map);
				
				model.addAttribute("filename", multi.getOriginalFilename());
				model.addAttribute("uploadPath", file.getAbsolutePath());
				
				return "redirect:list.do";
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:list.do";
		
	}
	    
	// 현재 시간을 기준으로 파일 이름 생성
	private String genSaveFileName(String extName) {
		String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;
		
		return fileName;
	}
	
	
	
}
