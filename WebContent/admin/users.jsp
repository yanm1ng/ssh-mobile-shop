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
    <link rel="stylesheet" href="../css/bootstrap.min.css"  type="text/css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../font-awesome/css/font-awesome.min.css"  type="text/css">
    <link rel="stylesheet" href="../fonts/font-slider.css" type="text/css">
	<script src="../js/jquery-2.1.1.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</head>
<body>
	<nav id="top">
		<div class="container">
			<div class="row">
				<div class="col-xs-12">
					<ul class="top-link">
						 <s:if test="%{#session.admin==null}"> 
						     <li><a href="account.jsp"><span class="glyphicon glyphicon-user"></span> 管理员登录</a></li>
						 </s:if>
						 <s:elseif test="%{#session.admin!=null}"> 
						     <li><span class="glyphicon glyphicon-user"></span> 欢迎你, <s:property value="#session.admin"/><a onclick="logout()" style="cursor: pointer;"> 退出登录</a></li>
						 </s:elseif>
					</ul>
				</div>
			</div>
		</div>
	</nav>
	<header class="container">
		<div class="row">
			<div class="col-md-4">
				<div id="logo"><img src="../images/logo.png" /></div>
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
					<li><a href="index.jsp">全部商品</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">商品管理</a>
						<div class="dropdown-menu">
							<div class="dropdown-inner">
								<ul class="list-unstyled">
									<li><a href="add.jsp">添加商品</a></li>
									<li><a href="category.jsp?Apple">苹果</a></li>
									<li><a href="category.jsp?Samsung">三星</a></li>
									<li><a href="category.jsp?Xiaomi">小米</a></li>
									<li><a href="category.jsp?Meizu">魅族</a></li>
									<li><a href="category.jsp?Huawei">华为</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li><a href="users.jsp">用户管理</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">订单管理</a>
						<div class="dropdown-menu">
							<div class="dropdown-inner">
								<ul class="list-unstyled">
									<li><a href="orderlist.jsp">所有订单</a></li>
									<li><a href="orderchart.jsp">订单图表</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li><a href="view.jsp">查看留言</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div id="page-content" class="single-page">
		<div class="container" id="cart-container">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>用户ID</th>
				        <th>用户名</th>
				        <th>手机号</th>
			            <th>地址</th>
		    	        <th>操作</th>
					</tr>
				</thead>
				<tbody id="user-body"></tbody>
			</table>
		</div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabel">用户密码修改</h4>
	            </div>
	            <div class="modal-body">
	           		<p class="bg-danger" style="padding: 6px; display: none;" id="pwd-msg"></p>
	           		<input type="hidden" id="user-id">
					<div class="form-group">
						<input type="password" class="form-control" placeholder="新密码" id="new_password">
				 	</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="重复新密码" id="rep_password">
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
	function userList(id, name, phone, address){
		return (
			'<tr>'+
				'<td>'+id+'</td>'+
				'<td>'+name+'</td>'+
				'<td>'+phone+'</td>'+
				'<td>'+address+'</td>'+
				'<td style="width: 20%;">'+
					'<button class="btn btn-primary" onclick="setUser('+id+')" style="margin-right: 15px;">修改密码</button>'+
					'<button class="btn btn-danger" onclick="deleteUser('+id+')">删除</button>'+
				'</td>'+
			'</tr>'
		);
	}
	
	function setUser(id){
		$("#myModal").modal("show");
		$("#user-id").val(id);
	}
	
	function confirmInfo(){
		var new_password = $("#new_password").val();
		var rep_password = $("#rep_password").val();
		var user_id = $("#user-id").val();
		var data = {
			password: new_password,
			repassword: rep_password,
			userId: user_id
		}
		$.post("./adminAction!manageUser.action", data, function(res, status){
			if(res.status == "success"){
				$("#pwd-msg").text(res.msg);
				$("#pwd-msg").show();
				setTimeout(function(){
					$("#myModal").modal("hide");
					window.location.reload();
				}, 1000);
			}else{
				$("#pwd-msg").text(res.msg);
				$("#pwd-msg").show();
			}
		})
	}
	
	function deleteUser(id){
		var data = {
			userId: id
		}
		$.post("./adminAction!deleteUser.action", data, function(res, status){
			alert(res.msg);
			window.location.reload();
		})
	}
	
	$(document).ready(function(){
		$.post("./adminAction!getAllUser.action", {}, function(res, status){
			if(res.status == "success"){
				for(var i=0; i<res.data.length; i++){
					var temp = res.data[i];
					$("#user-body").append(userList(temp.userId, temp.username, temp.phone, temp.address));
				}
			}else{
				alert(res.msg);
			}
		})
	});
</script>
</html>