<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>新闻管理</title>
	<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../themes/icon.css">
	<script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
	<script>
		$(function(){
			$('#newsTable').datagrid({
				title:'新闻信息',
				iconCls:'icon-save',
				width:700,
				height:350,
				nowrap: true,
				autoRowHeight: false,
				striped: true,
				collapsible:true,
				url:'../getNewsListForConsole.action',
				sortName: 'changeDateTime',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'newsId',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {title:'新闻ID',field:'newsId',width:80,sortable:true}
				]],
				columns:[[
			        {title:'新闻信息',colspan:3},
					{field:'opt',title:'操作',width:100,align:'center', rowspan:2,
						formatter:function(value,rec){
							return '<span style="color:red"><a id="modify">修改</a>  置顶  删除</span>';
						}
					}
				],[
					{field:'newsTitle',title:'新闻标题',width:120},
					{field:'dateTime',title:'发布时间',width:220,rowspan:2,sortable:true,
						sorter:function(a,b){
							return (a>b?1:-1);
						}
					},
					{field:'changeDateTime',title:'修改时间',width:150,rowspan:2,sortable:true,
						sorter:function(a,b){
							return (a>b?1:-1);
						}
					},
					{field:'isPost',title:'发布状态',width:150,rowspan:2,
						formatter:function(value){
							if(value=="1"){
								return '<span style="color:green" >已发布</span>';
							}else{
								return '<span style="color:red" >未发布</span>';
							}
							
						}
					},
					{field:'author',title:'投稿人',width:150,rowspan:2
						
					}
				]],
				pagination:true,
				rownumbers:true,
				
			});
			var p = $('#newsTable').datagrid('getPager');
			$(p).pagination({
				onBeforeRefresh:function(){
					alert('before refresh');
				}
			});
		});
	</script>
</head>
<body>
	<table id="newsTable"></table>
	
</body>
</html>