package com.njceb.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class FileUploaderController extends HttpServlet{
	protected final Logger logger = Logger
			.getLogger(FileUploaderController.class);


	/**
	* @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	*/
	private static final long serialVersionUID = 1L;
	private final String uploadLocation = "fileupload\\";

	@RequestMapping(value = "/fileUpload.action", method = RequestMethod.POST)
	@ResponseBody
	public String upload(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获取前台传值
		String[] userNames = multipartRequest.getParameterValues("userName");
		String[] contents = multipartRequest.getParameterValues("content");
		String userName = "";
		String content = "";
		if (userNames != null) {
			userName = userNames[0];
			System.out.println("userName:" + userName);
		}
		if (contents != null) {
			content = contents[0];
			System.out.println("content:" + content);
		}
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		// 上传到服务端的路径
		String ctxPath = request.getSession().getServletContext()
				.getRealPath("/pages")
				+ uploadLocation;
		System.out.println("ctxPath ="+ctxPath);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String ymd = sdf.format(new Date());

		String originalFileName = null;
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			// 上传文件名
			System.out.println("key: " + entity.getKey());
			System.out.println("value: " + entity.getValue());

			MultipartFile mf = entity.getValue();
			originalFileName = mf.getOriginalFilename();
			String fileExt = originalFileName.substring(
					originalFileName.lastIndexOf(".") + 1).toLowerCase();

			// new file name
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd_HHmmss");
			String newFileName = df.format(new Date()) + "_"
					+ Math.random() + "." + fileExt;

			String uploadFolder3 = ctxPath + uploadLocation + ymd + "/";
			File otherFile = new File(uploadFolder3);
			if (!otherFile.exists()) {
				otherFile.mkdirs();
			}
			String uploadFileLocation = uploadFolder3 + newFileName;
			if (this.htmlUpload(mf.getInputStream(), uploadFileLocation)) {
				System.out.println(" -------upload success");
				return uploadFileLocation;
			} else {
				System.out.println(" ------- other upload fail");
				return "file upload fail";
			}
		}
		return null;
	}

	/**
	* @Title: htmlUpload
	* @param @param inputStream	传进一个流
	* @param @param uploadFile		服务端输出的路径和文件名
	* @return boolean    返回类型
	* @throws
	*/
	private boolean htmlUpload(InputStream inputStream, String uploadFile) {
		try {
			byte[] buff = new byte[4096]; // 缓冲区
			FileOutputStream output = new FileOutputStream(uploadFile); // 输出流
			int bytecount = 1;
			while ((bytecount = inputStream.read(buff, 0, 4096)) != -1) { // 当input.read()方法，不能读取到字节流的时候，返回-1
				output.write(buff, 0, bytecount); // 写入字节到文件
			}
			output.flush();
			output.close();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	
}