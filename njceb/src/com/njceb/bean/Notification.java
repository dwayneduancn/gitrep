package com.njceb.bean;

import java.io.Serializable;

public class Notification implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2951797622396152948L;
	
	private String newsId;
	private String notiTitle;
	private String notiContent;
	private String notiDept;
	private String dateIssued;
	
	public Notification(){}
	
	public Notification(String newsId, String notiTitle, String notiContent, String notiDept, String dateIssued) {
		this.setNewsId(newsId);
		this.notiTitle = notiTitle;
		this.notiContent = notiContent;
		this.notiDept = notiDept;
		this.dateIssued = dateIssued;
	}

	public String getNotiTitle() {
		return notiTitle;
	}

	public void setNotiTitle(String notiTitle) {
		this.notiTitle = notiTitle;
	}

	public String getNotiContent() {
		return notiContent;
	}

	public void setNotiContent(String notiContent) {
		this.notiContent = notiContent;
	}

	public String getDateIssued() {
		return dateIssued;
	}

	public void setDateIssued(String dateIssued) {
		this.dateIssued = dateIssued;
	}

	public String getNotiDept() {
		return notiDept;
	}

	public void setNotiDept(String notiDept) {
		this.notiDept = notiDept;
	}

	public String getNewsId() {
		return newsId;
	}

	public void setNewsId(String newsId) {
		this.newsId = newsId;
	}
}
