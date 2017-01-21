package com.ym.ssh.service;

import java.util.List;
import org.hibernate.HibernateException;
import com.ym.ssh.beans.Goods;

public interface GoodsManager {
	public List<Goods> getAll() throws HibernateException;

	public void addGoods(Goods goods) throws HibernateException;
	
	public Goods getById(String goodsId) throws HibernateException;
	
	public List<Goods> getByBrand(String brand) throws HibernateException;
	
	public void deleteById(String goodsId) throws HibernateException;
	
	public void update(Goods goods) throws HibernateException;
}
