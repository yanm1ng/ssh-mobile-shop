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
				<div class="col-lg-12">
					<div class="heading"><h1>联系我们</h1></div>
				</div>
				<div class="col-md-6" style="margin-bottom: 30px;">
					<div>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="你的名字" name="name" id="name"/>
						</div>
						<div class="form-group">
							<textarea class="form-control" placeholder="你的留言" name="message" id="message"></textarea>
						</div>
						<button type="submit" class="btn btn-1" onclick="addMessage()">立即留言</button>
					</div>
				</div>
				<div class="col-md-6">
					<p><span class="glyphicon glyphicon-home"></span> 浙江工业大学屏峰校区 3000009</p>
					<p><span class="glyphicon glyphicon-earphone"></span> +6221 888 888 90 , +6221 888 88891</p>
					<p><span class="glyphicon glyphicon-envelope"></span> info@yourdomain.com</p>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	function logout(){
		$.post("./userAction!logout.action", {}, function(res, status){
			if(res.status == "success"){
				alert("你已成功退出登录");
				window.location.href = "./index.jsp";
			}
		})
	}
	function addMessage(){
		var name = $("#name").val();
		var message = $("#message").val();
		var data = {
			name: name,
			userMessage: message
		}
		$.post("./messageAction!addMessage.action", data, function(res, status){
			alert(res.msg);
			window.location.reload();
		})
	}
</script>
</html>
