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
    <script src="../js/echarts.min.js"></script>
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
		<div id="main" style="width: 800px;height:400px;margin:10px auto;"></div>
	</div>
</body>
<script>
	$(document).ready(function(){
		var myChart = echarts.init(document.getElementById('main'));
        // 指定图表的配置项和数据
		$.post("./orderAction!getAllOrder.action", {}, function(res, status){
			if(res.status == "success"){
				console.log(res);
				var timeArray = [];
				var timeObj = {};
				for(var i=0; i<res.data.length; i++){
					var temp = res.data[i];
					var time = temp.orderTime.slice(0, 10);
					timeArray.push(time);
					if(timeObj[time] == undefined){
						timeObj[time] = temp.allSum;
					}else{
						timeObj[time] += temp.allSum;
					}
				}
				var dataArray = [];
				for(var key in timeObj){
					dataArray.push(timeObj[key]);
				}
				var option = {
			            title: {
			                text: 'MobileShop 销售量'
			            },
			            tooltip: {},
			            legend: {
			                data:['销量']
			            },
			            xAxis: {
			                data: timeArray
			            },
			            yAxis: {},
			            series: [{
			                name: '销量',
			                type: 'bar',
			                data: dataArray
			            }]
			        };
			        myChart.setOption(option);
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