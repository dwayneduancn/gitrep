package com.njceb.dao;

import java.util.List;
import java.util.Map;

import com.njceb.bean.News;


public interface NewsDao {
	public List getNews(String pageNum);
	public int updateNews(News news);
	public int delNews(String newsId);
	public int addNews(News news);
	public Map<String, Object> getNewsById(String newsId);
	public int getTotalNewsCount();
	public void setNewsToTop(String newsId);
}
