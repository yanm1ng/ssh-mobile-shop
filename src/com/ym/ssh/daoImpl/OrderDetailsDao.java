package com.ym.ssh.daoImpl;

import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.ym.ssh.beans.OrderDetails;

public class OrderDetailsDao extends HibernateDaoSupport {
	
	public void addOrderDetails(OrderDetails orderdetails) throws HibernateException {
		
		getHibernateTemplate().save(orderdetails);
	}
	
	public List<OrderDetails> getOrderDetails(int orderId) throws HibernateException {
		
		Integer id = new Integer(orderId);
		
		List<OrderDetails> details = getHibernateTemplate().find("from OrderDetails where orderId=?", id);
        if (details.size() > 0) {
            return details;
        }
        return null;
	}
}
