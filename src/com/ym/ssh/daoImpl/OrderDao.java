package com.ym.ssh.daoImpl;

import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.ym.ssh.beans.Order;

public class OrderDao extends HibernateDaoSupport {
	
	public Order addOrder(Order order) throws HibernateException {
		
		getHibernateTemplate().save(order);
		getHibernateTemplate().flush();
		return order;
	}
	
	public List<Order> getUserOrder(int userId) throws HibernateException {
		
		Integer id = new Integer(userId);
		
		List<Order> orders = getHibernateTemplate().find("from Order where userId=?", id);  
        if (orders.size() > 0) {
            return orders;
        }
        return null;
	}
	
	public List<Order> getAllOrder() throws HibernateException {
		List<Order> orders = getHibernateTemplate().find("from Order");
		
		return orders;
	}
	
	public void setOrderStatus(int orderId, String status) throws HibernateException {
		Integer id = new Integer(orderId);
		List<Order> orders = getHibernateTemplate().find("from Order where orderId=?", id);
		if (orders.size() > 0) {
            Order order = orders.get(0);
            order.setStatus(status);
            getHibernateTemplate().update(order);
        }
	}
	
}
