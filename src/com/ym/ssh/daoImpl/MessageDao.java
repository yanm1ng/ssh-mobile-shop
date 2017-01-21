package com.ym.ssh.daoImpl;

import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.ym.ssh.beans.Message;

public class MessageDao extends HibernateDaoSupport{
	
	public void insert(Message message) throws HibernateException {
		System.out.println(message.getMessage());
		System.out.println(message.getTime());
		getHibernateTemplate().save(message);
	}
	
	public List<Message> getAll() throws HibernateException {
		
		List<Message> messages = getHibernateTemplate().find("from Message");  
		
		return messages;
	}
}
