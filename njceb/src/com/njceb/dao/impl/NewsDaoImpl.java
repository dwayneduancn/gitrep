package com.njceb.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.njceb.bean.News;
import com.njceb.dao.NewsDao;



@Repository
public class NewsDaoImpl extends BaseDaoImpl implements NewsDao {

	private static org.apache.log4j.Logger log = Logger
			.getLogger(NewsDaoImpl.class);

	@Override
	public List getNews(String pageNumString) {
		// 可能需要分页
		int pageNum = Integer.parseInt(pageNumString);
		int pageSize =10;
		int start = pageNum*pageSize;
		int end = (pageNum+1)*pageSize;
		String sql = "select * from  news where 1=1 LIMIT ?,?  " ;
		List list = jdbcTemplate.queryForList(sql,new Object[]{start,end});
		if(list == null || list.isEmpty()){
			return null;
		}else{
			return list;
		}
	}

	@Override
	public int updateNews(News news) {
		String sqlString  = "update news set newsTitle=?,dateTime=?,author=?,content=?,orgId=?," +
				" isPost=?,isTop=?,changeDateTime=?, appndFileName=?,appndFilePath=? where newsId=?";
		jdbcTemplate.update(sqlString,new Object[]{news.getNewsTitle(),news.getDateTime(),news.getAuthor(),
				news.getContent(),news.getOrgId(),news.getIsPost(),news.getIsTop(),news.getChangeDateTime(),
				news.getAppndFileName(),news.getAppndFilePath(),news.getNewsId()});
		return 0;
	}

	@Override
	public int delNews(String newsId) {
		String sqlString= "delete from news where newsId=?";
		jdbcTemplate.update(sqlString,new Object[]{newsId});
		return 0;
	}

	@Override
	public int addNews(News news) {
		String sql = "insert into news (newsTitle,dateTime,author,content,orgId,isPost,isTop,"
				+ "changeDateTime,appndFileName,appndFilePath) " +
				" values (?,?,?,?,?,?,?,?,?,?)";
		jdbcTemplate.update(sql, new Object[]{news.getNewsTitle(),news.getDateTime(),news.getAuthor(),
				news.getContent(),news.getOrgId(),news.getIsPost(),news.getIsTop(),news.getChangeDateTime(),
				news.getAppndFileName(),news.getAppndFilePath()});
		return 0;
		
	}
	
	protected class NewsRowMapper implements RowMapper<Object> {

		@Override
		public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			try {
				News news = new News(rs.getString("newsId"),rs.getString("newsTitle"),rs.getString("dateTime"),rs.getString("author"),
						rs.getString("content"),rs.getString("orgId"),rs.getString("isPost"),
						rs.getString("isTop"), rs.getString("changeDateTime"),rs.getString("appndFileName"),rs.getString("appndFilePath"));
				return news;
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}

			return null;
		}
	}

	@Override
	public Map<String, Object> getNewsById(String newsId) {
		String sqlString ="select * from news where newsId=?";
		Map<String, Object> map = jdbcTemplate.queryForMap(sqlString,new Object[]{newsId});
		return map;
	}

	@Override
	public int getTotalNewsCount() {
		String sql = "select count(*) from news where 1=1";
		int count = jdbcTemplate.queryForInt(sql);
		return count;
	}

	@Override
	public void setNewsToTop(String newsId) {
		String sqlString= "update news set isTop=?,changeDateTime=? where newsId=?";
		SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date =new Date();
		String dateString = sf.format(date);
		
		jdbcTemplate.update(sqlString,new Object[]{"1",dateString});
		
		
	}

}
