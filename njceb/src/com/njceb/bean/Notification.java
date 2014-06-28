package com.njceb.bean;

import java.io.Serializable;

public class Notification implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1232404735435250349L;
	
	private String notiTitle;
	private String notiContent;
	private String dateIssued;
	
	public Notification(){}
	
	public Notification(String notiTitle, String notiContent, String dateIssued) {
		this.notiTitle = notiTitle;
		this.notiContent = notiContent;
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
}
