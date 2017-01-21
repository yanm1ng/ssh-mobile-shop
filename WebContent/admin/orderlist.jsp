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
						<th>订单编号</th>
						<th>订单时间</th>
						<th>订单总额</th>
						<th>订单状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="order-body"></tbody>
			</table>
		</div>
	</div>
	<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabel">订单详情</h4>
	            </div>
	            <div class="modal-body">
	            	<table class="table">
					   <thead>
					      <tr>
					         <th>商品名</th>
					         <th>商品单价</th>
					         <th>商品数量</th>
					      </tr>
					   </thead>
					   <tbody id="details-body"></tbody>
					</table>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	            </div>
	        </div>
	    </div>
	</div>
	<div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabel">修改订单状态</h4>
	            </div>
	            <div class="modal-body">
	            	<p class="bg-danger" style="padding: 6px; display: none;" id="status-msg"></p>
	            	<div class="form-group" style="margin-top: 30px;">
	            		<input type="hidden" id="order-id" />
						<select class="form-control" id="order-status">
							<option value="0">待发货</option>
						  	<option value="1">配送中</option>
						  	<option value="2">待确认</option>
						 	<option value="3">已完成</option>
						</select>
					</div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	                <button type="button" class="btn btn-primary" onclick="confirmStatus()">确认修改</button>
	            </div>
	        </div>
	    </div>
	</div>
</body>
<script>
	function orderList(id, time, sum, status){
		var arr = ["待发货","配送中","待确认","已完成"];
		return (
			'<tr>'+
				'<td>'+id+'</td>'+
				'<td>'+time+'</td>'+
				'<td>￥'+sum+'</td>'+
				'<td>'+arr[status]+' <a style="cursor: pointer;color:red;" onclick="openStatus('+id+')">修改</a></td>'+
				'<td style="width: 20%;"><button class="btn btn-primary" onclick="openDetail('+id+')">查看订单详情</button></td>'+
			'</tr>'
		);
	}
	
	function openStatus(id){
		$("#order-id").val(id);
		$("#statusModal").modal("show");
	}
	
	function confirmStatus(){
		var orderId = $("#order-id").val();
		var orderStatus = $("#order-status").val();
		var data = {
			orderId: orderId,
			orderStatus: orderStatus
		}
		$.post("./adminAction!setOrderStatus.action", data, function(res, status){
			if(res.status == "success"){
				$("#status-msg").text(res.msg+",对话框1s后关闭");
				$("#status-msg").show();
				setTimeout(function(){
					$("#statusModal").modal("hide");
					window.location.reload();
				}, 1000);
			}else{
				$("#status-msg").text(res.msg);
				$("#status-msg").show();
			}
		})
	}
	
	function detailslist(name, price, num){
		return (
			'<tr>'+
				'<td>'+name+'</td>'+
				'<td>￥'+price+'</td>'+
				'<td>'+num+'</td>'+
			'</tr>'
		);
	}
	
	function openDetail(id){
		$("#details-body").empty();
		var data = {
			orderId: id	
		};
		$.post("./orderAction!getOrderDetails.action", data, function(res, status){
			if(res.status == "success"){
				for(var i=0; i<res.detailslist.length; i++){
					var details = res.detailslist[i];
					var goods = res.goodslist[i];
					$("#details-body").append(detailslist(goods.name, goods.price, details.goodsNum));
				}
			}else{
				$("#details-body").text("该订单没有内容");
			}
			$("#infoModal").modal("show");
		})
	}
	
	$(document).ready(function(){
		$.post("./orderAction!getAllOrder.action", {}, function(res, status){
			if(res.status == "success"){
				console.log(res);
				for(var i=0; i<res.data.length; i++){
					var temp = res.data[i];
					$("#order-body").append(orderList(temp.orderId, temp.orderTime, temp.allSum, temp.status));
				}
			}else{
				alert(res.msg);
			}
		})
	});
	
	function logout(){
		$.post("./adminAction!logout.action", {}, function(res, status){
			if(res.status == "success"){
				alert("你已成功退出登录");
				window.location.href = "./index.jsp";
			}
		})
	}
</script>
</html>