<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>�й��������--�Ͼ�����</title>

<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/scrolltext.js"></script>

<link rel="stylesheet" type="text/css" href="css/reset.css" />
<link rel="stylesheet" type="text/css" href="css/text.css" />
<link rel="stylesheet" type="text/css" href="css/960_24.css" />
<link rel="stylesheet" type="text/css" href="css/ceb.css" />

<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="themes/icon.css">
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>

<script type="text/javascript">
	$(document).ready(
			function() {
				if ("${sessionScope.LOGIN_USER}" != null
						&& "${sessionScope.LOGIN_USER}" != '') {
					var data = "${sessionScope.LOGIN_USER}".toString();
					$("#login_form").hide();
					var login_user = data.substring(0, data.indexOf(';'));
					var dept_name = data.substring(data.indexOf(';') + 1);
					$('#login_user').text(login_user);
					$('#dept_name').text(dept_name);
					$('#login_succ').show();
				}

				//queryNoti();
				if ($('#jsfoot01')) {
					var scrollup = new ScrollText("jsfoot01");
					scrollup.LineHeight = 24; //�������ֹ����ĸ߶�
					scrollup.Amount = 1; //ע��:��ģ��(LineHeight)һ��Ҫ������Amount.
					scrollup.Delay = 20; //��ʱ
					scrollup.Start(); //�����Զ�����
					scrollup.Direction = "up"; //�������¹���
				}
			});

	function queryNoti() {
		$.ajax({
			async : false,
			cache : false,
			type : "post",//���ͷ�ʽ
			url : "/njceb/queryNotification.action",// ·��
			data : '',
			error : function() {//����ʧ�ܴ�����
				alert('����ʧ��');
			},
			success : function(result) {
				var data = eval('(' + result + ')');
				alert(data);
				if (data && data != null && data != '') {

				} else {
					alert("��¼�쳣�������µ�¼!");
				}
			}
		});
	}

	function changeImg() {
		var imgSrc = $("#imgObj");
		var src = imgSrc.attr("src");
		imgSrc.attr("src", chgUrl(src));
	}
	//ʱ���  
	//Ϊ��ʹÿ������ͼƬ��һ�£�����������������棬������Ҫ����ʱ���  
	function chgUrl(url) {
		var timestamp = (new Date()).valueOf();
		if ((url.indexOf("&") >= 0)) {
			url = url + "��tamp=" + timestamp;
		} else {
			url = url + "?timestamp=" + timestamp;
		}
		return url;
	}

	function login() {
		var username = $("input#userName").val();
		var password = $("input#passWord").val();
		var code = $("input#validateCode").val();
		if (username == '') {
			alert("�û�������Ϊ��");
			$("input#userName")[0].focus();
			return false;
		}
		if (password == '') {
			alert("���벻��Ϊ��");
			$("input#passWord")[0].focus();
			return false;
		}
		if (!code || code == '') {
			alert("��������֤��");
			$("input#validateCode")[0].focus();
			return false;
		} else if (code.length != 4) {
			alert("��֤��Ϊ��λ");
			$("input#validateCode")[0].focus();
			return false;
		}
		$.ajax({
			async : false,
			cache : false,
			type : "post",//���ͷ�ʽ
			url : chgUrl("/njceb/login.action"),// ·��
			data : "userName=" + username + "&passWord=" + password
					+ "&validateCode=" + code,
			error : function() {//����ʧ�ܴ�����
				alert('����ʧ��');
			},
			success : function(data) {
				//var data = eval('(' + result + ')');
				if (data && data != null && data != '') {
					if (data.indexOf('LOGIN_ERROR') > -1) {
						//��¼ʧ��
						var errMsg = data.substring(12);
						alert(errMsg);
						$("input#userName")[0].focus();
					} else if (data.indexOf('LOGIN_SUCC') > -1) {
						//��¼�ɹ�
						$("#login_form").hide();
						var login_user = data.substring(11, data.indexOf(';'));
						var dept_name = data.substring(data.indexOf(';') + 1);
						$('#login_user').text(login_user);
						$('#dept_name').text(dept_name);
						$('#login_succ').show();
					} else {
						alert(data);
						$("input#userName")[0].focus();
					}
				} else {
					alert("��¼�쳣�������µ�¼!");
					$("input#userName")[0].focus();
				}
			}
		});
	}

	function showregdiv() {
		$('#regform').form('clear');
		$('#register').dialog('open').dialog('setTitle', 'ע��');
	}

	function register() {
		if ($('#regform').form('validate')) {
			if ($('#rePass').val() != $('#regPass').val()) {
				$.messager.alert("�������������ʾ", "�����������벻һ�£����������룡", "error");
				$('input#regPass')[0].focus();
				return;
			}
			$.ajax({
				async : false,
				cache : false,
				type : "post",//���ͷ�ʽ
				url : chgUrl("/njceb/register.action"),// ·��
				data : "userName=" + $('#regName').val() + "&passWord="
						+ $('#regPass').val() + "&deptId="
						+ $('#deptId').combobox('getValue'),
				error : function() {//����ʧ�ܴ�����
					alert('����ʧ��');
				},
				success : function(data) {
					//var data = eval('(' + result + ')');
					if (data && data != null && data != '') {
						if (data.indexOf('REGISTER_ERROR') > -1) {
							//ע��ʧ��
							var errMsg = data.substring(15);
							$.messager.alert("ע��ʧ����ʾ", errMsg, "error");
							$("input#userName")[0].focus();
						} else if (data.indexOf('REGISTER_SUCC') > -1) {
							//��¼�ɹ�
							$.messager.alert("ע��ɹ���ʾ", data.substring(14),
									"info");
							$('#register').dialog('close');
							//��¼
						} else {
							$.messager.alert("ע��ʧ����ʾ", data, "error");
							$("input#regName")[0].focus();
						}
					} else {
						alert("���������������쳣��������ע��!");
						$("input#regName")[0].focus();
					}
				}
			});
		}
	}
</script>

<SCRIPT>
	//��ȡ�����tab�ǵڼ���
	function switchTab(t, con) {
		//��ȡtab�ĸ���
		var nums = $("#tab" + t).find("a");
		for (var i = 1; i <= nums.length; i++) {
			if (i == con) {
				$("#div_con" + t + "_" + i).show();
			} else {
				$("#div_con" + t + "_" + i).hide();
			}
		}
	}
</SCRIPT>

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
				<div>
					<strong>���¶�̬��</strong> <span>
						<ul id="jsfoot01" class="noticTipTxt">
							<li><a target="_blank" href="#" title="�����������е����е����ֽ�ȫ����ֹ���">2014-04-15
									�����������е����е����ֽ�ȫ����ֹ���</a></li>
							<li><a target="_blank" href="#" title="�����������е����е����ֽ�ȫ����ֹ���">2014-04-15
									�����������е����е����ֽ�ȫ����ֹ���</a></li>
						</ul>
					</span>
				</div>
			</div>
			<div class="clear"></div>
			<!-- noti end -->

			<!-- main content begin -->
			<div class="container_24">
				<!-- left menu begin -->
				<div class="grid_6 alpha">
					<div class="middle_l_div">
						<h3 class="title_230">��¼</h3>
						<div id="login_form">
							<form method="post">
								<table>
									<tr>
										<td style="text-align: center; width: 27%"><label>&nbsp;&nbsp;&nbsp;�û�����</label></td>
										<td style="text-align: left; width: 73%" colspan="3"><input
											size="20" id="userName" type="text" name="userName"></td>
									</tr>
									<tr>
										<td><label>&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;�룺</label></td>
										<td><input
											size="20" id="passWord" type="password" name="passWord"></td>
									</tr>
									<tr>
										<td><label>&nbsp;&nbsp;&nbsp;У���룺</label></td>
										<td><input size="5"
											type="text" id="validateCode" name="validateCode"></td>
										<td
											style="text-align: center; width: 25%; vertical-align: middle;"><img
											id="imgObj" alt="" src="/njceb/getValidateCode.action" /></td>
										<td
											style="text-align: center; width: 25%; vertical-align: middle;"><a
											href="#" onclick="changeImg()">��һ��</a></td>
									</tr>
									<tr>
										<td style="text-align: center; width: 100%" colspan="4">
											<input type="button" onclick="login()" value="��¼">&nbsp;
											<input type="reset" value="����">&nbsp; <a
											style="vertical-align: bottom;" href="#"
											onclick="showregdiv()">ע��</a>
										</td>
									</tr>
								</table>
							</form>
						</div>
						<div id="register"
							style="width: 400px; padding: 10px 60px 20px 60px"
							class="easyui-dialog" closed="true" buttons="#dlg-buttons">
							<div class="ftitle">ע����Ϣ�༭</div>
							<form method="post" id="regform">
								<table cellpadding="5">
									<tr>
										<td width="30%" align="right">�û���</td>
										<td width="70%" align="left"><input
											class="easyui-validatebox textbox"
											data-options="required:true,validType:'length[2,10]'"
											id="regName" name="regName"></td>
									</tr>
									<tr>
										<td>����</td>
										<td><input class="easyui-validatebox textbox"
											data-options="required:true,validType:'length[3,10]'"
											id="regPass" name="regPass"></td>
									</tr>
									<tr>
										<td>����һ��</td>
										<td><input class="easyui-validatebox textbox"
											data-options="required:true" id="rePass" name="rePass"></td>
									</tr>
									<tr>
										<td>����</td>
										<td><input class="easyui-combobox" id="deptId"
											name="deptId"
											data-options="required:'true',
												url:'/njceb/queryDeptInfoList.action',
												method:'post',
												valueField:'detpId',
												textField:'detpName',
												panelHeight:'auto'">
										</td>
									</tr>
								</table>
							</form>
						</div>
						<div id="dlg-buttons">
							<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
								onclick="register()">����</a> <a href="#"
								class="easyui-linkbutton" iconCls="icon-cancel"
								onclick="javascript:$('#register').dialog('close')">ȡ��</a>
						</div>
						<div ID="login_succ" style="display: none;">
							<label>��ӭ����&nbsp;</label><label id="login_user"></label>&nbsp;&nbsp;<label
								id="dept_name"></label> <br /> <a href="#">�����ҵ��ۺ��������ƽ̨</a> <br />
						</div>
					</div>
					<div class="middle_l_inner margin_t_10">
						<h3 class="title_230">��˾����</h3>
						<div id="fhbgs">
							<ul>
								<li><a href="#">���а칫��</a></li>
								<li><a href="#">������Դ</a></li>
								<li><a href="#">��˾ҵ��</a></li>
								<li><a href="#">С΢����</a></li>
								<li><a href="#">����ҵ��</a></li>
								<li><a href="#">��������</a></li>
								<li><a href="#">ó�׽���</a></li>
								<li><a href="#">ͬҵҵ��</a></li>
								<li><a href="#">��Ӫ����</a></li>
								<li><a href="#">�ƻ�����</a></li>
								<li><a href="#">���տ���</a></li>
								<li><a href="#">���Ź���</a></li>
								<li><a href="#">�ʲ���ȫ</a></li>
								<li><a href="#">���ɺϹ�</a></li>
								<li><a href="#">Ͷ��ҵ��</a></li>
								<li><a href="#">��Ϣ�Ƽ�</a></li>
							</ul>
						</div>
					</div>
					<div class="middle_r_inner">
						<h3 class="title_230">��������������</h3>
						<div id="elecbankdept">
							<span id="_ctl0_LblContent"> </span>
						</div>
					</div>
					<div class="middle_l_inner2">
						<h3 class="title_230">�ȵ�����</h3>
						<div class="rdlj">
							<ul>
								<li><a href="#">�ۺ��������ƽ̨</a></li>
								<li><a href="#">�����ⲿ��վ(����)</a></li>
								<li><a href="#">�����ڲ���վ</a></li>
								<li><a href="#">��������������</a></li>
								<li><a href="#">IAMͳһ�������ʹ���</a></li>
								<li><a href="#">OA�ۺϰ칫ϵͳ</a></li>
								<li><a href="#">���ж���ƽ̨</a></li>
								<li><a href="#">����ҵ��Ч����ϵͳ</a></li>
								<li><a href="#">������������Ӫ��ϵͳ</a></li>
								<li><a href="#">������ϵͳ</a></li>
								<li><a href="#">ͳ����Ϣ��ѯϵͳ</a></li>
								<li><a href="#">�Թ���������Ԥ��ϵͳ</a></li>
								<li><a href="#">�Ŵ�����ϵͳ��CECM��</a></li>
								<li><a href="#">�Թ�OCRM����ϵͳ</a></li>
								<li><a href="#">����ʻ�����ϵͳ</a></li>
								<li><a href="#">�����Ŵ�����ϵͳ</a></li>
								<li><a href="#">���˹���ϵͳ</a></li>
								<li><a href="#">��Ʒ�����������</a></li>
								<li><a href="#">ʵ����������ϵͳ</a></li>
								<li><a href="#">Զ�̵��ӽ�ѧϵͳ</a></li>
								<li><a href="#">������Ŀ��</a></li>
								<li><a href="#">���ÿ���Ϣϵͳ</a></li>
								<li><a href="#">���ÿ�ҵ��������</a></li>
								<li><a href="#">������ҵ�о�����</a></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- left menu end -->

				<!-- right content begin -->
				<div class="grid_18">
					<!-- main top begin -->
					<div>
						<div class="grid_12 alpha">
							<div>
								<div class="a_tab">
									<a href="">�칫�ҹ�����</a>
								</div>
								<div class="div_tab">
									<table width="100%" style="table-layout: fixed;">
										<tr>
											<td width="6%">&nbsp;&nbsp;<img width="16" height="16"
												src="<%=basePath%>/images/ico04.gif" alt="�칫�ҹ���"></td>
											<td width="76%"><a href="#">�Ͼ�����������ֲ�2������ֲ�2014�����������������뺯</a></td>
											<td width="18%" align="right">&nbsp;&nbsp;2014-05-27</td>
										</tr>
									</table>
								</div>
							</div>
							<div class="margin_t_10">
								<div class="a_tab">
									<a href="">��Ҫ֪ͨ</a>
								</div>
								<div class="div_tab">
									<table id="notilist" width="100%" style="table-layout: fixed;">
										<tr>
											<td width="5%"></td>
											<td width="16%" align="left">[ �Ƽ����� ]</td>
											<td align="left"><a href="#">��������s�°��°��°��°��°��°��°��°��°��°��°����Թػ���֪ͨ</a></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<div class="grid_6 omega">
							<div class="xcptj margin_l_10 grid_6 omega">
								<h3 class="title_230">�²�Ʒ�ƽ�</h3>
								<div class="grid_6 alpha omega">
									<ul>
										<li><a href="#"><nobr>���������ص������ص������ص������ص��豸��Ʒ����</nobr></a></li>
										<li><a href="#">���������²�Ʒ��ѵ����</a></li>
										<li><a href="#">���������ص��豸��Ʒ����</a></li>
										<li><a href="#">���������²�Ʒ��ѵ����</a></li>
										<li><a href="#">���������ص��豸��Ʒ����</a></li>
										<li><a href="#">���������²�Ʒ��ѵ����</a></li>
										<li><a href="#">���������ص��豸��Ʒ����</a></li>
										<li><a href="#">���������²�Ʒ��ѵ����</a></li>
										<li><a href="#">���������²�Ʒ��ѵ����</a></li>
									</ul>
								</div>
							</div>
							<div style="padding-left: 20px"></div>
						</div>
					</div>
					<div class="clear"></div>
					<!-- main top end -->

					<!-- news -->
					<div id="gsxw1" class="margin_t_10">
						<h3>
							���ſ�� <a href="#">����...</a>
						</h3>
						<div class="grid_9 alpha omega">flash</div>
						<div id="gsxw2_show" class="grid_9 alpha omega">
							<table width="315px" style="table-layout: fixed;">
								<tr>
									<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="�칫�ҹ���"></td>
									<td><a href="#">�Ͼ�����������ֲ�2014�����������������뺯</a></td>
								</tr>
								<tr>
									<td>&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="�칫�ҹ���"></td>
									<td><a href="#">�Ͼ�����������ֲ�2014�����������������뺯</a></td>
								</tr>
								<tr>
									<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="�칫�ҹ���"></td>
									<td><a href="#">�Ͼ�����������ֲ�2014�����������������뺯</a></td>
								</tr>
								<tr>
									<td>&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="�칫�ҹ���"></td>
									<td><a href="#">�Ͼ�����������ֲ�2014�����������������뺯</a></td>
								</tr>
								<tr>
									<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="�칫�ҹ���"></td>
									<td><a href="#">�Ͼ�����������ֲ�2014������������----------------------�����뺯</a></td>
								</tr>
								<tr>
									<td>&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="�칫�ҹ���"></td>
									<td><a href="#">�Ͼ�����������ֲ�2014�����������������뺯</a></td>
								</tr>
								<tr>
									<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="�칫�ҹ���"></td>
									<td><a href="#">�Ͼ�����������ֲ�2014�����������������뺯</a></td>
								</tr>
								<tr>
									<td>&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="�칫�ҹ���"></td>
									<td><a href="#">�Ͼ�����������ֲ�2014�����������������뺯</a></td>
								</tr>
							</table>
						</div>
					</div>
					<div class="clear"></div>
					<!-- end news -->

					<div class="grid_18 alpha omega" style="margin-top: 10px">
						<div id="ad">
							<a href="#"><img src="<%=basePath%>/images/ad1.png"
								alt="���ͼƬ" /></a>
						</div>
					</div>
					<div class="clear"></div>

					<div class="grid_18 alpha omega">
						<div class="grid_9 alpha margin_t_10">
							<div id="tab4" class="a_tab">
								<a href="" onmouseover="switchTab(4,1)">��Ӫ����</a>
								<a href="" onmouseover="switchTab(4,2)">���а칫��</a>
								<a href="" onmouseover="switchTab(4,3)">֧�ж�̬</a>
							</div>
							<div id="div_con4_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۹�˾ҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۹�˾ҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con4_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۷��а칫�ңݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۷��а칫�ңݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con4_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��֧�ж�̬�ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��֧�ж�̬�ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��֧�ж�̬�ݲ���</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="grid_9 omega alpha margin_t_10 div_float_r">
							<div id="tab5" class="a_tab">
								<a href="" onmouseover="switchTab(5,1)">��������</a>
								<a href="" onmouseover="switchTab(5,2)">��˾ҵ��</a>
								<a href="" onmouseover="switchTab(5,3)">����ҵ��</a>
							</div>
							<div id="div_con5_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۵������УݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۵������УݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con5_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۹�˾ҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۹�˾ҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con5_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">������ҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">������ҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">������ҵ�������</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="clear"></div>
						<div class="grid_9 alpha margin_t_10">
							<div id="tab6" class="a_tab">
								<a href="" onmouseover="switchTab(6,1)">������Դ</a>
								<a href="" onmouseover="switchTab(6,2)">С΢����</a>
								<a href="" onmouseover="switchTab(6,3)">ó�׽���</a>
							</div>
							<div id="div_con6_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��������Դ�ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��������Դ�ݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con6_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��С΢���ڣݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��С΢���ڣݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con6_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��ó�׽��ڣݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��ó�׽��ڣݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��ó�׽��ڣݲ���</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="grid_9 omega alpha margin_t_10 div_float_r">
							<div id="tab7" class="a_tab">
								<a href="" onmouseover="switchTab(7,1)">ͬҵҵ��</a>
								<a href="" onmouseover="switchTab(7,2)">��Ӫ����</a>
								<a href="" onmouseover="switchTab(7,3)">�ƻ�����</a>
							</div>
							<div id="div_con7_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��ͬҵҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">��ͬҵҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con7_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">����Ӫ����ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">����Ӫ����ݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con7_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�ۼƻ�����ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�ۼƻ�����ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�ۼƻ����������</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="clear"></div>
						<div class="grid_9 alpha margin_t_10">
							<div id="tab8" class="a_tab">
								<a href="" onmouseover="switchTab(8,1)">���տ���</a>
								<a href="" onmouseover="switchTab(8,2)">�ʲ���ȫ</a>
								<a href="" onmouseover="switchTab(8,3)">���ɺϹ�</a>
							</div>
							<div id="div_con8_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۷��տ��ƣݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۷��տ��ƣݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con8_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">���ʲ���ȫ�ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">���ʲ���ȫ�ݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con8_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۷��ɺϹ�ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۷��ɺϹ�ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۷��ɺϹ�ݲ���</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="grid_9 omega alpha margin_t_10 div_float_r">
							<div id="tab9" class="a_tab">
								<a href="" onmouseover="switchTab(9,1)">�Ƽ���Ϣ</a>
								<a href="" onmouseover="switchTab(9,2)">Ͷ��ҵ��</a>
								<a href="" onmouseover="switchTab(9,3)">���Ź���</a>   
							</div>
							<div id="div_con9_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۵������УݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۵������УݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con9_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۹�˾ҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">�۹�˾ҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con9_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">������ҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">������ҵ��ݶԹ�����ܱ�20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="��Ӫ����"></td>
										<td><a href="#">������ҵ�������</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>

					<div id="tpfc" class="grid_18 alpha omega margin_t_10"></div>
				</div>
				<!-- right content end -->
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