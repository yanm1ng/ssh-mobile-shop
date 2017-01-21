package com.ym.ssh.serviceImpl;

import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.OrderDetails;
import com.ym.ssh.daoImpl.OrderDetailsDao;
import com.ym.ssh.service.OrderDetailsManager;

public class OrderDetailsManagerImpl implements OrderDetailsManager {
	
	private OrderDetailsDao dao;
	
	public void setDao(OrderDetailsDao dao) {
		this.dao = dao;
	}

	public void addOrderDetails(List<OrderDetails> detailslist) throws HibernateException {
		Iterator<OrderDetails> it = detailslist.iterator();
		while(it.hasNext()) {
		    dao.addOrderDetails(it.next());
		}
	}
	
	public List<OrderDetails> getOrderDetails(int orderId) throws HibernateException {
		return dao.getOrderDetails(orderId);
	}

}
