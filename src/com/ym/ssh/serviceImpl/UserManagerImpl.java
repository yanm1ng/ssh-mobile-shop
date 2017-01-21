package com.ym.ssh.serviceImpl;

import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.User;
import com.ym.ssh.daoImpl.UserDao;
import com.ym.ssh.service.UserManager;

public class UserManagerImpl implements UserManager {

	private UserDao dao;

	public void setDao(UserDao dao) {
		this.dao = dao;
	}
	
	public List<User> getAll() throws HibernateException {
		List<User> list = dao.getAll();
		return list;
	}

	public void regUser(User user) throws HibernateException {
		dao.insert(user);
	}
	
	public void update(User user) throws HibernateException {
		dao.update(user);
	}
	
	public void delete(int userId) throws HibernateException {
		dao.delete(userId);
	}

	public User isUser(User user) throws HibernateException {
		return (User) dao.selectByName(user.getUsername());
	}
	
	public void manage(int userId, String password) throws HibernateException {
		
		dao.manage(userId, password);
	}

}
