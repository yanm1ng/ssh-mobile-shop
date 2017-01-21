package com.ym.ssh.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.ym.ssh.beans.Message;
import com.ym.ssh.common.ResultJson;
import com.ym.ssh.service.MessageManager;

public class MessageAction extends ActionSupport{
	
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String userMessage;
	private MessageManager messageManager;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserMessage() {
		return userMessage;
	}
	public void UserMessage(String userMessage) {
		this.userMessage = userMessage;
	}
	public MessageManager getMessageManager() {
		return messageManager;
	}
	public void setMessageManager(MessageManager messageManager) {
		this.messageManager = messageManager;
	}
	
	public String getAllMessage() {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("admin")!=null) {
			List<Message> messages = messageManager.getAll();
			map.put("status","success");
			map.put("data",messages);
		} else {
			map.put("status","error");
			map.put("msg","请先进行登录操作");
		}
		
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String addMessage() {
		Map<String, Object> map = new HashMap<String, Object>();
		Message message = new Message(name, userMessage);
		messageManager.insert(message);
		map.put("status","success");
		map.put("msg","提交成功，感谢你的反馈");
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
}
