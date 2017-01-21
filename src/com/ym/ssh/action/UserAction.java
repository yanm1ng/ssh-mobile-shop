package com.ym.ssh.action;


import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.ym.ssh.beans.Cart;
import com.ym.ssh.beans.User;
import com.ym.ssh.common.ResultJson;
import com.ym.ssh.service.CartManager;
import com.ym.ssh.service.UserManager;

public class UserAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	private String username;
	private String password;
	private String phone;
	private String address;
	private String newPassword;
	
	private UserManager userManager;
	private CartManager cartManager;

	public CartManager getCartManager() {
		return cartManager;
	}

	public void setCartManager(CartManager cartManager) {
		this.cartManager = cartManager;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public UserManager getUserManager() {
		return userManager;
	}

	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String login() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		User user = new User(username, password);
		
		if(userManager.isUser(user) != null){
			User findUser = userManager.isUser(user);
			if(findUser.getPassword().equals(password)){
				List<Cart> carts = cartManager.getUserCart(findUser.getUserId());
				map.put("status", "success");
				map.put("msg", "登录成功");
				session.setAttribute("cart", carts);
				session.setAttribute("num", carts.size());
				session.setAttribute("user", findUser);
			}else{
				map.put("status", "error");
				map.put("msg", "密码错误");
			}
		}else{
			map.put("status", "error");
			map.put("msg", "该用户不存在");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String logout() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		session.removeAttribute("user");
		session.removeAttribute("cart");
		session.removeAttribute("num");
		
		map.put("status", "success");
		map.put("msg", "退出成功");
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
	
	public static boolean checkMobile(String mobile){
        boolean flag = false;
        try{
        	Pattern regex = Pattern.compile("^(((13[0-9])|(17[0-9])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8})|(0\\d{2}-\\d{8})|(0\\d{3}-\\d{7})$");
            Matcher matcher = regex.matcher(mobile);
            flag = matcher.matches();
        }catch(Exception e){
            flag = false;
        }
        return flag;
    }

	public String register() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(username.length() > 25){
			map.put("status", "error");
			map.put("msg", "用户名太长");
		}else{
			if(password.length() < 6){
				map.put("status", "error");
				map.put("msg", "密码长度太短");
			}else{
				if(!checkMobile(phone)){
					map.put("status", "error");
					map.put("msg", "手机号格式不正确");
				}else{
					if(address.length() == 0){
						map.put("status", "error");
						map.put("msg", "请设置你的收货地址方便收到你的商品");
					}else{
						try {
							User find = new User(username, password);
							if(userManager.isUser(find) != null){
								map.put("status", "error");
								map.put("msg", "该用户名已存在");
							}else{
								User user = new User(username, password, phone, address);
								userManager.regUser(user);
								map.put("status", "success");
								map.put("msg", "注册成功");
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String setUserPassword(){
		Map<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		if(user != null) {
			if(password.equals(user.getPassword())){
				if(newPassword.length() < 6) {
					map.put("status", "error");
					map.put("msg", "新密码长度太短");
				} else {
					user.setPassword(newPassword);
					userManager.update(user);
					session.setAttribute("user", user);
					map.put("status", "success");
					map.put("msg", "更新成功");
				}
			} else {
				map.put("status", "error");
				map.put("msg", "密码错误");
			}
		} else {
			map.put("status", "error");
			map.put("msg", "请先进行登录操作");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String setUserInfo() {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		if(user != null) {
			if(checkMobile(phone)){
				user.setPhone(phone);
				if(address.length() == 0) {
				
				} else {
					user.setAddress(address);
				}
				userManager.update(user);
				session.setAttribute("user", user);
				map.put("status", "success");
				map.put("msg", "更新成功");
			} else {
				map.put("status", "error");
				map.put("msg", "手机号格式不正确");
			}
		} else {
			map.put("status", "error");
			map.put("msg", "请先进行登录操作");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
}
