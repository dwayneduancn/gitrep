package com.njceb.controller;

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
	@RequestMapping(value = "/addNews.action",method = RequestMethod.POST, produces = "text/xml;charset=UTF-8")
	@ResponseBody
	public String addNews(@RequestParam(value="content") String content,@RequestParam(value="newsTitle") String newsTitle) {
		News news = new News("",content, "",newsTitle);
		newsService.addNews(news);
		return  "OK";
		
	}
	@RequestMapping(value = "/updateNews.action", method = RequestMethod.POST, produces = "text/xml;charset=UTF-8")
	@ResponseBody
	public String  updateNews(@RequestParam(value="newsId") String newsId,@RequestParam(value="content") String content,@RequestParam(value="newsTitle") String newsTitle,@RequestParam(value="orgId") String orgId) {
		News news = new News(newsId,content,newsTitle, orgId);
		newsService.updateNews(news);
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
