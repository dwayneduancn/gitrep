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
<title>�й��������--�Ͼ�����</title>

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
					<input type="text"><input type="button" value="����"
						onclick="alert('��δʵ��')">
				</div>
			</div>
			<div class="clear"></div>
			<!-- head end -->

			<!-- nav begin -->
			<div id="nav" class="container_24">
				<ul>
					<li><div class="grid_4 prefix_2">
							<a href="#">��ҳ</a>
						</div></li>
					<li><div class="grid_4">
							<a href="#">�����</a>
						</div></li>
					<li><div class="grid_4">
							<a href="#">��վ����</a>
						</div></li>
					<li><div class="grid_4">
							<a href="#">��ϵ��ʽ</a>
						</div></li>
					<li><div class="grid_4 suffix_2">
							<a href="#">�����ƶ�</a>
						</div></li>
				</ul>
			</div>
			<div class="clear"></div>
			<!-- nav end -->

			<!-- noti begin -->
			<div id="noti" class="container_24">
				<div>֪ͨ����</div>
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
								<li><a href="#">��Ҫ֪ͨ</a></li>
								<li><a href="#">���صش�</a></li>
								<li><a href="#">����ָ��</a></li>
								<li><a href="#">�����ƶ�</a></li>
								<li><a href="#">��������</a></li>
								<li><a href="#">�²�Ʒ�ƽ�</a></li>
							</ul>
						</div>
					</div>
					<div class="margin_t_10">
						<img alt="���ŷ��" src="<%=basePath %>/images/link_ad13.jpg">
					</div>
					<div class="middle_l_inner2">
						<h3 class="title_230">�������</h3>
						<div class="zjgx">
							<ul>
								<li><a href="#">�����ٿ�����ǰ��ϵͳҵ��Ӧ������Ӧ����</a></li>
								<li><a href="#">���ڶԱ�ǿ�ƹػ��İ칫���Խ�����Ӧ����</a></li>
								<li><a href="#">���ڶԱ�ǿ�ƹػ��İ칫���Խ�����Ӧ����</a></li>
								<li><a href="#">UC�����</a></li>
								<li><a href="#">���ڽ����°����ͣOAϵͳ�����</a></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- left menu end -->

				<!-- right content begin -->
				
				<div class="grid_18 omega">
					<div class="grid_18 omega">
						<div class="a_tab">
							<a href="#">��Ҫ����</a>
							<a class="more" href="#">����...</a>
						</div>
						<div class="div_tab3">
							<div>
								<a href="">����1</a>
							</div>
							<div>
								<a href="">����2</a>
							</div>
						</div>
					</div>
					<div class="clear"></div>
					<!-- right content end -->
					
					<div class="grid_18 omega margin_t_10">
						<div class="a_tab">
							<a href="#">���صش�</a>
							<a class="more" href="#">����...</a>
						</div>
						<div class="div_tab3">
							<div>
								<a href="">����1</a>
							</div>
							<div>
								<a href="">����2</a>
							</div>
						</div>
					</div>
					<div class="clear"></div>
					
					<div class="grid_18 omega margin_t_10">
						<div class="a_tab">
							<a href="#">����ָ��</a>
							<a class="more" href="#">����...</a>
						</div>
						<div class="div_tab3">
							<div>
								<a href="">����1</a>
							</div>
							<div>
								<a href="">����2</a>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			<div class="clear"></div>
			<!-- main content end -->

			<!-- footer begin -->
			<div id="footer" class="grid_16 footer">�й���������Ͼ����� ��Ȩ���� 2014</div>
			<div class="clear"></div>
			<!-- footer end -->
		</div>
	</div>
</body>
</html>