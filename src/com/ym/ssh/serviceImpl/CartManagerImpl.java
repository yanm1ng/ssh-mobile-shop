package com.ym.ssh.serviceImpl;

import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.Cart;
import com.ym.ssh.daoImpl.CartDao;
import com.ym.ssh.service.CartManager;

public class CartManagerImpl implements CartManager {
	private CartDao dao;

	public void setDao(CartDao dao) {
		this.dao = dao;
	}
	
	public List<Cart> getUserCart(int userId) throws HibernateException {
		
		List<Cart> list = dao.getUserCart(userId);
		return list;
	}
	
	public void addUserCart(Cart cart) throws HibernateException {
		
		dao.addUserCart(cart);
	}
	
	public void deleteUserCart(int cartId) throws HibernateException {
		                                                  
		dao.deleteUserCart(cartId);
	}
		
	public void updateUserCart(Cart cart) throws HibernateException {
		
		dao.updateUserCart(cart);
	}
}
