package com.ym.ssh.serviceImpl;

import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.Message;
import com.ym.ssh.daoImpl.MessageDao;
import com.ym.ssh.service.MessageManager;

public class MessageManagerImpl implements MessageManager {
	
	private MessageDao dao;

	public void setDao(MessageDao dao) {
		this.dao = dao;
	}
	
	public void insert(Message message) throws HibernateException {
		dao.insert(message);
	}

	public List<Message> getAll() throws HibernateException {
		List<Message> messages = dao.getAll();
		return messages;
	}

}
