<%@ page language="java" contentType="text/html; charset=GB18030" pageEncoding="GB18030"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
	<title>��ɫ����</title>
	<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../demo/demo.css">
	<script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery.edatagrid.js"></script>
	<script type="text/javascript">
		$(function(){
			$('#dg').edatagrid({
				url: '../doGetRoleList.action',
				saveUrl: '../addRole.action',
				updateUrl: '../updateRole.action',
				destroyUrl: '../delRole.action'
			});
		});
	</script>
</head>
<body>
	<table id="dg" title="��ɫ��Ϣ" style="width:550px;height:250px"    
        toolbar="#toolbar"    
        rownumbers="false" fitColumns="true" singleSelect="true">
		<thead>
			<tr>
				<th field="roleId" width="100" >��ɫID</th>
				<th field="roleName" width="100" editor="{type:'validatebox',options:{required:true}}">��ɫ��</th>
				<th field="roleDesc" width="100" editor="text">��ɫ����</th>
			</tr>
		</thead>
	</table>
	
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:$('#dg').edatagrid('addRow')">����</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:$('#dg').edatagrid('destroyRow')">ɾ��</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#dg').edatagrid('saveRow')">����</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#dg').edatagrid('cancelRow')">ȡ��</a>
	</div>
	
</body>
</html>