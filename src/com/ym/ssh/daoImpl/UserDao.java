package com.ym.ssh.daoImpl;

import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import com.ym.ssh.beans.User;

public class UserDao extends HibernateDaoSupport{
	
	public List<User> getAll() throws HibernateException {
		List<User> users = getHibernateTemplate().find("from User");  
        return users;
	}

	public void insert(User user) throws HibernateException {
		getHibernateTemplate().save(user);
	}
	
	public void delete(int userId) throws HibernateException {
		Integer id = new Integer(userId);
		
		List<User> users = getHibernateTemplate().find("from User where userId=?", id);
		User user = users.get(0);
		if(user != null){
			getHibernateTemplate().delete(user);
		}
	}
	
	public void manage(int userId, String password) throws HibernateException {
		Integer id = new Integer(userId);
		
		List<User> users = getHibernateTemplate().find("from User where userId=?", id);
		User user = users.get(0);
		if(user != null){
			user.setPassword(password);
			getHibernateTemplate().update(user);
		}
	}
	
	public void update(User user) throws HibernateException {
		getHibernateTemplate().update(user);
	}

	public User selectByName(String name) throws HibernateException {
		List<User> users = getHibernateTemplate().find("from User where username=?", name);  
        if (users.size() > 0) {
        	User user = users.get(0);
            return user;
        }
        return null;		
	}

}
