package com.ym.ssh.serviceImpl;

import java.util.List;

import org.hibernate.HibernateException;

import com.ym.ssh.beans.Goods;
import com.ym.ssh.daoImpl.GoodsDao;
import com.ym.ssh.service.GoodsManager;

public class GoodsManagerImpl implements GoodsManager{
	private GoodsDao dao;

	public void setDao(GoodsDao dao) {
		this.dao = dao;
	}
	
	public List<Goods> getAll() throws HibernateException {
		List<Goods> list = dao.getAll();
		return list;
	}

	public void addGoods(Goods goods) throws HibernateException {
		
		dao.insert(goods);
	}
	
	public Goods getById(String goodsId) throws HibernateException {
		Goods goods = dao.getById(goodsId);
		return goods;
	}
	
	public List<Goods> getByBrand(String brand) throws HibernateException {
		List<Goods> goods = dao.getByBrand(brand);
		return goods;
	}
	
	public void deleteById(String goodsId) throws HibernateException {
		
		dao.deleteById(goodsId);
	}
	
	public void update(Goods goods) throws HibernateException {
		dao.update(goods);
	}
}
