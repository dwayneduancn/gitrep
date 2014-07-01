package com.njceb.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.njceb.dao.OfficeAnnounceDao;
import com.njceb.service.OfficeAnnounceService;

@Service
@Transactional(rollbackFor = Exception.class)
public class OfficeAnnounceServiceImpl implements OfficeAnnounceService {
	
	@Autowired
	private OfficeAnnounceDao officeAnnounceDao;
	
	@Override
	public List getOfficeAnnounceList(String userName) {
		// TODO Auto-generated method stub
		return officeAnnounceDao.getOfficeAnnounceList(userName);
	}
}
