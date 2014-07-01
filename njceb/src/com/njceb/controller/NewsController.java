package com.njceb.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import sun.security.krb5.KdcComm;

import com.njceb.bean.News;
import com.njceb.bean.UserInfo;
import com.njceb.service.NewsService;
import com.njceb.service.UserInfoService;



@Controller
public class NewsController {

	private static org.apache.log4j.Logger log = Logger
			.getLogger(NewsController.class);

	@Autowired
	private NewsService newsService;
	private UserInfoService userInfoService;

	@RequestMapping(value = "/getNewsList.action", method = RequestMethod.POST)
	@ResponseBody
	public Map getNewsList(HttpSession session,@RequestParam(value="pageNum") String pageNum) {
//		String userName = session.getAttribute("LOGIN_USER").toString().trim();
//		UserInfo userInfo =userInfoService.getUserInfo(userName);
		List newslist = newsService.getNewsList(pageNum);
		int count = newsService.getTotalNewsCount();
		//需要返回页面总数和分页数目
		Map<String, Object> result = new HashMap<String, Object>(5);
		int totalPage =0;
		//10是指的一页显示多少条，以后设计成前台传回
		if (count%10!=0) {
			totalPage = count/10+1;
		}else {
			totalPage= count/10;
		}
		int curPage =Integer.parseInt(pageNum)+1;
		result.put("total", newslist.size()); 
		result.put("totalPage", totalPage); 
		result.put("pageSize", 10);
		result.put("curPage", curPage);
		result.put("rows", newslist);
		return  result;
		
	}
	
	@RequestMapping(value = "/getNewsListForConsole.action", method = RequestMethod.POST)
	@ResponseBody
	public Map getNewsListForConsole(HttpSession session,@RequestParam(value="page") String page,
			@RequestParam(value="rows") String rows,@RequestParam(value="sort") String sort,
			@RequestParam(value="order") String order) {
//		String userName = session.getAttribute("LOGIN_USER").toString().trim();
//		UserInfo userInfo =userInfoService.getUserInfo(userName);
		page = (Integer.parseInt(page)-1)+"";
		//暂时使用此方法获取列表
		List newslist = newsService.getNewsList(page);
		int count = newsService.getTotalNewsCount();
		//需要返回页面总数和分页数目
		Map<String, Object> result = new HashMap<String, Object>(5);
		int totalPage =0;
		//10是指的一页显示多少条，以后设计成前台传回
		if (count%10!=0) {
			totalPage = count/10+1;
		}else {
			totalPage= count/10;
		}
		int curPage =Integer.parseInt(page)+1;
		result.put("total", newslist.size()); 
		result.put("totalPage", totalPage); 
		result.put("pageSize", 10);
		result.put("curPage", curPage);
		result.put("rows", newslist);
		return  result;
		
	}
	
	
	
	
	@RequestMapping(value = "/addNews.action",method = RequestMethod.POST, produces = "text/xml;charset=UTF-8")
	@ResponseBody
	public String addNews(@RequestParam(value="content") String content,@RequestParam(value="newsTitle") String newsTitle,
			@RequestParam(value="newsAuthor") String newsAuthor,@RequestParam(value="isPost") String isPost
			,@RequestParam(value="isTop") String isTop,@RequestParam(value="fileName") String fileName,
			@RequestParam(value="filePath") String filePath,HttpSession session) {
		
		//获取登录用户信息
//		String loginUser = session.getAttribute("LOGIN_USER").toString();
		//通过用户名，查找用户机构
//		UserInfo userInfo =userInfoService.getUserInfo(loginUser);
//		String orgId=userInfo.getOrgId();
		//暂时写死
		String orgId = "10001";
		
		//获取系统时间
		SimpleDateFormat df= new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		Date nowDate  = calendar.getTime();
		String dateString = "";
		
		//将checkbox的值转化一下
		
		if (isPost.equals("on")) {
			isPost = "1";
			dateString = df.format(nowDate);
		}else {
			isPost="0";
		}
		if (isTop.equals("on")) {
			isTop = "1";
		}else {
			isTop="0";
		}
		
		String newsId = "";
		String changeDateTime="";
		News news = new News(newsId,newsTitle,dateString,newsAuthor,content,orgId,
				isPost,isTop,changeDateTime,fileName,filePath);
		newsService.addNews(news);
		return  "OK";
		
	}
	@RequestMapping(value = "/updateNews.action", method = RequestMethod.POST, produces = "text/xml;charset=UTF-8")
	@ResponseBody
	public String  updateNews(@RequestParam(value="content") String newsId,@RequestParam(value="content") String content,@RequestParam(value="newsTitle") String newsTitle,
			@RequestParam(value="newsAuthor") String newsAuthor,@RequestParam(value="isPost") String isPost
			,@RequestParam(value="isTop") String isTop,@RequestParam(value="fileName") String fileName,
			@RequestParam(value="filePath") String filePath,HttpSession session){
		
		//获取登录用户信息
		String loginUser = session.getAttribute("LOGIN_USER").toString();
		//通过用户名，查找用户机构
		UserInfo userInfo =userInfoService.getUserInfo(loginUser);
		String orgId=userInfo.getOrgId();
		//获取系统时间
		SimpleDateFormat df= new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		Date nowDate  = calendar.getTime();
		String dateString = df.format(nowDate);
		System.out.println("date="+dateString);
			
		String changeDateTime = dateString;
		News news = new News(newsId,newsTitle,dateString,newsAuthor,content,orgId,
				isPost,isTop,changeDateTime,fileName,filePath);
		return  "OK";
	}
	@RequestMapping(value = "/delNews.action", method = RequestMethod.POST)
	@ResponseBody
	public String  delNews(@RequestParam(value="newsId") String newsId) {
		newsService.deleteNews(newsId);
		return  "OK";
	}
	
	@RequestMapping(value = "/getNewsById.action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  getNewsById(@RequestParam(value="newsId") String newsId) {
		Map<String , Object> map= newsService.getNewsById(newsId);
		return  map;
	}
	
}
