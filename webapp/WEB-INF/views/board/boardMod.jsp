<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<!-- <meta name="viewport" content="width=device-width", initial-scale="1"> 반응형 -->
	<title>모두의 가계부</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.css"> <!-- stylesheet 외부의 css 가져오겟다 -->
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/Modu.css"> <!-- stylesheet 외부의 css 가져오겟다 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/daterangepicker.min.css">

<style>

/* AutoComplete */
.autocomplete-suggestions { border: 1px solid #999; background: #FFF; overflow: auto; }
.autocomplete-suggestion { padding: 2px 5px; white-space: nowrap; overflow: hidden; cursor: pointer; }
.autocomplete-selected { background: blue; color: white; }
.autocomplete-suggestions strong { font-weight: bold; color: orange; }
.autocomplete-group { padding: 2px 5px; }
.autocomplete-group strong { display: block; border-bottom: 1px solid #000; }

/* Date Picker  */
   #wrapper {
            width: 450px;
            margin: 0 auto;
            color: #333;
            font-family: Tahoma, Verdana, sans-serif;
            line-height: 1.5;
            font-size: 14px;
        }

        .demo {
            margin: 30px 0;
        }

        .date-picker-wrapper .month-wrapper table .day.lalala {
            background-color: orange;
        }

        .options {
            display: none;
            border-left: 6px solid #8ae;
            padding: 10px;
            font-size: 12px;
            line-height: 1.4;
            background-color: #eee;
            border-radius: 4px;
        }

        .date-picker-wrapper.date-range-picker19 .day.first-date-selected {
            background-color: red !important;
        }

        .date-picker-wrapper.date-range-picker19 .day.last-date-selected {
            background-color: orange !important;
        }
</style>


</head>
<body style="overflow-x:hidden; overflow-y:auto;">
	


<!-----------header------------------>
	
<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
	


<!----------------- container------------------->
<div class="container">
	<div class="text-center">
		<h4>글 수정</h4>
	</div>
	<form id="form_board" action="${pageContext.request.contextPath}/board/${authUser.groupNo}/modify" method="post" enctype="multipart/form-data"  >
		<input type="hidden" name="userNo" value="${authUser.userNo}">
		<input type="hidden" name="tagNo" id="tagNo" value="">
		<div>
		<input class="form-control mx-auto col-9 my-3" name="boardTitle" placeholder="제목을 입력하세요" value=${boardVo.boardTitle!=null? boardVo.boardTitle:''} >
		<textarea class="form-control col-9 mx-auto my-3" name="boardContent" id="exampleFormControlTextarea1"  rows="10" placeholder="내용을 입력하세요">${boardVo.boardContent!=null? boardVo.boardContent:''}</textarea>
		</div>
		<div class="card col-9 mx-auto my-3">
			<div class="card-header">
				<h5 class="mt-3" style="font-size: 1.2em;">가계부 첨부</h5>
			</div>
			<div class="card-body">
	
				<!-- Button trigger modal -->
				<div class="float-left mr-2">
					<button type="button" class="btn btn-primary " data-toggle="modal" data-target="#dateModal">
						날짜로 불러오기 			
					</button>
				</div>
	
	
	
				<!-- Button trigger modal -->
				<div class="float-left">
					<button type="button" id="btn_tag" class="btn btn-info " data-toggle="modal" data-target="#tagModal">
						태그로 불러오기 			
					</button>
				</div>
	
			
				<div style="clear: both;"> </div>
	
				<div class="text-left my-3">
					<span id="tagName" class="p-2" style="border:#54c9ad 2px solid; border-radius: 15px; ">
						#태그
					</span>
				</div>
				<div>
					<table class="table table-sm text-center">
						<thead class="thead-light">
							<tr>
								<th scope="col"></th>
								<th scope="col">날짜</th>
								<th scope="col">내역</th>
								<th scope="col" style="font-size:14pt;">금액(원)</th>
								<th scope="col" style="font-size:14pt;">인원(명)</th>
								<th scope="col">장소</th>
								<th scope="col">지도</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody id="accountList">
							
							
							<tr>
								
							     <td colspan="8" style="color:gray;">가계부를 첨부해 주세요.</td>
								
							</tr>
							
							 
											
						</tbody>
					</table>
	
	
	
				</div>
	
	
	
			</div>
	
		</div>

			<div class="form-group p-2 col-9 mx-auto my-3" style="position: relative;">
				<input type="file" class="custom-file-input" id="boardUpload"  name="files" multiple="multiple" onchange="loadFile(event);">
				<label class="custom-file-label up-label text-center pr-5" for="inputGroupFile04">이미지 업로드 &emsp;</label>
				<div id="imgPreview">
					<div class="rounded col-2" style="float : left"><img id="addImg0"  src=""   class="w-100 mx-auto mt-3"></div>
					<div class="rounded col-2" style="float : left"><img id="addImg1"   src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg2"  src=""    class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg3"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg4"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg5"  src="" class="w-100 mx-auto mt-3"></div>
					<div style="clear:both;"> </div>
					<div class="col-2" style="float : left"><img id="addImg6"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg7"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg8"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg9"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg10"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg11"  src="" class="w-100 mx-auto mt-3"></div>
					<div style="clear:both;"> </div>
					<div class="col-2" style="float : left"><img id="addImg12"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg13"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg14"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg15"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg16"  src="" class="w-100 mx-auto mt-3"></div>
					<div class="col-2" style="float : left"><img id="addImg17"  src="" class="w-100 mx-auto mt-3"></div>
					<div style="clear:both;"> </div>
				</div>
			</div>
			<div class="text-right mb-5 mx-auto w-75"  >
				<input class="btn btn-primary btn-lg mr-2" type="submit" value="저  장" >
				<input type="button"  class="btn btn-secondary btn-lg" onclick="location.href='${pageContext.request.contextPath }/board/${authUser.groupNo}'" value="취 소">		
 			</div>
	 </form>		
			

 


<!--날짜 불러오기 modal-->
<div class="modal fade bd-example-modal-lg" id="dateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" >
					<div class="modal-dialog modal-lg modal-dialog-centered" role="document" >
						<div class="modal-content" style="width: 500px; height:520px;">
							<div class="modal-header">
	
								<h4 class="modal-title mt-2" id="exampleModalCenterTitle">&nbsp;날짜로 불러오기</h4>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body px-0" style="margin:0" >
							


								<!-- <form enctype="multipart/form-data"  > -->
								<div id="wrapper">
											<br>
								              <input class="form-control text-center mx-auto " id="date-range12" style="width:300px;" value="">
								                
								                <span>&nbsp;</span>
								                <div class="text-center ml-1 pl-2" id="date-range12-container" style="width:400px;"></div>
								                <span>&nbsp;</span>
								                <div style="clear: both;"></div>
								                
								</div>
								<!-- </form> -->
	
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
								<!--  --><button type="button" id="btn_date" class="btn btn-primary">추가</button>
							
							<br>
							</div>
						</div>
					</div>
				</div>


	<!-- Modal -->
				<div class="modal fade" id="tagModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
	
								<h4 class="modal-title mt-2" id="exampleModalCenterTitle">&nbsp;태그로 불러오기</h4>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
	
								<form class="form-inline my-3" >
									<input class="searchForm form-control ml-4" style= "border-bottom-width:2px; border-color: #0070c0; width: 400px;" type="search" placeholder="태그명을 검색하세요" aria-label="search">
									<button class="t-button mt-2" type="submit"> <img src="${pageContext.request.contextPath }/assets/images/search02.png"> </button>
								</form>
								<div class="mt-4">
									<div class="ml-4">
									<h3 class="ml-2" style="font-weight: bold; font-size: 1.2em">최근 태그</h3>
	
									<div style="clear: both;"></div>
	
									<c:forEach items="${tagList}" var="vo">
										<div id="tag" data-tagno=${vo.tagNo} class="p-2 m-2 float-left" style="border:#54c9ad 2px solid; border-radius: 15px; font-weight:bold; cursor:pointer;">
									     	# ${vo.tagName}
										</div>	
									</c:forEach>
									
									</div>
									<div style="clear: both;"></div>
	
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
								<!-- <button type="button" class="btn btn-primary">추가</button> -->
							</div>
						</div>
					</div>
				</div>
				
					<!--지도 모달 -->
					<div class="modal fade" id="mapModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
								<div class="modal-header">
	
									<h4 class="modal-title mt-2" id="exampleModalCenterTitle">&nbsp;지도</h4>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span>&times;</span>
									</button>
								</div>
								<div class="modal-body">
	
	
									<div class="form-group p-2" style="position: relative;">
										<img id="map"  src="${pageContext.request.contextPath }/assets/images/map.png" class="w-100 mx-auto mt-3">
									</div>
	
	
								</div>
	
							</div>
						</div>
					</div>
				
				
				
		<!-- Delete Account Modal -->

			<div class="modal fade" id="deleteAccModal" tabindex="-1" role="dialog">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							
						
						</div>
						<div class="modal-body d-flex" style="align-items: center; justify-content: center;">
							<div style="font-weight: bold;" id='delMent'>정말로 삭제 하시겠습니까?</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-dark" data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-outline-danger" id="btn_delAcc" >삭제</button>
						</div>
					</div>
				</div>
			</div>
			
</div>



<!----------------- footer------------------->		
<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>



<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/header.js"></script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery.daterangepicker.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/jquery.daterangepicker.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/demo.js"></script>
<script type="text/javascript">


	
	$(document).ready(function(){
			
		$('.menuTab').removeClass("active");
		$("#btn_board").addClass("active");
		$('#boardUpload').val();
		var tagNo= ${boardVo.tagNo};
		
		if(tagNo!=null){
			
			getAccList(tagNo);
			
		}
		
	});

	
	/*  첫 글쓰기 화면 쎗팅 */
	
	
	
	
	/*   태그로 불러오기   */
	$(document).on('click','div [data-tagno]', function(){
		
	  var tagNo =$(this).data('tagno');
	  getAccList(tagNo);
	  
	});
	
	function getAccList(tagNo){
		
		 /* $("[data-tagno=tagno_"+tagno+"]") */
		  $("#tagNo").val(tagNo);
		  
		  $("#tagModal").modal('hide');
		  
			$.ajax({
				  
				  url : "${pageContext.request.contextPath}/board/${authUser.groupNo}/getAccountList",
				  type : "POST",
				  data : {tagNo:tagNo},
				  dataType : "json",	
				
				  success : function(list){
					  
					  console.log(list);
					  $("#tagName").text("#"+list[0].tagName);
					  $("#accountList").empty(); 
					  
					  $.each(list, function(idx,val){
						  
						  
						   renderAccount(val,"down",idx);
						  
					  })
					/*   $("#likeCount_"+boardNo).text(resultVo.likeCount+"명의 회원이 좋아합니다.");
					  $("[data-likeno="+boardNo+"]").data("state",resultVo.likeState);	 */					
				  },
				  
				  error : function(XHR, status, error){
					 console.error(XHR+status+error);
				  }
				  
			  });

		
			  return false;
	}
	 
	
	/* 가계부 그리기 */ 
	
	function renderAccount(vo,updown,i){
		  str= "  ";
		  str+= "	    	 <tr id='delAcc_"+vo.accountbookNo+"'>";
		  str+= "	      		<th scope='row'>";
		  str+= "	   				<div>";
		  str+= "							<input width=40px class='yj-checkbox' type='checkbox' aria-label='Checkbox for following text input'>";
		  str+= "					</div>";
		  str+= "				</th>";
		  str+= "						<td>"+vo.accountbookRegDate+"</td>";
		  str+= "						<td id='accUsage_"+vo.accountbookNo+"'>"+vo.accountbookUsage+"</td>";
		  str+= "						<td>"+vo.accountbookSpend+"</td>";
		  str+= "						<td style='width:80px;'><input class='form-control' name='accountList["+i+"].accountbookPersonnel' type='text' placeholder='인원' value='"+((vo.accountbookPersonnel!=null)?vo.accountbookPersonnel:'')+"' style='width:70px;' ></td>";
		  str+= "						<td><input class='form-control' type='text'  name='accountList["+i+"].accountbookPlace' placeholder='장소를 검색하세요' value='"+((vo.accountbookPlace!=null)?vo.accountbookPlace:'')+"'></td>";
		  str+= "						<td><button type='button' class='btn t-button p-0' data-toggle='modal' data-target='#mapModal'><img src='${pageContext.request.contextPath }/assets/images/mapIcon.png'></button></td>";
		  str+= "						<td class='delAccount' data-accno='"+vo.accountbookNo+"' style='cursor:pointer;'>&times;</td>";
		  str+= "			</tr>";
		  
		  str+= "			 <input type='hidden' name='accountList["+i+"].accountbookNo' value='"+vo.accountbookNo+"' >";
		  
		  if(updown=="up"){
			  
			  $("#accountList").prepend(str);
			  
		  } else{
			  $("#accountList").append(str);
		  }
		
		
	}
	
	/*   댓글 펼치기,감추기   */
	$("#btn-comment").on("click",function(){

		var val = $('#btn-comment').val();
		console.log(val);

		if(val==0){
			$('.comment-top').hide();
			$('#btn-comment').val("1");
			$(this).html("댓글 감추기");
		} else {

			$('.comment-top').show();
			$('#btn-comment').val("0");
			$(this).html("댓글 더 보기");
		}

		return	

	});    


	/* 가계부 삭제  */
	
	$(document).on('click','tr .delAccount', function(){
		
		var accountbookNo = $(this).data('accno');
		$("#btn_delAcc").val(accountbookNo);
		var accountbookUsage = $("#accUsage_"+accountbookNo).text();
		$('#delMent').text("'"+accountbookUsage+"' 항목을 삭제하시겠습니까?");
		$("#deleteAccModal").modal();
	
	});

	$("#btn_delAcc").click(function(){

		var accountbookNo = $("#btn_delAcc").val();
		$("#delAcc_"+accountbookNo).remove();
		$("#deleteAccModal").modal('hide');
		
	})
	
	

	/*  다중 이미지 미리보기 , 확장자 체크  */		

	var loadFile = function(event) {

		var addImg = new Array();
		alert($("#boardUpload").val());
		
		
		if(event.target.files.length>18){
			
			alert("이미지는 한번에 18개까지만 등록 가능합니다.")
			
		} else{
			for(var i=0;i<event.target.files.length; i++ ){
				$("#imgPreview").show();
				$("#addImg"+i).show();
				addImg[i]= document.getElementById('addImg'+i);
				addImg[i].src = URL.createObjectURL(event.target.files[i]);
				var fileName= new Array();
				
				fileName[i] = event.target.files[i].name;
				fileName[i] = fileName[i].slice(fileName[i].indexOf(".") + 1).toLowerCase();
				console.log(fileName[i]);
				
				if(fileName[i] != "jpg" && fileName[i] != "png" &&  fileName[i] != "gif" &&  fileName[i] != "bmp"){
		
					alert("이미지 파일은 (jpg, png, gif, bmp) 형식만 등록 가능합니다.");
		
					$("#boardUpload").val('');
					$("#imgPreview").hide();
					for(var i=0;i<event.target.files.length; i++ ){
					addImg[i].src='';
					}
					return false;
					/*$('#boardUploadModal').modal('hide');*/
		
				} else{
					
				}

			}
			
		}
	

		
		

	};

	/*  navbar 스크롤 제어  */

		//Hide Header on on scroll down 
		var didScroll; 
		var lastScrollTop = 0; 
		var delta = 5; 
		var navbarHeight = $('header').outerHeight(); 

		$(window).scroll(function(event){ 
			didScroll = true; 
		}); 

		setInterval(function() { 
			if (didScroll) { 
				hasScrolled(); 
				didScroll = false; 
			} 
		}, 250); 

		function hasScrolled() { 
			var st = $(this).scrollTop(); 

         // Make sure they scroll more than delta 
         if(Math.abs(lastScrollTop - st) <= delta) 
         	return; 

         // If they scrolled down and are past the navbar, add class .nav-up. 
         // This is necessary so you never see what is "behind" the navbar. 
         if (st > lastScrollTop && st > navbarHeight){ 
         // Scroll Down 
         $('header').removeClass('nav-down').addClass('nav-up');
     } else { 
         // Scroll Up 
         if(st + $(window).height() < $(document).height()) { 
         	$('header').removeClass('nav-up').addClass('nav-down'); 
         } 
     } 

     lastScrollTop = st; 

     

 }
</script>
</body>

</body>
</html>