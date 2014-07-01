package com.njceb.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.njceb.service.NotificationService;

@Controller
public class NotificationController {

	private static org.apache.log4j.Logger log = Logger
			.getLogger(NotificationController.class);

	@Autowired
	private NotificationService notificationService;

	//@RequestMapping(value = "/queryNotification.action", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@RequestMapping(value = "/queryNotification.action", method = RequestMethod.POST)
	@ResponseBody
	public List queryNotification() {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss EE");
			//String userName = (String)session.getAttribute("LOGIN_USER");
			log.info("查询通知请求[" + df.format(new Date()) + "],USERNAME=[" + null + "]");
			List list = notificationService.getNotificationList(null);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		
		return null;
	}

	//@RequestMapping(value = "/queryNotification.action", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@RequestMapping(value = "/queryImptNotiList.action", method = RequestMethod.POST)
	@ResponseBody
	public List queryImptNotiList() {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss EE");
			//String userName = (String)session.getAttribute("LOGIN_USER");
			log.info("查询通知请求[" + df.format(new Date()) + "],USERNAME=[" + null + "]");
			List list = notificationService.getNotificationList(null);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		
		return null;
	}
	
	@RequestMapping(value = "/queryNewsExprList.action", method = RequestMethod.POST)
	@ResponseBody
	public List queryNewsExprList() {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss EE");
			//String userName = (String)session.getAttribute("LOGIN_USER");
			log.info("查询通知请求[" + df.format(new Date()) + "],USERNAME=[" + null + "]");
			List list = notificationService.getNotificationList(null);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		
		return null;
	}
}
