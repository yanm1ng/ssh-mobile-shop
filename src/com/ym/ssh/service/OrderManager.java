package com.ym.ssh.service;

import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.Order;

public interface OrderManager {
	
	public Order addOrder(Order order) throws HibernateException;
	
	public List<Order> getUserOrder(int userId) throws HibernateException;
	
	public List<Order> getAllOrder() throws HibernateException;
	
	public void setOrderStatus(int orderId, String status) throws HibernateException;
}
