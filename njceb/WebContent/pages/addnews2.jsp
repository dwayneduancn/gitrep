<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>发布新闻</title>
<script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="../ckeditor/config.js"></script>
<link rel="stylesheet" href="../uploadify/uploadify.css" type="text/css"></link>
<script type="text/javascript" src="../uploadify/jquery.uploadify-3.1.min.js"></script>
<script>
	var filePath="";
	var fileName ="";
	function CKupdate() {
		for (instance in CKEDITOR.instances)
			CKEDITOR.instances[instance].updateElement();
	}
	
	$(function() {
		//var fileMap = new HashMap();
		$("#multiple_file_upload").uploadify({
			'uploader' : '../fileUpload.action',//************ action **************
			'height' : 27,//表示按钮的高度，默认30PX。若要改为50PX，如下设置：'height' : 50，
			'width' : 50,//表示按钮的宽度
			'buttonText' : '浏 览',//按钮上显示的文字，默认”SELECT FILES”
			'buttonCursor' : 'hand',//上传按钮Hover时的鼠标形状，默认值是’hand’
			'auto' : false, //是否自动开始   
			'multi' : false, //是否支持多文件上传，默认为true
			'method' : 'post',//默认是’post’,也可以设置为’get’
			'swf' : '../uploadify/uploadify.swf',//进度条显示文件
			'cancelImg' : '../uploadify/uploadify-cancel.png',//取消按钮的图片
			'fileTypeDesc' : 'jpg、png、gif、bmp',//允许上传的文件类型的描述，在弹出的文件选择框里会显示
			'fileTypeExts' : '*.jpg;*.png;*.gif;*.bmp;*.doc;*.txt',//指定文件格式
			'fileSizeLimit' : '50MB',//上传文件大小限制，默认单位是KB，若需要限制大小在100KB以内，可设置该属性为：'100KB'
			'fileObjName' : 'myFile',//文件对象名称。用于在服务器端获取文件。
			'formData' : {
				'userName' : '',
				'content' : ''
			},
			'progressData' : 'all', // 'percentage''speed''all'//队列中显示文件上传进度的方式：all-上传速度+百分比，percentage-百分比，speed-上传速度
			'preventCaching' : true,//若设置为true，一个随机数将被加载swf文件URL的后面，防止浏览器缓存。默认值为true
			'timeoutuploadLimit' : 5,//能同时上传的文件数目
			'removeCompleted' : true,//默认是True，即上传完成后就看不到上传文件进度条了。
			'removeTimeout' : 5,//上传完成后多久删除队列中的进度条，默认为3，即3秒。
			'requeueErrors' : true,//若设置为True，那么在上传过程中因为出错导致上传失败的文件将被重新加入队列。
			'successTimeout' : 30,//表示文件上传完成后等待服务器响应的时间。不超过该时间，那么将认为上传成功。默认是30，表示30秒。
			'uploadLimit' : 999,//最多上传文件数量，默认999
			'onUploadStart' : function(file) {
				//$("#file_upload").uploadify("settings", "formData", {'userName':name,'qq':qq});  
				//$("#file_upload").uploadify("settings", "buttonText", "aaa");
				//alert(file.name + " is ready to go!")
				$("#stopUpload").removeAttr("hidden");
			},
			'onUploadSuccess' : function(file, data, response) {
				//alert(file.name + " upload success !");
				filePath=data;
				fileName = file.name;
				$("#stopUpload").attr("hidden",true);
			}

		});
	
	});
	
	function saveNews() {
		CKupdate();
		
		/* Get input values from form */
	    var values = jQuery("#newsForm").serializeArray();
		
	    /* Because serializeArray() ignores unset checkboxes and radio buttons: */
	    values = values.concat(
	            jQuery('#newsForm input[type=checkbox]:not(:checked)').map(
	                    function() {
	                        return {"name": this.name, "value": 'off'}
	                    }).get()
	    );
	    values = values.concat({"name":"fileName","value":fileName},{"name":"filePath","value":filePath});

		$.ajax({
			cache : true,
			type : "POST",
			url : "../addNews.action",
			data : values,
			async : false,
			error : function(request) {
				alert("保存失败!" + request);
			},
			success : function(data) {
				alert("保存成功!");
			}
		});
	}
		

</script>
</head>
<body>
	<h1 class="samples">新闻发布</h1>

	<form id="newsForm" method="post">
		<div>
			新闻标题: <input type="text" id="newsTitle" name="newsTitle" />
			投稿人: <input type="text" id="newsAuthor" name="newsAuthor" />
		</div>
		<div>
			是否立即发布: <input type="checkbox" id="isPost" name="isPost" />&nbsp;&nbsp;&nbsp;
			是否置顶: <input type="checkbox" id="isTop" name="isTop" />
		</div>
			
		<div>
			新闻内容：
			<textarea name="content" style="visibility: hidden; display: none;"></textarea>
			<script type="text/javascript">
				var editor = CKEDITOR.replace('content');
			</script>
		</div>

		
	 	<div align="left">
	 	  	添加附件：
	        <input type="file" name="uploadify" id="multiple_file_upload" />  
	        <hr>  
	        <a href="javascript:$('#multiple_file_upload').uploadify('upload','*')">开始上传</a>  
	        <a href="javascript:$('#multiple_file_upload').uploadify('cancel','*')">取消上传</a>  
	        <a href="javascript:$('#multiple_file_upload').uploadify('stop','*')" hidden=true id="stopUpload">停止上传</a>  
	    	<input type="hidden"></input>
	    </div>  		
		<div>
			<input type="button" value="保存" onclick="saveNews()"></input>
		</div>
		
		
	</form>

</body>
</html>
