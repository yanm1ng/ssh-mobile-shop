package com.ym.ssh.service;

import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.Message;

public interface MessageManager {
	
	public void insert(Message message) throws HibernateException;
	
	public List<Message> getAll() throws HibernateException;
	
}
