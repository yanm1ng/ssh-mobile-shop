package com.ym.ssh.serviceImpl;

import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.Order;
import com.ym.ssh.daoImpl.OrderDao;
import com.ym.ssh.service.OrderManager;

public class OrderManagerImpl implements OrderManager {
	
	private OrderDao dao;

	public void setDao(OrderDao dao) {
		this.dao = dao;
	}

	public Order addOrder(Order order) throws HibernateException {
		return (Order)dao.addOrder(order);
	}
	
	public List<Order> getUserOrder(int userId) throws HibernateException {
		
		return dao.getUserOrder(userId);
	}
	
	public List<Order> getAllOrder() throws HibernateException {
		
		return dao.getAllOrder();
	}
	
	public void setOrderStatus(int orderId, String status) throws HibernateException {
		
		dao.setOrderStatus(orderId, status);
	}
}
