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
import com.njceb.service.OfficeAnnounceService;

@Controller
public class OfficeAnnounceController {

	private static org.apache.log4j.Logger log = Logger
			.getLogger(OfficeAnnounceController.class);

	@Autowired
	private OfficeAnnounceService officeAnnounceService;

	//@RequestMapping(value = "/queryNotification.action", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@RequestMapping(value = "/queryOfficeAnnounce.action", method = RequestMethod.POST)
	@ResponseBody
	public List queryOfficeAnnounce() {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss EE");
			//String userName = (String)session.getAttribute("LOGIN_USER");
			log.info("查询通知请求[" + df.format(new Date()) + "],USERNAME=[" + null + "]");
			List list = officeAnnounceService.getOfficeAnnounceList(null);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		
		return null;
	}
}
