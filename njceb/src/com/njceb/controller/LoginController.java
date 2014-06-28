package com.njceb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.njceb.bean.UserInfo;
import com.njceb.service.UserInfoService;
import com.njceb.util.ValidateCode;

@Controller
public class LoginController {

	private static org.apache.log4j.Logger log = Logger
			.getLogger(LoginController.class);

	@Autowired
	private UserInfoService userInfoService;

	@RequestMapping(value = "/login.action", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String login(@RequestParam(value = "userName") String userName,
			@RequestParam(value = "passWord") String passWord,
			@RequestParam(value = "validateCode") String validateCode,
			HttpSession session) {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss EE");
			log.info("�յ���¼��֤����[" + df.format(new Date()) + "],USERNAME=["
					+ userName + "]");
			session.removeAttribute("LOGIN_USER");

			String validateC = (String) session.getAttribute("validateCode");
			log.info("validateC:[" + validateC + "];validateCode:["
					+ validateCode + "]");
			if (!validateC.equalsIgnoreCase(validateCode)) {
				return "LOGIN_ERROR:У���벻��ȷ";
			}

			// �����û�����ȡ���ݿ��б������Ϣ
			UserInfo userInfo = userInfoService.getUserInfo(userName);
			if (userInfo == null) {
				return "LOGIN_ERROR:�û�������ȷ";
			} else {
				if (passWord.equals(userInfo.getPassWord())) {
					session.setAttribute("LOGIN_USER", userInfo.getUserName()+";"+userInfo.getOrgName());
					String loginTime = df.format(new Date());
					log.info("USERNAME:[" + userInfo.getUserName() + "]��¼�ɹ�ʱ��:[" + loginTime + "]");
					session.removeAttribute("validateCode");
					return "LOGIN_SUCC:"+userName+";"+userInfo.getOrgName();
				} else {
					return "LOGIN_ERROR:���벻��ȷ";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			session.removeAttribute("LOGIN_USER");
			return "LOGIN_ERROR:ϵͳ�쳣";
		}
	}
	
	@RequestMapping(value = "/register.action", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String register(@RequestParam(value = "userName") String userName,
			@RequestParam(value = "passWord") String passWord,
			@RequestParam(value = "deptId") String deptId,
			HttpSession session) {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss EE");
			log.info("�յ�ע������[" + df.format(new Date()) + "],USERNAME=["
					+ userName + "]");

			// �����û�����ȡ���ݿ��б������Ϣ
			UserInfo userInfo = userInfoService.getUserInfo(userName);
			if (userInfo != null) {
				return "REGISTER_ERROR:���û���ע��";
			} else {
				userInfo = new UserInfo();
				userInfo.setUserName(userName);
				userInfo.setPassWord(passWord);
				userInfo.setOrgId(deptId);
				if(userInfoService.addUser(userInfo)==1){
					//session.removeAttribute("LOGIN_USER");
					//session.setAttribute("LOGIN_USER", userInfo.getUserName());
					return "REGISTER_SUCC:��ϲ��,"+userName+" ע��ɹ�!";
				} else {
					return "REGISTER_ERROR:ע���û�ʧ��";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			return "REGISTER_ERROR:ϵͳ�쳣";
		}
	}

	@RequestMapping(value = "/getValidateCode.action", method = RequestMethod.GET)
	public void getValidateCode(HttpServletRequest req, HttpServletResponse resp) {
		try {
			// ������Ӧ�����͸�ʽΪͼƬ��ʽ
			resp.setContentType("image/jpeg");
			// ��ֹͼ�񻺴档
			resp.setHeader("Pragma", "no-cache");
			resp.setHeader("Cache-Control", "no-cache");
			resp.setDateHeader("Expires", 0);

			HttpSession session = req.getSession();

			ValidateCode vCode = new ValidateCode(60, 18, 4, 20);
			session.setAttribute("validateCode", vCode.getCode());
			//log.info("��֤��Ϊ��[" + vCode.getCode() + "]");
			vCode.write(resp.getOutputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.error(e);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.error(e);
		}
	}

	@RequestMapping(value = "/checkValidateCode.action", method = RequestMethod.POST)
	public void checkValidateCode(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=GB18030");
		String validateC = (String) request.getSession().getAttribute(
				"validateCode");
		String veryCode = request.getParameter("c");
		log.info(veryCode);
		PrintWriter out = response.getWriter();
		if (veryCode == null || "".equals(veryCode)) {
			out.println("��֤��Ϊ��");
		} else {
			if (validateC.equalsIgnoreCase(veryCode)) {
				out.println("��֤����ȷ");
			} else {
				out.println("��֤�����");
			}
		}
		out.flush();
		out.close();
	}

	public static void main(String args[]) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss EE");
		String loginTime = df.format(new Date());
		log.info("==============��¼ʱ��===============[" + loginTime + "]");
	}
}
