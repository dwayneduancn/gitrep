<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>中国光大银行--南京分行</title>

<script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>

<link rel="stylesheet" type="text/css" href="../css/reset.css" />
<link rel="stylesheet" type="text/css" href="../css/text.css" />
<link rel="stylesheet" type="text/css" href="../css/960_24.css" />
<link rel="stylesheet" type="text/css" href="../css/ceb.css" />

<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../themes/icon.css">
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>

<script type="text/javascript">
	
</script>
</head>
<body>
	<div id="main_out">
		<div class="container_24">
			<!-- head begin -->
			<div id="head" class="container_24">
				<div id="logo" class="grid_18 alpha"></div>
				<div ID="search" class="grid_6 omega">
					<input type="text"><input type="button" value="搜索"
						onclick="alert('暂未实现')">
				</div>
			</div>
			<div class="clear"></div>
			<!-- head end -->

			<!-- nav begin -->
			<div id="nav" class="container_24">
				<ul>
					<li><div class="grid_4 prefix_2">
							<a href="#">首页</a>
						</div></li>
					<li><div class="grid_4">
							<a href="#">光大风采</a>
						</div></li>
					<li><div class="grid_4">
							<a href="#">热站链接</a>
						</div></li>
					<li><div class="grid_4">
							<a href="#">联系方式</a>
						</div></li>
					<li><div class="grid_4 suffix_2">
							<a href="#">规章制度</a>
						</div></li>
				</ul>
			</div>
			<div class="clear"></div>
			<!-- nav end -->

			<!-- noti begin -->
			<div id="noti" class="container_24">
				<div>通知功能</div>
			</div>
			<div class="clear"></div>
			<!-- noti end -->

			<!-- main content begin -->
			<div class="container_24">
				<!-- left menu begin -->
				<div class="grid_6 alpha">
					<div class="middle_l_inner">
						<h3 class="title_230">${deptname }</h3>
						<div id="fhbgs">
							<ul>
								<li><a href="#">重要通知</a></li>
								<li><a href="#">下载地带</a></li>
								<li><a href="#">操作指南</a></li>
								<li><a href="#">规章制度</a></li>
								<li><a href="#">技术交流</a></li>
								<li><a href="#">新产品推介</a></li>
							</ul>
						</div>
					</div>
					<div class="margin_t_10">
						<img alt="部门风采" src="<%=basePath %>/images/link_ad13.jpg">
					</div>
					<div class="middle_l_inner2">
						<h3 class="title_230">最近更新</h3>
						<div class="zjgx">
							<ul>
								<li><a href="#">关于召开总行前置系统业务应急演务应急演</a></li>
								<li><a href="#">关于对被强制关机的办公电脑进行务应急演</a></li>
								<li><a href="#">关于对被强制关机的办公电脑进行务应急演</a></li>
								<li><a href="#">UC申请表</a></li>
								<li><a href="#">关于今天下班后暂停OA系统服务的</a></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- left menu end -->

				<!-- right content begin -->
				
				<div class="grid_18 omega">
					<div class="grid_18 omega">
						<div class="a_tab">
							<a href="#">重要公告</a>
							<a class="more" href="#">更多...</a>
						</div>
						<div class="div_tab3">
							<div>
								<a href="">公告1</a>
							</div>
							<div>
								<a href="">公告2</a>
							</div>
						</div>
					</div>
					<div class="clear"></div>
					<!-- right content end -->
					
					<div class="grid_18 omega margin_t_10">
						<div class="a_tab">
							<a href="#">下载地带</a>
							<a class="more" href="#">更多...</a>
						</div>
						<div class="div_tab3">
							<div>
								<a href="">公告1</a>
							</div>
							<div>
								<a href="">公告2</a>
							</div>
						</div>
					</div>
					<div class="clear"></div>
					
					<div class="grid_18 omega margin_t_10">
						<div class="a_tab">
							<a href="#">操作指南</a>
							<a class="more" href="#">更多...</a>
						</div>
						<div class="div_tab3">
							<div>
								<a href="">公告1</a>
							</div>
							<div>
								<a href="">公告2</a>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			<div class="clear"></div>
			<!-- main content end -->

			<!-- footer begin -->
			<div id="footer" class="grid_16 footer">中国光大银行南京分行 版权所有 2014</div>
			<div class="clear"></div>
			<!-- footer end -->
		</div>
	</div>
</body>
</html>