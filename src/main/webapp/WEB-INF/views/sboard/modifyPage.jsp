
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<style>
					.fileDrop{
					width:80%;
					height:100px;
					border:1px dotted gray;
					background-color:lightslategrey;
					margin:auto;
					}
				</style>


<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">MODIFY BOARD</h3>
				</div>
				<!-- /.box-header -->
				<form id="modifyForm" role="form" method="post">
					<input type='hidden' name='page' value="${cri.page }">
					<input type='hidden' name='perPageNum' value="${cri.perPageNum }">
					<input type='hidden' name='bno' value="${boardVO.bno}" readonly="readonly">

					<div class="box-body">
						<div class="form-group">
							<label for="exampleInputEmail1">BNO</label> <input type="text"
								name='bno' class="form-control" value="${boardVO.bno }"
								readonly='readonly'>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label> <input type="text"
								name='title' class="form-control" value="${boardVO.title }">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Content</label>
							<textarea class="form-control" name="content" rows="3">${boardVO.content }</textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label> <input type="text"
								name="writer" class="form-control" value="${boardVO.writer }"
								readonly>
						</div>
						<div class="form-group">
								<label for="exampleInputEmail">File DROP</label>
								<div class="fileDrop"></div>
							</div>
					</div>
				</form>
				<ul class="mailbox-attachments clearfix uploadedList">
						</ul>
				<div class="box-footer">
					<button type="submit" class="btn btn-primary">SAVE</button>
					<button type="submit" class="btn btn-warning">CANCEL</button>
				</div>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
				<script type="text/javascript" src="/resources/js/upload.js"></script>
				
	<script id="template" type="text/x-handlebars-template">
	<li data-src='{{fullName}}'>
		<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
		<div class="mailbox-attachment-info">
			<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
			<a data-src="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
		</div>
	</li>
	</script>
	<script>
	var bno=${boardVO.bno};
	 $.getJSON("/sboard/getAttach/"+bno,function(list){
			$(list).each(function(){
				var fileInfo=getFileInfo(this);
				var html=template(fileInfo);
				$(".uploadedList").append(html);
			});
		 });
	var template=Handlebars.compile($("#template").html());
	
	$(".fileDrop").on("dragenter dragover",function(event){
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop",function(event){
		event.preventDefault();
		
		 var files=event.originalEvent.dataTransfer.files;
		
		var file=files[0];
		
		//console.log(file);
		
		var formData=new FormData();
		formData.append("file",file);
		
		$.ajax({
			url:'/uploadAjax',
			data:formData,
			dataType:'text',
			processData:false,
			contentType:false,
			type:'POST',
			success:function(data){
				alert(data);
			var fileInfo=getFileInfo(data);
			
			var html=template(fileInfo);
			
			$(".uploadedList").append(html);
			}
		});
	});
	$("#modifyForm").submit(function(event){
		event.preventDefault();
		
		var that=$(this);
		
		var str="";
		
		$(".uploadedList .delbtn").each(function(index){
			str+="<input type='hidden' name='files["+index+"]' value='"+$(this).attr("data-src")+"'>";
		});
		that.append(str);
		that.get(0).submit();
	});
	
	$(".uploadedList").on("click","a",function(event){
		var that=$(this);
		
		$.ajax({
			url:"/deleteFile",
			type:"post",
			data:{fileName:$(this).attr("data-src")},
			dataType:"text",
			success:function(result){
				if(result=='deleted'){
					alert("deleted");
					that.parent("div").parent("li").remove();
				}
			}
		});
	});
	</script>

				<script>
					$(document).ready(function() {
						var formObj = $("form[role='form']");
						console.log(formObj);
						$(".btn-warning").on("click", function() {
							self.location="/sboard/list?page=${cri.page}&perPageNum=${cri.perPageNum}"+"&searchType=${cri.searchType}&keyword=${cri.keyword}";
						});
						$(".btn-primary").on("click", function() {
							formObj.submit();
						});
					});
				</script>
			</div>
			<!-- /.box -->
		</div>
		<!--/.col (left) -->
	</div>
	<!-- /.row -->
</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<%@include file="../include/footer.jsp"%>
