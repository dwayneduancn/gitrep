<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>��������</title>
<script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="../ckeditor/config.js"></script>
<script>
	function CKupdate() {
		for (instance in CKEDITOR.instances)
			CKEDITOR.instances[instance].updateElement();
	}

	function saveNews() {
		CKupdate();
		$.ajax({
			cache : true,
			type : "POST",
			url : "../addNews.action",
			data : $('#newsForm').serialize(),
			async : false,
			error : function(request) {
				alert("����ʧ��!" + request);
			},
			success : function(data) {
				alert("����ɹ�!");
			}
		});
	}
	function uploadImage(editorInstance) {
		var xx = '<div id=\"word_image_container_temp\" style=\"display:none;\"></div>';
		var yy1 = '<div id=\"wordImageAppletWrapper\" style=\"height: 22px;background-color: #f2f1f1;border-top: 1px solid gray;position:fixed; bottom:0;left:0; width:100%; overflow: hidden;z-index:1000;\" > ';
		var yy3 = '</div>';
		
		document.write(xx);
		document.write(yy1);
		document.write(yy3);
		

		var ed = editorInstance;
		var txt = ed.getData();
		var txt0 = txt;
		jQuery('#word_image_container_temp').html(txt);
		//alert(jQuery('#container_temp').html());
		var i = 0;
		$('#word_image_container_temp img').each(
				function() {
					var src = $(this).attr('src');
					if (src.indexOf("file:///") != -1) {
						//ͼƬ�ڱ��صĵ�ַ
						var srct = src.replace('file:///', '');
						
						$.ajax({
							cache : true,
							type : "POST",
							url : "../uploadimg.action",
							data : srct,
							async : false,
							error : function(request) {
								alert("�ϴ�ʧ��!" + request);
							},
							success : function(data) {
								alert("�ϴ��ɹ�!");
							}
						});
						
						
						//alert(srct);
						//ͼƬ����ڷ������ϵĵ�ַ���ɺ�̨����
						var serverPath = '../image/';
						if (serverPath != 'error') {
							//alert(serverPath);
							txt = txt.replace(src, serverPath);
						}
					}
		});

	}
</script>
</head>
<body>
	<h1 class="samples">���ŷ���</h1>

	<form id="newsForm" method="post">
		<p>
			���ű���: <input type="text" id="newsTitle" name="newsTitle" />
		</p>

		<p>
			�������ݣ�
			<textarea name="content" style="visibility: hidden; display: none;"></textarea>
			<script type="text/javascript">
				var editor = CKEDITOR.replace('content');
				CKEDITOR.instances["content"].on("change", function() {
					//�ϴ�ͼƬ��������
					uploadImage(CKEDITOR.instances["content"]);
				});
			</script>
		</p>

		<input type="button" value="����" onclick="saveNews()"></input>
	</form>

</body>
</html>
