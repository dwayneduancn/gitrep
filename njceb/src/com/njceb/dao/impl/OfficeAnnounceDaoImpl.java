package com.njceb.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.njceb.bean.Notification;
import com.njceb.dao.NotificationDao;
import com.njceb.dao.OfficeAnnounceDao;

@Repository
public class OfficeAnnounceDaoImpl extends BaseDaoImpl implements OfficeAnnounceDao {

	private static org.apache.log4j.Logger log = Logger
			.getLogger(OfficeAnnounceDaoImpl.class);
	
	@Override
	public List getOfficeAnnounceList(String userName) {
		// TODO Auto-generated method stub
		String sqlString = "select * from news where 1=1";
		List list = jdbcTemplate.query(sqlString, new OfficeAnnounceRowMapper());
		log.info(list==null?"NULL":list.size()+list.get(0).toString());
		return list;
	}

	protected class OfficeAnnounceRowMapper implements RowMapper {

		@Override
		public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			try {
				//Notification notification = new Notification(rs.getString("title"), rs.getString("content"), rs.getString("notidept"), rs.getString("dateIssued"));
				Notification notification = new Notification(String.valueOf(rs.getInt("newsid")), rs.getString("newstitle"), rs.getString("content"), rs.getString("orgid"), rs.getString("datetime"));
				return notification;
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
			return null;
		}
	}
}
