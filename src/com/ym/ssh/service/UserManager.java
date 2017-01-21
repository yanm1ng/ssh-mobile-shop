package com.ym.ssh.service;

import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.User;

public interface UserManager {
	
	public List<User> getAll() throws HibernateException;

	public void regUser(User user) throws HibernateException;
	
	public User isUser(User user) throws HibernateException;
	
	public void update(User user) throws HibernateException;
	
	public void delete(int userId) throws HibernateException;
	
	public void manage(int userId, String password) throws HibernateException;
}
