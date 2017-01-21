<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mobile Shop</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"  type="text/css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css"  type="text/css">
    <link rel="stylesheet" href="fonts/font-slider.css" type="text/css">
	<script src="js/jquery-2.1.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
	<nav id="top">
		<div class="container">
			<div class="row">
				<div class="col-xs-12">
					<ul class="top-link">
						 <s:if test="%{#session.user==null}"> 
						     <li><a href="account.jsp"><span class="glyphicon glyphicon-user"></span> 登录/注册</a></li>
						 </s:if>
						 <s:elseif test="%{#session.user!=null}"> 
						     <li><span class="glyphicon glyphicon-user"></span> 欢迎你, <s:property value="#session.user.username"/><a onclick="logout()" style="cursor: pointer;"> 退出登录</a></li>
						     <li><a href="account.jsp"><span class="glyphicon glyphicon-star"></span> 设置</a></li>
						 </s:elseif>
						 <li><a href="contact.jsp"><span class="glyphicon glyphicon-envelope"></span> 联系我们</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
	<header class="container">
		<div class="row">
			<div class="col-md-4">
				<div id="logo"><img src="images/logo.png" /></div>
			</div>
			<div class="col-md-8">
				<s:if test="%{#session.num==null}"> 
					<div id="cart"><a class="btn btn-1" href="cart.jsp" style="padding: 5px 16px;"><span class="glyphicon glyphicon-shopping-cart"></span> 0 ITEM</a></div>
				</s:if>
				<s:elseif test="%{#session.num!=null}">
					<div id="cart"><a class="btn btn-1" href="cart.jsp" style="padding: 5px 16px;"><span class="glyphicon glyphicon-shopping-cart"></span> <span id="cart-num"><s:property value="#session.num"/> ITEM</span></a></div>
				</s:elseif>
			</div>
		</div>
	</header>
    <nav id="menu" class="navbar">
		<div class="container">
			<div class="navbar-header"><span id="heading" class="visible-xs">菜单</span>
			  <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
			</div>
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav">
					<li><a href="index.jsp">首页</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">手机分类</a>
						<div class="dropdown-menu">
							<div class="dropdown-inner">
								<ul class="list-unstyled">
									<li><a href="category.jsp?Apple">苹果</a></li>
									<li><a href="category.jsp?Samsung">三星</a></li>
									<li><a href="category.jsp?Xiaomi">小米</a></li>
									<li><a href="category.jsp?Meizu">魅族</a></li>
									<li><a href="category.jsp?Huawei">华为</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li><a href="order.jsp">我的订单</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div id="page-content" class="single-page">
		<div class="container">
			<div class="row">
				<s:if test="%{#session.user==null}"> 
					<div class="col-md-6">
						<div class="heading"><h2>登录</h2></div>
						<div>
							<p class="bg-danger" style="padding: 6px; display: none;" id="login-msg"></p>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="用户名" id="log_username">
							</div>
							<div class="form-group">
								<input type="password" class="form-control" placeholder="密码" id="log_password">
							</div>
							<button class="btn btn-2" onclick="login()">登录</button>
						</div>
					</div>
					<div class="col-md-6">
						<div class="heading"><h2>新用户？</h2></div>
						<div>
							<p class="bg-danger" style="padding: 6px; display: none;" id="regiser-msg"></p>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="用户名" id="reg_username">
							</div>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="手机号" id="reg_phone">
							</div>
							<div class="form-group">
								<input type="password" class="form-control" placeholder="密码" id="reg_password">
							</div>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="收货地址" id="address">
							</div>
							<button class="btn btn-2" onclick="register()">立即注册</button>
						</div>
					</div>
				</s:if>
				<s:elseif test="%{#session.user!=null}">
					<div class="heading"><h2>个人信息</h2></div>
					<div>
						<p style="float: right;">
							<a style="cursor: pointer;" onclick="setPwd()">修改密码</a>
							|
							<a style="cursor: pointer;" onclick="setInfo()">修改信息</a>
						</p>
						<div class="col-md-6">
							<p><span class="glyphicon glyphicon-user"></span> <s:property value="#session.user.username"/></p>
							<p><span class="glyphicon glyphicon-earphone"></span> <s:property value="#session.user.phone"/></p>
							<p><span class="glyphicon glyphicon-home"></span> <s:property value="#session.user.address"/></p>
						</div>
					</div>
				</s:elseif>
			</div>
		</div>
	</div>
	<div class="modal fade" id="pwdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabel">用户密码修改</h4>
	            </div>
	            <div class="modal-body">
	            	<div>
						<p class="bg-danger" style="padding: 6px; display: none;" id="pwd-msg"></p>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="原密码" id="old_password">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="新密码" id="new_password">
						</div>
					</div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	                <button type="button" class="btn btn-primary" onclick="confirmPwd()">确定修改</button>
	            </div>
	        </div>
	    </div>
	</div>
	<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabel">用户信息修改</h4>
	            </div>
	            <div class="modal-body">
	            	<div>
						<p class="bg-danger" style="padding: 6px; display: none;" id="info-msg"></p>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="新手机" id="new_phone">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="新收货地址" id="new_address">
						</div>
					</div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	                <button type="button" class="btn btn-primary" onclick="confirmInfo()">确定修改</button>
	            </div>
	        </div>
	    </div>
	</div>
</body>
<script>
	function confirmPwd(){
		var old_password = $("#old_password").val();
		var new_password = $("#new_password").val();
		var data = {
			password: old_password,
			newPassword: new_password
		}
		$.post("./userAction!setUserPassword.action", data, function(res, status){
			if(res.status == "success"){
				$("#pwd-msg").text(res.msg);
				$("#pwd-msg").show();
				setTimeout(function(){
					$("#pwdModal").modal("hide");
					window.location.reload();
				}, 1000);
			}else{
				$("#pwd-msg").text(res.msg);
				$("#pwd-msg").show();
			}
		})
	}
	
	function confirmInfo(){
		var new_phone = $("#new_phone").val();
		var new_address = $("#new_address").val();
		var data = {
			phone: new_phone,
			address: new_address
		}
		$.post("./userAction!setUserInfo.action", data, function(res, status){
			if(res.status == "success"){
				$("#info-msg").text(res.msg+",对话框1s后关闭");
				$("#info-msg").show();
				setTimeout(function(){
					$("#infoModal").modal("hide");
					window.location.reload();
				}, 1000);
			}else{
				$("#info-msg").text(res.msg);
				$("#info-msg").show();
			}
		})
	}
	
	function setPwd(){
		$("#pwdModal").modal("show");
	}
	
	function setInfo(){
		$("#infoModal").modal("show");
	}
	
	function login(){
		var username = $("#log_username").val();
		var password = $("#log_password").val();
		var data = {
			username: username,
			password: password
		};
		$.post("./userAction!login.action", data, function(res, status){
			if(res.status == "success"){
				window.location.href = "./index.jsp";
			}else{				
				$("#login-msg").text(res.msg);
				$("#login-msg").show();
			}
		})
	}
	function register(){
		var username = $("#reg_username").val();
		var phone = $("#reg_phone").val();
		var password = $("#reg_password").val();
		var address = $("#address").val();
		var data = {
			username: username,
			password: password,
			phone: phone,
			address: address
		};
		$.post("./userAction!register.action", data, function(res, status){
			$("#regiser-msg").text(res.msg);
			$("#regiser-msg").show();
		})
	}
	function logout(){
		$.post("./userAction!logout.action", {}, function(res, status){
			if(res.status == "success"){
				alert("你已成功退出登录");
				window.location.href = "./index.jsp";
			}
		})
	}
</script>
</html>