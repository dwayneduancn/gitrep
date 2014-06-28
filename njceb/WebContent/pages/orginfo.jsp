<%@ page language="java" contentType="text/html; charset=GB18030" pageEncoding="GB18030"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>������Ϣ</title>
<script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../css/zTreeStyle/zTreeStyle.css"/>
<script>
	var setting = {
	//	isSimpleData : true,              //�����Ƿ���ü� Array ��ʽ��Ĭ��false
		treeNodeKey : "id",               //��isSimpleData��ʽ�£���ǰ�ڵ�id����
		treeNodeParentKey : "pId",        //��isSimpleData��ʽ�£���ǰ�ڵ�ĸ��ڵ�id����
		rootPID :"0",
		showLine : true,                  //�Ƿ���ʾ�ڵ�������
	
		check: {
			enable: true,
			nocheckInherit: true
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};

	var zTree;
	//var treeNodes;
	

	$(function(){
		$.ajax({
			async : false,
			cache:false,
			type: 'POST',
			dataType : "json",
			url: "/njceb/doGetOrgTree.action",//�����action·��
			error: function () {//����ʧ�ܴ�����
				alert('����ʧ��');
			},
			success:function(data){ //����ɹ���������  
				//alert(data);
				
				treeNodes = data;   //�Ѻ�̨��װ�õļ�Json��ʽ����treeNodes
			}
		});

		// zTree = $("#tree").zTree(setting, treeNodes);  
	});
	
	$(document).ready(function(){
		var t = $("#tree");
		t = $.fn.zTree.init(t, setting, treeNodes);

	});

</script>
</head>
<body>
	<div>      
		<ul id="tree" class="ztree"></ul>       
	</div>   
</body>
</html>	