package com.ym.ssh.service;

import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.Cart;

public interface CartManager {
	
	public List<Cart> getUserCart(int userId) throws HibernateException;
	
	public void addUserCart(Cart cart) throws HibernateException;
	
	public void deleteUserCart(int cartId) throws HibernateException;
		
	public void updateUserCart(Cart cart) throws HibernateException;
}
