package com.njceb.controller;


import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 上传图片
 * <p>
 * 	为CKEDITOR定制的图片上传功能，后续可以扩展上传其他格式的文件
 *  上传的文件的基础路径为: ${apache.home}/${project.name}/${project.name}/pages/upload/img/${'yyyyMMdd'}/
 *  每个文件夹下最多500个文件
 * </p>
 * @author mikko
 *
 */
@Controller
@RequestMapping("/uploadimg.action")
public class ImageUploadController {
	protected final Logger logger = Logger
			.getLogger(ImageUploadController.class);


	/** ~~~ 上传文件的保存路径 */
	private static final String FILE_UPLOAD_DIR = "\\upload";
	/** ~~~ 上传文件的保存的下一级路径，标示存储类型 */
	private static final String FILE_UPLOAD_SUB_IMG_DIR = "\\img";
	/** ~~~ 每个上传子目录保存的文件的最大数目 */
	private static final int MAX_NUM_PER_UPLOAD_SUB_DIR = 500;
	/** ~~~ 上传文件的最大文件大小 */
	private static final long MAX_FILE_SIZE = 1024 * 1024 * 2;
	/** ~~~ 系统默认建立和使用的以时间字符串作为文件名称的时间格式*/
	private static final String DEFAULT_SUB_FOLDER_FORMAT_AUTO = "yyyyMMdd";
	/** ~~~ 这里扩充一下格式，防止手动建立的不统一*/
	private static final String DEFAULT_SUB_FOLDER_FORMAT_NO_AUTO = "yyyy-MM-dd";

	@RequestMapping(method = RequestMethod.GET)
	public void processUpload(HttpServletRequest request,
			HttpServletResponse response) {
		processUploadPost( request, response);
		return;
	}

	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public void processUploadPost(HttpServletRequest request, HttpServletResponse response) {

		// 判断提交的请求是否包含文件
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);

		if (!isMultipart) {
			return;
		}

		// 获取目录
		File floder = buildFolder(request);
		if (null == floder) {
			return;
		}

		try {
			response.setContentType("text/html; charset=UTF-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			// 上传文件的返回地址
			String fileUrl = "";

			FileItemFactory factory = new DiskFileItemFactory();

			ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
			servletFileUpload.setFileSizeMax(MAX_FILE_SIZE);

			@SuppressWarnings("unchecked")
			List<FileItem> fileitem = servletFileUpload.parseRequest(request);

			if (null == fileitem || 0 == fileitem.size()) {
				return;
			}

			Iterator<FileItem> fileitemIndex = fileitem.iterator();
			if (fileitemIndex.hasNext()) {
				FileItem file = fileitemIndex.next();

				if (file.isFormField()) {
					logger.error("上传文件非法！isFormField=true");
				}

				String fileClientName = getFileName(file.getName());
				String fileFix = fileClientName.substring(
						fileClientName.lastIndexOf(".") + 1);
				if (!fileFix.equalsIgnoreCase("jpg")
						&& !fileFix.equalsIgnoreCase("jpeg")
						&& !fileFix.equalsIgnoreCase("bmp")
						&& !fileFix.equalsIgnoreCase("gif")
						&& !fileFix.equalsIgnoreCase("png")) {
					logger.error("上传文件的格式错误=" + fileFix);
					return;
				}

				if (logger.isInfoEnabled()) {
					logger.info("开始上传文件:" + file.getName());
				}

				// 为了客户端已经设置好了图片名称在服务器继续能够明确识别，这里不改名称
				File newfile = new File(floder, fileClientName);
				file.write(newfile);

				if (logger.isInfoEnabled()) {
					logger.info("上传文件结束，新名称:" + fileClientName + ".floder:"
							+ newfile.getPath());
				}

				// 组装返回url，以便于ckeditor定位图片
				fileUrl =  FILE_UPLOAD_DIR + FILE_UPLOAD_SUB_IMG_DIR + File.separator+floder.getName()+ File.separator + newfile.getName();
				fileUrl = fileUrl.substring(1);// 去掉第一个/，否则ckeditor不识别
				fileUrl = fileUrl.replace("\\", "/");
				System.out.println("fileUrl="+fileUrl);
				// 将上传的图片的url返回给ckeditor
				String callback = request.getParameter("CKEditorFuncNum");
				out.println("<script type=\"text/javascript\">");
				out.println("window.parent.CKEDITOR.tools.callFunction("
						+ callback + ",'" + fileUrl + "',''" + ")");
				out.println("</script>");
			}

			out.flush();
			out.close();

		} catch (IOException e) {
			logger.error("上传文件发生异常！", e);
		} catch (FileUploadException e) {
			logger.error("上传文件发生异常！", e);
		} catch (Exception e) {
			logger.error("上传文件发生异常！", e);
		}

		return;
	}
		
	/**
	 * 获取文件名称
	 * @param str
	 * @return
	 */
	private String getFileName(String str){
		int index = str.lastIndexOf("//");
		if(-1 != index){
			return str.substring(index);
		} else {
			return str;
		}
	}

	/**
	 * 创建目录
	 * 
	 * @return
	 */
	private File buildFolder(HttpServletRequest request) {
		
		String realPath = request.getSession().getServletContext()
				.getRealPath("/pages/");

		
//		logger.error(realPath);

		// 一级目录，如果不存在，创建
		File firstFolder = new File(realPath + FILE_UPLOAD_DIR);
		if (!firstFolder.exists()) {
			if (!firstFolder.mkdirs()) {
				return null;
			}
		}

		// 二级目录，如果不存在，创建
		String folderdir = realPath + FILE_UPLOAD_DIR + FILE_UPLOAD_SUB_IMG_DIR;
		System.out.println("folderdir="+folderdir);
		if (logger.isDebugEnabled()) {
			logger.debug("folderdir" + folderdir);
		}

		if (folderdir.equals("")||folderdir==null) {
			logger.error("路径错误:" + folderdir);
			return null;
		}

		File floder = new File(folderdir);
		if (!floder.exists()) {
			if (!floder.mkdirs()) {
				logger.error("创建文件夹出错！path=" + folderdir);
				return null;
			}

		}
		// 再往下的文件夹都是以时间字符串来命名的，所以获取最新时间的文件夹即可
		String[] files = floder.list();
		if (null != files && 0 < files.length) {
			// 含有子文件夹，则获取最新的一个
			Date oldDate = null;
			int index = -1;
			for (int i = 0; i < files.length; i++) {
				String fileName = files[i];

				try {
					Date thisDate = DateUtils.parseDate(fileName, new String[] {
							DEFAULT_SUB_FOLDER_FORMAT_AUTO, DEFAULT_SUB_FOLDER_FORMAT_NO_AUTO });
					if (oldDate == null) {
						oldDate = thisDate;
						index = i;
					} else {
						if (thisDate.after(oldDate)) {
							// 保存最新的时间和数组中的下标
							oldDate = thisDate;
							index = i;
						}
					}
				} catch (ParseException e) {
					// 这里异常吃掉，不用做什么，如果解析失败，会建立新的文件夹，防止人为的建立文件夹导致的异常。
				}
			}// for

			// 判断当前最新的文件夹下是否已经存在了最大数目的图片
			if (null != oldDate && -1 != index) {
				File pointfloder = new File(folderdir + File.separator
						+ files[index]);
				if (!pointfloder.exists()) {
					if (!pointfloder.mkdir()) {
						logger.error("创建文件夹出错！path=" + folderdir);
						return null;
					}
				}

				// 如果文件夹下的文件超过了最大值，那么也需要新建一个文件夹
				String[] pointfloderFiles = pointfloder.list();
				if (null != pointfloderFiles
						&& MAX_NUM_PER_UPLOAD_SUB_DIR < pointfloderFiles.length) {
					return buildNewFile(folderdir);
				}

				return pointfloder;
			}
			
			// 查找当前子文件夹失败，新建一个
			return buildNewFile(folderdir);
		} else {
			// 不含有子文件夹，新建一个，通常系统首次上传会有这个情况
			return buildNewFile(folderdir);
		}

	}
	
	/**
	 * 创建一个新文件
	 * @param path
	 * @return
	 */
	private File buildNewFile(String path){
		// 不含有子文件夹，新建一个，通常系统首次上传会有这个情况
		File newFile = buildFileBySysTime(path);
		if (null == newFile) {
			logger.error("创建文件夹失败！newFile=" + newFile);
		}

		return newFile;
	}

	/**
	 * 根据当前的时间建立文件夹，时间格式yyyyMMdd
	 * 
	 * @param path
	 * @return
	 */
	private File buildFileBySysTime(String path) {
		DateFormat df = new SimpleDateFormat(DEFAULT_SUB_FOLDER_FORMAT_AUTO);
		String fileName = df.format(new Date());
		File file = new File(path + File.separator + fileName);
		if (!file.mkdir()) {
			return null;
		}
		return file;
	}
}