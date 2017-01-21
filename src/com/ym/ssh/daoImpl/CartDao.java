package com.ym.ssh.daoImpl;

import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.ym.ssh.beans.Cart;

public class CartDao extends HibernateDaoSupport{
	
	public List<Cart> getUserCart(int userId) throws HibernateException {
		Integer id = new Integer(userId);
		List<Cart> carts = getHibernateTemplate().find("from Cart where userId=?", id);
        return carts;
	}

	
	public void addUserCart(Cart cart) throws HibernateException {
		int user_id = cart.getUserId();
		int goods_id = cart.getGoodsId();
		int goods_num = cart.getGoodsNum();
		
		List<Cart> carts = getHibernateTemplate().find("from Cart where userId=? and goodsId=?", new Integer[]{user_id, goods_id}); 
		
		if (carts.size() > 0) {
			//如果该商品已经在购物车里了,更新数量
			Cart findCart = carts.get(0);
			int oldNum = findCart.getGoodsNum();
			int newNum = oldNum + goods_num;
			
			findCart.setGoodsNum(newNum);
			getHibernateTemplate().update(findCart);
		}else{
			getHibernateTemplate().save(cart);
		}
	}
	
	public void updateUserCart(Cart cart) throws HibernateException {
		int user_id = cart.getUserId();
		int goods_id = cart.getGoodsId();
		int goods_num = cart.getGoodsNum();
		
		List<Cart> carts = getHibernateTemplate().find("from Cart where userId=? and goodsId=?", new Integer[]{user_id, goods_id}); 
		Cart findCart = carts.get(0);
		findCart.setGoodsNum(goods_num);
		getHibernateTemplate().update(findCart);
	}
	
	public void deleteUserCart(int cartId) throws HibernateException {
		
		Integer id = new Integer(cartId);
		
		List<Cart> list = getHibernateTemplate().find("from Cart where cartId=?", id);
		Cart cart = list.get(0);
		if(cart != null){
			getHibernateTemplate().delete(cart);
		}
	}
}
