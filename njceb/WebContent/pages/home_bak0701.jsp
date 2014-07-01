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
<title>中国光大银行--南京分行</title>

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

				if ($('#jsfoot01')) {
					var scrollup = new ScrollText("jsfoot01");
					scrollup.LineHeight = 24; //单排文字滚动的高度
					scrollup.Amount = 1; //注意:子模块(LineHeight)一定要能整除Amount.
					scrollup.Delay = 20; //延时
					scrollup.Start(); //文字自动滚动
					scrollup.Direction = "up"; //文字向下滚动
				}
			});

	function queryNoti() {
		$.ajax({
			async : false,
			cache : false,
			type : "post",//发送方式
			url : "/njceb/queryNotification.action",// 路径
			data : '',
			error : function() {//请求失败处理函数
				alert('请求失败');
			},
			success : function(data) {
				//var data = eval('(' + result + ')');
				if (data && data != null && data != '') {
					$('#jsfoot01').empty();//清空resText里面的所有内容
               		var html = ''; 
					$.each(data, function(commentIndex, comment){
						html += '<li><a target="_blank" href="#" title="' + comment['notiTitle'] + '"> ' +comment['dateIssued'] +' &nbsp;&nbsp;' +comment['notiTitle']+ '</a></li>';						
             		});
                	$('#jsfoot01').html(html);
				}
			}
		});
	}

	function queryOfficeAnnounce() {
		$.ajax({
			async : false,
			cache : false,
			type : "post",//发送方式
			url : "/njceb/queryOfficeAnnounce.action",// 路径
			data : '',
			error : function() {//请求失败处理函数
				alert('请求失败');
			},
			success : function(data) {
				//var data = eval('(' + result + ')');
				if (data && data != null && data != '') {
					$('#officeannounce').empty();//清空resText里面的所有内容
               		var html = ''; 
					$.each(data, function(commentIndex, comment){
						html += '<tr><td width="6%">&nbsp;&nbsp;<img width="16" height="16"src="<%=basePath%>/images/ico04.gif" alt="'+comment['notiTitle']+'"></td><td width="76%"><a href="#">'+comment['notiTitle']+'</a></td><td width="18%" align="right">&nbsp;&nbsp;'+comment['dateIssued']+'</td></tr>';
					});
					console.log(html);
                	$('#officeannounce').html(html);
				}
			}
		});
	}

	function changeImg() {
		var imgSrc = $("#imgObj");
		var src = imgSrc.attr("src");
		imgSrc.attr("src", chgUrl(src));
	}
	//时间戳  
	//为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳  
	function chgUrl(url) {
		var timestamp = (new Date()).valueOf();
		if ((url.indexOf("&") >= 0)) {
			url = url + "×tamp=" + timestamp;
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
			alert("用户名不能为空");
			$("input#userName")[0].focus();
			return false;
		}
		if (password == '') {
			alert("密码不能为空");
			$("input#passWord")[0].focus();
			return false;
		}
		if (!code || code == '') {
			alert("请输入验证码");
			$("input#validateCode")[0].focus();
			return false;
		} else if (code.length != 4) {
			alert("验证码为四位");
			$("input#validateCode")[0].focus();
			return false;
		}
		$.ajax({
			async : false,
			cache : false,
			type : "post",//发送方式
			url : chgUrl("/njceb/login.action"),// 路径
			data : "userName=" + username + "&passWord=" + password
					+ "&validateCode=" + code,
			error : function() {//请求失败处理函数
				alert('请求失败');
			},
			success : function(data) {
				//var data = eval('(' + result + ')');
				if (data && data != null && data != '') {
					if (data.indexOf('LOGIN_ERROR') > -1) {
						//登录失败
						var errMsg = data.substring(12);
						alert(errMsg);
						$("input#userName")[0].focus();
					} else if (data.indexOf('LOGIN_SUCC') > -1) {
						//登录成功
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
					alert("登录异常，请重新登录!");
					$("input#userName")[0].focus();
				}
			}
		});
	}

	function showregdiv() {
		$('#regform').form('clear');
		$('#register').dialog('open').dialog('setTitle', '注册');
	}

	function register() {
		if ($('#regform').form('validate')) {
			if ($('#rePass').val() != $('#regPass').val()) {
				$.messager.alert("密码输入错误提示", "两次密码输入不一致，请重新输入！", "error");
				$('input#regPass')[0].focus();
				return;
			}
			$.ajax({
				async : false,
				cache : false,
				type : "post",//发送方式
				url : chgUrl("/njceb/register.action"),// 路径
				data : "userName=" + $('#regName').val() + "&passWord="
						+ $('#regPass').val() + "&deptId="
						+ $('#deptId').combobox('getValue'),
				error : function() {//请求失败处理函数
					alert('请求失败');
				},
				success : function(data) {
					//var data = eval('(' + result + ')');
					if (data && data != null && data != '') {
						if (data.indexOf('REGISTER_ERROR') > -1) {
							//注册失败
							var errMsg = data.substring(15);
							$.messager.alert("注册失败提示", errMsg, "error");
							$("input#userName")[0].focus();
						} else if (data.indexOf('REGISTER_SUCC') > -1) {
							//登录成功
							$.messager.alert("注册成功提示", data.substring(14),
									"info");
							$('#register').dialog('close');
							//登录
						} else {
							$.messager.alert("注册失败提示", data, "error");
							$("input#regName")[0].focus();
						}
					} else {
						alert("服务器返回数据异常，请重新注册!");
						$("input#regName")[0].focus();
					}
				}
			});
		}
	}
	
	//获取点击的tab是第几个
	function switchTab(t, con) {
		//获取tab的个数
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
					<input type="text"><input type="button" value="搜索"
						onclick="queryOfficeAnnounce();">
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
				<div>
					<strong>最新动态：</strong> <span>
						<ul id="jsfoot01" class="noticTipTxt">
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
						<h3 class="title_230">登录</h3>
						<div id="login_form">
							<form method="post">
								<table>
									<tr>
										<td style="text-align: center; width: 27%"><label>&nbsp;&nbsp;&nbsp;用户名：</label></td>
										<td style="text-align: left; width: 73%" colspan="3"><input
											size="20" id="userName" type="text" name="userName"></td>
									</tr>
									<tr>
										<td><label>&nbsp;&nbsp;&nbsp;密&nbsp;&nbsp;&nbsp;码：</label></td>
										<td><input size="20" id="passWord" type="password"
											name="passWord"></td>
									</tr>
									<tr>
										<td><label>&nbsp;&nbsp;&nbsp;校验码：</label></td>
										<td><input size="5" type="text" id="validateCode"
											name="validateCode"></td>
										<td
											style="text-align: center; width: 25%; vertical-align: middle;"><img
											id="imgObj" alt="" src="/njceb/getValidateCode.action" /></td>
										<td
											style="text-align: center; width: 25%; vertical-align: middle;"><a
											href="#" onclick="changeImg()">换一张</a></td>
									</tr>
									<tr>
										<td style="text-align: center; width: 100%" colspan="4">
											<input type="button" onclick="login()" value="登录">&nbsp;
											<input type="reset" value="重置">&nbsp; <a
											style="vertical-align: bottom;" href="#"
											onclick="showregdiv()">注册</a>
										</td>
									</tr>
								</table>
							</form>
						</div>
						<div id="register"
							style="width: 400px; padding: 10px 60px 20px 60px"
							class="easyui-dialog" closed="true" buttons="#dlg-buttons">
							<div class="ftitle">注册信息编辑</div>
							<form method="post" id="regform">
								<table cellpadding="5">
									<tr>
										<td width="30%" align="right">用户名</td>
										<td width="70%" align="left"><input
											class="easyui-validatebox textbox"
											data-options="required:true,validType:'length[2,10]'"
											id="regName" name="regName"></td>
									</tr>
									<tr>
										<td>密码</td>
										<td><input class="easyui-validatebox textbox"
											data-options="required:true,validType:'length[3,10]'"
											id="regPass" name="regPass"></td>
									</tr>
									<tr>
										<td>再输一次</td>
										<td><input class="easyui-validatebox textbox"
											data-options="required:true" id="rePass" name="rePass"></td>
									</tr>
									<tr>
										<td>部门</td>
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
								onclick="register()">保存</a> <a href="#"
								class="easyui-linkbutton" iconCls="icon-cancel"
								onclick="javascript:$('#register').dialog('close')">取消</a>
						</div>
						<div ID="login_succ" style="display: none;">
							<label>欢迎您！&nbsp;</label><label id="login_user"></label>&nbsp;&nbsp;<label
								id="dept_name"></label> <br /> <a href="#">进入我的综合事务管理平台</a> <br />
						</div>
					</div>
					<div class="middle_l_inner margin_t_10">
						<h3 class="title_230">公司部门</h3>
						<div id="fhbgs">
							<ul>
								<li><a href="#">分行办公室</a></li>
								<li><a href="#">人力资源</a></li>
								<li><a href="#">公司业务</a></li>
								<li><a href="#">小微金融</a></li>
								<li><a href="#">零售业务</a></li>
								<li><a href="#">电子银行</a></li>
								<li><a href="#">贸易金融</a></li>
								<li><a href="#">同业业务</a></li>
								<li><a href="#">运营管理</a></li>
								<li><a href="#">计划财务</a></li>
								<li><a href="#">风险控制</a></li>
								<li><a href="#">授信管理</a></li>
								<li><a href="#">资产保全</a></li>
								<li><a href="#">法律合规</a></li>
								<li><a href="#">投行业务</a></li>
								<li><a href="#">信息科技</a></li>
							</ul>
						</div>
					</div>
					<div class="middle_r_inner">
						<h3 class="title_230">电子银行宣传栏</h3>
						<div id="elecbankdept">
							<span id="_ctl0_LblContent"> </span>
						</div>
					</div>
					<div class="middle_l_inner2">
						<h3 class="title_230">热点链接</h3>
						<div class="rdlj">
							<ul>
								<li><a href="#">综合事务管理平台</a></li>
								<li><a href="#">总行外部网站(网银)</a></li>
								<li><a href="#">总行内部网站</a></li>
								<li><a href="#">总行上网白名单</a></li>
								<li><a href="#">IAM统一身份与访问管理</a></li>
								<li><a href="#">OA综合办公系统</a></li>
								<li><a href="#">分行短信平台</a></li>
								<li><a href="#">零售业务绩效考核系统</a></li>
								<li><a href="#">电子银行厅堂营销系统</a></li>
								<li><a href="#">报表发布系统</a></li>
								<li><a href="#">统合信息查询系统</a></li>
								<li><a href="#">对公授信收益预测系统</a></li>
								<li><a href="#">信贷管理系统［CECM］</a></li>
								<li><a href="#">对公OCRM管理系统</a></li>
								<li><a href="#">外汇帐户管理系统</a></li>
								<li><a href="#">个人信贷管理系统</a></li>
								<li><a href="#">个人购汇系统</a></li>
								<li><a href="#">产品经济利润估算</a></li>
								<li><a href="#">实体渠道管理系统</a></li>
								<li><a href="#">远程电子教学系统</a></li>
								<li><a href="#">核心项目组</a></li>
								<li><a href="#">信用卡信息系统</a></li>
								<li><a href="#">信用卡业务常用资料</a></li>
								<li><a href="#">江苏行业研究报告</a></li>
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
									<a href="">办公室公告栏</a>
								</div>
								<div class="div_tab">
									<table id="officeannounce" width="100%" style="table-layout: fixed;">
										<tr>
											<td width="6%">&nbsp;&nbsp;<img width="16" height="16"
												src="<%=basePath%>/images/ico04.gif" alt="办公室公告"></td>
											<td width="76%"><a href="#">南京分行足球俱乐部2足球俱乐部2014年五人制足球赛邀请函</a></td>
											<td width="18%" align="right">&nbsp;&nbsp;2014-05-27</td>
										</tr>
									</table>
								</div>
							</div>
							<div class="margin_t_10">
								<div class="a_tab">
									<a href="">重要通知</a>
								</div>
								<div class="div_tab">
									<table id="notilist" width="100%" style="table-layout: fixed;">
										<tr>
											<td width="5%"></td>
											<td width="16%" align="left">[ 科技部门 ]</td>
											<td align="left"><a href="#">关于做好s下班下班下班下班下班下班下班下班下班下班下班后电脑关机的通知</a></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<div class="grid_6 omega">
							<div class="xcptj margin_l_10 grid_6 omega">
								<h3 class="title_230">新产品推介</h3>
								<div class="grid_6 alpha omega">
									<ul class="grid_6 alpha omega">
										<li><a href="#"><nobr>关于自助回单自助回单自助回单自助回单设备产品介绍</nobr></a></li>
										<li><a href="#">电子银行新产品培训资料</a></li>
										<li><a href="#">关于自助回单设备产品介绍</a></li>
										<li><a href="#">电子银行新产品培训资料</a></li>
										<li><a href="#">关于自助回单设备产品介绍</a></li>
										<li><a href="#">电子银行新产品培训资料</a></li>
										<li><a href="#">关于自助回单设备产品介绍</a></li>
										<li><a href="#">电子银行新产品培训资料</a></li>
										<li><a href="#">电子银行新产品培训资料</a></li>
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
							新闻快递 <a href="#">更多...</a>
						</h3>
						<div class="grid_9 alpha omega">flash</div>
						<div id="gsxw2_show" class="grid_9 alpha omega">
							<table width="315px" style="table-layout: fixed;">
								<tr>
									<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="办公室公告"></td>
									<td><a href="#">南京分行足球俱乐部2014年五人制足球赛邀请函</a></td>
								</tr>
								<tr>
									<td>&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="办公室公告"></td>
									<td><a href="#">南京分行足球俱乐部2014年五人制足球赛邀请函</a></td>
								</tr>
								<tr>
									<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="办公室公告"></td>
									<td><a href="#">南京分行足球俱乐部2014年五人制足球赛邀请函</a></td>
								</tr>
								<tr>
									<td>&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="办公室公告"></td>
									<td><a href="#">南京分行足球俱乐部2014年五人制足球赛邀请函</a></td>
								</tr>
								<tr>
									<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="办公室公告"></td>
									<td><a href="#">南京分行足球俱乐部2014年五人制足球----------------------赛邀请函</a></td>
								</tr>
								<tr>
									<td>&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="办公室公告"></td>
									<td><a href="#">南京分行足球俱乐部2014年五人制足球赛邀请函</a></td>
								</tr>
								<tr>
									<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="办公室公告"></td>
									<td><a href="#">南京分行足球俱乐部2014年五人制足球赛邀请函</a></td>
								</tr>
								<tr>
									<td>&nbsp;&nbsp;<img width="16" height="16"
										src="<%=basePath%>/images/ico04.gif" alt="办公室公告"></td>
									<td><a href="#">南京分行足球俱乐部2014年五人制足球赛邀请函</a></td>
								</tr>
							</table>
						</div>
					</div>
					<div class="clear"></div>
					<!-- end news -->

					<div class="grid_18 alpha omega" style="margin-top: 10px">
						<div id="ad">
							<a href="#"><img src="<%=basePath%>/images/ad1.png"
								alt="广告图片" /></a>
						</div>
					</div>
					<div class="clear"></div>

					<div class="grid_18 alpha omega">
						<div class="grid_9 alpha margin_t_10">
							<div id="tab4" class="a_tab">
								<a href="" onmouseover="switchTab(4,1)">经营分析</a> <a href=""
									onmouseover="switchTab(4,2)">分行办公室</a> <a href=""
									onmouseover="switchTab(4,3)">支行动态</a>
							</div>
							<div id="div_con4_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［公司业务］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［公司业务］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con4_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［分行办公室］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［分行办公室］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con4_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［支行动态］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［支行动态］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［支行动态］测试</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="grid_9 omega alpha margin_t_10 div_float_r">
							<div id="tab5" class="a_tab">
								<a href="" onmouseover="switchTab(5,1)">电子银行</a> <a href=""
									onmouseover="switchTab(5,2)">公司业务</a> <a href=""
									onmouseover="switchTab(5,3)">零售业务</a>
							</div>
							<div id="div_con5_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［电子银行］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［电子银行］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con5_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［公司业务］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［公司业务］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con5_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［零售业务］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［零售业务］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［零售业务］幽幽</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="clear"></div>
						<div class="grid_9 alpha margin_t_10">
							<div id="tab6" class="a_tab">
								<a href="" onmouseover="switchTab(6,1)">人力资源</a> <a href=""
									onmouseover="switchTab(6,2)">小微金融</a> <a href=""
									onmouseover="switchTab(6,3)">贸易金融</a>
							</div>
							<div id="div_con6_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［人力资源］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［人力资源］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con6_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［小微金融］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［小微金融］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con6_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［贸易金融］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［贸易金融］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［贸易金融］测试</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="grid_9 omega alpha margin_t_10 div_float_r">
							<div id="tab7" class="a_tab">
								<a href="" onmouseover="switchTab(7,1)">同业业务</a> <a href=""
									onmouseover="switchTab(7,2)">运营管理</a> <a href=""
									onmouseover="switchTab(7,3)">计划财务</a>
							</div>
							<div id="div_con7_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［同业业务］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［同业业务］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con7_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［运营管理］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［运营管理］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con7_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［计划财务］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［计划财务］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［计划财务］幽幽</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="clear"></div>
						<div class="grid_9 alpha margin_t_10">
							<div id="tab8" class="a_tab">
								<a href="" onmouseover="switchTab(8,1)">风险控制</a> <a href=""
									onmouseover="switchTab(8,2)">资产保全</a> <a href=""
									onmouseover="switchTab(8,3)">法律合规</a>
							</div>
							<div id="div_con8_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［风险控制］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［风险控制］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con8_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［资产保全］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［资产保全］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con8_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［法律合规］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［法律合规］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［法律合规］测试</a></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="grid_9 omega alpha margin_t_10 div_float_r">
							<div id="tab9" class="a_tab">
								<a href="" onmouseover="switchTab(9,1)">科技信息</a> <a href=""
									onmouseover="switchTab(9,2)">投行业务</a> <a href=""
									onmouseover="switchTab(9,3)">授信管理</a>
							</div>
							<div id="div_con9_1" class="div_tab2" style="display: block;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［电子银行］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［电子银行］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con9_2" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［公司业务］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［公司业务］对公存款周报20140523</a></td>
									</tr>
								</table>
							</div>
							<div id="div_con9_3" class="div_tab2" style="display: none;">
								<table width="100%" style="table-layout: fixed;">
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［零售业务］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［零售业务］对公存款周报20140523</a></td>
									</tr>
									<tr>
										<td width="10%">&nbsp;&nbsp;<img width="16" height="16"
											src="<%=basePath%>/images/ico04.gif" alt="经营分析"></td>
										<td><a href="#">［零售业务］幽幽</a></td>
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
			<div id="footer" class="grid_16 footer">中国光大银行南京分行 版权所有 2014</div>
			<div class="clear"></div>
			<!-- footer end -->
		</div>
	</div>
</body>
</html>