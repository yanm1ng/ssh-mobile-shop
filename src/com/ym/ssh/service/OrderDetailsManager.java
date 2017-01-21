package com.ym.ssh.service;

import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.OrderDetails;

public interface OrderDetailsManager {
	public void addOrderDetails(List<OrderDetails> detailslist) throws HibernateException;
	
	public List<OrderDetails> getOrderDetails(int orderId) throws HibernateException;
	
}
