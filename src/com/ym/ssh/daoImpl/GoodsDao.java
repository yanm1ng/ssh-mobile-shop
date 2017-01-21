package com.ym.ssh.daoImpl;

import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.ym.ssh.beans.Goods;

public class GoodsDao extends HibernateDaoSupport{
	
	public List<Goods> getAll() throws HibernateException {
		List<Goods> goods = getHibernateTemplate().find("from Goods");  
        return goods;
	}

	public void insert(Goods goods) throws HibernateException {
		getHibernateTemplate().save(goods);
	}
	
	public Goods getById(String goodsId) throws HibernateException {
	
		int id = Integer.parseInt(goodsId);
		List<Goods> goods = getHibernateTemplate().find("from Goods where goodsId=?", id);
		Goods find_goods = goods.get(0);
        return find_goods;
	}
	
	public List<Goods> getByBrand(String brand) throws HibernateException {
		
		List<Goods> goods = getHibernateTemplate().find("from Goods where brand=?", brand);
        return goods;
	}
	
	public void deleteById(String goodsId) throws HibernateException {
		int id = Integer.parseInt(goodsId);
		List<Goods> goods = getHibernateTemplate().find("from Goods where goodsId=?", id);
		Goods find_goods = goods.get(0);
		if (find_goods != null) {
			find_goods.setName("该商品被删除");
            getHibernateTemplate().update(find_goods);
        }
	}
	
	public void update(Goods goods) throws HibernateException {
		getHibernateTemplate().update(goods);
	}
	
}
