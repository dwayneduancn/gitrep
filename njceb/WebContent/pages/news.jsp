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
	//��ȡǰһ��ҳ�洫�����Ĳ���
	
	$(document).ready(function(){
		(function ($) {
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }
        })(jQuery);
		var newsId=$.getUrlParam('newsid');
		
		//Ajax��ȡ���ű��⣬����
		$.post('/njceb/getNewsById.action',{'newsId':newsId},function(data){
			$('#newsTitle').text(data.newsTitle);
			$('#content').append(data.content);
		});
		
	});
	
</script>

	<style scoped="scoped">
		.textbox{
			height:20px;
			margin:0;
			padding:0 2px;
			box-sizing:content-box;
		}
		
	</style>
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

			<!-- main content begin -->
			<div class="container_24">
				<!--���ű���  -->
				<div id=newsTitle></div>
				
				<!--��������  -->
				<div id=content></div>
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