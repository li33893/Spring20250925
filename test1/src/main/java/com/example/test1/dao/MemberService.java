package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Member;

@Service
public class MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	HttpSession session;
	
	public HashMap<String, Object> login( HashMap<String, Object> map){
		
		HashMap<String, Object> resultMap=new HashMap<String, Object>();
		Member member=memberMapper.memberLogin(map);
//		String message=member != null?"로그인 성공!":"로그인 실패!";
//		String result=member != null?"success":"fail";
		String msg="";
		String result="";
		
		
		//-----------this is after hashpwd-------------------------
		System.out.println(member);
		if(member!=null) {
			//id存在，比较pwd之前
			//从map中获取用户的哈希密码密码key，然后和后台的哈希密码比较
			Boolean loginFlg=passwordEncoder.matches((String) map.get("pwd"), member.getPassWord());
			System.out.println(loginFlg);
			
			if(loginFlg) {
				if(member.getCnt()>=5) {
					msg="비밀번호를 5번 이상 잘못 입력하셨습니다";
					result="fail";
					
				}else {
					msg="로그인 성공";
					result="success";
					int cnt=0;
					session.setAttribute("sessionId", member.getUserId());
					session.setAttribute("sessionName", member.getName());
					session.setAttribute("sessionStatus", member.getStatus());
					if(member.getStatus().equals("A")) {
							memberMapper.cntInit(map);
							resultMap.put("url", "/mgr/member/list.do");
							
					}else {
							resultMap.put("url", "/main.do");
					}
				}
			}else {
				
				//登录失败的时候cnt++的地方
				msg="비밀번호를 다시 확인해주세요";
				memberMapper.cntIncrease(map);
				result="fail";
				
			}
		}else {
			//id不存在
			
			msg="아이디가 존재하지 않습니다.";
			result="fail";
			
		}
		
		
		
		
		
		
		
		
		
		
		//---------------------------this is before hashpwd--------------------------------------
//		if(member!=null && member.getCnt()>=5) {
//			msg="비밀번호를 5번 이상 잘못 입력하셨습니다";
//			result="fail";
//	
//		}else if (member!=null) {
////				System.out.println(member.getName());
////				System.out.println(member.getNickName());
//				msg="로그인 성공";
//				result="success";
//				int cnt=0;
//				session.setAttribute("sessionId", member.getUserId());
//				session.setAttribute("sessionName", member.getName());
//				session.setAttribute("sessionStatus", member.getStatus());
//				if(member.getStatus().equals("A")) {
//					memberMapper.cntInit(map);
//					resultMap.put("url", "/mgr/member/list.do");
//					
//				}else {
//					resultMap.put("url", "/main.do");
//				}
//				resultMap.put("result",result);
//		}else {
//			Member idCheck=memberMapper.memberCheck(map);
//			if(idCheck!=null) {
//				
//				if(idCheck.getCnt()>=5) {
//					msg="비밀번호를 5번 이상 잘못 입력하셨습니다";
//				}else {
//					//登录失败的时候cnt++的地方
//					msg="비밀번호를 다시 확인해주세요";
//					memberMapper.cntIncrease(map);
//				}
//				
//			}else {
//				msg="아이디가 존재하지 않습니다.";
//			}
//		}
		
		
		resultMap.put("msg",msg);
		resultMap.put("result",result);
		

			
		return resultMap;
		
	}
	
	public HashMap<String, Object> memberCheck( HashMap<String, Object> map){
			
			HashMap<String, Object> resultMap=new HashMap<String, Object>();
			Member member=memberMapper.memberCheck(map);
			String message=member != null?"이미 사용중인 아이디 입니다":"사용 가능한 아이디 입니다";
			String result=member != null?"true":"false";
			
			resultMap.put("msg",message);
			resultMap.put("result",result);
	
				
			return resultMap;
			
		}

	public HashMap<String, Object> logout(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap=new HashMap<String, Object>();
		//session删除的方法：
		//1用key一个一个删除
		//2一次性删除
		String message=session.getAttribute("sessionName")+"님 로그아웃되었습니다";
		resultMap.put("msg",message);
		
//		session.removeAttribute("sessionId");//1次删除一个属性
		
		session.invalidate();//一次型删除所有属性
		
		return resultMap;
		
	}


	
	
	public HashMap<String, Object> memberInsert(HashMap<String, Object> map) {
		// TODO Auto-generated method stub		
		
//！！！问问同桌这里是不是应该哈希化，是不是根本就没有相关代码，为啥我的xml标了hashpwd老师的没有
//		//先传哈希后的密码：
//		//别忘了传过来的pwd要强行string一下
//		String hashPwd = passwordEncoder.encode((String)map.get("pwd"));
//		map.put("hashPwd", hashPwd);
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		System.out.println("service=>"+map);
		int cnt= memberMapper.memberAdd(map);
		if(cnt<1) {
			resultMap.put("result","fail");
		}else {
			//！！！以后明明不报错后台插入成功了还出现fail，先怀疑是不是自己的success打错了
			resultMap.put("result","success");
		}
		return resultMap;
	}
	


	
	public HashMap<String, Object> getMemberList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List <Member> memberList= memberMapper.memberList(map);
			resultMap.put("memberList",memberList);
			resultMap.put("result","sucess");
		}catch(Exception e) {
			resultMap.put("result","fail");
			System.out.println(e.getMessage());
			
		}
		
		
		
		return resultMap;
	}
	
	public HashMap<String, Object> unlockLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("service=>"+map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			memberMapper.cntInit(map);
			resultMap.put("result","success");
		}catch(Exception e) {
			resultMap.put("result","fail");
			System.out.println(e.getMessage());
			
		}
		
		
		
		return resultMap;
	}
	
	
	public HashMap<String, Object> SearchMember( HashMap<String, Object> map){
		
		HashMap<String, Object> resultMap=new HashMap<String, Object>();
		Member member=memberMapper.memberSearch(map);
		String msg="";
		String result="";
		if(member!=null) {
			result="success";
			
		}else {
			msg="정보를 확인해 주세요";
			result="fail";
		}
		
		resultMap.put("msg",msg);
		resultMap.put("result",result);

			
		return resultMap;
		
	}
	
	public HashMap<String, Object> UpdatePwd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		try {
			Member member=memberMapper.memberLogin(map);
			Boolean pwdFlg=passwordEncoder.matches((String) map.get("pwd"),member.getPassWord());
			if(pwdFlg) {
				resultMap.put("result","fail");
				resultMap.put("msg","기존 비밀번호와 동일합니다");
				
			}else {
				String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
				map.put("hashPwd",hashPwd);
				System.out.println("service=>"+map);
				
				int cnt= memberMapper.pwdUpdate(map);
				if(cnt>0) {
					resultMap.put("result","true");
					resultMap.put("msg","수정되었습니다.");
				}else {
					
					resultMap.put("result","false");
				}
				
			}
			
		}catch (Exception e){
			resultMap.put("result","fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	

}
