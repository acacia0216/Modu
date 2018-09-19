<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <!-- <meta name="viewport" content="width=device-width", initial-scale="1"> 반응형 -->
    <title>모두의 가계부</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.css"> <!-- stylesheet 외부의 css 가져오겟다 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/Modu.css"> <!-- stylesheet 외부의 css 가져오겟다 -->
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

	<style type="text/css">
		::-webkit-scrollbar {
			display:none;
		} 
	</style>
</head>
<body style="overflow-x:hidden; overflow-y:auto;">

<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

<div class="container">

    <div class="mt-5" style="width:1240px;margin-bottom:100px;">
			<div class="row">
				<div class="col-2">
			    	<div class="nav flex-column nav-pills lgContent" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			      		<a class="nav-link active" id="v-pills-food-tab" name="food" data-toggle="pill" href="#" role="tab" aria-selected="true">식사</a>
			      		<a class="nav-link" id="v-pills-tour-tab" name="tour" data-toggle="pill" href="#" role="tab" aria-selected="false">관광지</a>
			      		<a class="nav-link" id="v-pills-game-tab" name="game" data-toggle="pill" href="#" role="tab" aria-selected="false">오락시설</a>
			      		<a class="nav-link" id="v-pills-stay-tab" name="stay" data-toggle="pill" href="#" role="tab" aria-selected="false">숙박</a>
			    	</div>
			  	</div>
			  
			  	<div class="col-10">
			    	<div class="tab-content" id="v-pills-tabContent">
			      		<div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">	
			      			<div class="smTitle">
			      				<img class="mb-2" src="${pageContext.request.contextPath }/assets/images/new.png" style="width:30px;height:30px;">
			      				맞춤 추천 
			      			</div>
			      			<table class="table table-striped table-sm text-center">
								<thead class="lgContent">
									<tr>
										<th></th>
										<th value="title">장소명</th>
										<th value="roadaddress">주소</th>
										<th value="telephone">전화번호</th>
										<th value="maxperson">수용 인원</th>
										<th value="eachspend">1인당 예상 금액</th>										
									</tr>
								</thead>
				
								<tbody id="bestRecommend" class="smContent">
								</tbody>
	
							</table>
							<br><br>
			      			<div class="form-inline">		
						      	<div class="custom-control custom-radio mx-2 mb-3">
								  <input type="radio" checked="checked" value="group" id="recommendByGroup" name="recommendTypeRadio" class="custom-control-input">
								  <label class="custom-control-label smContent" for="recommendByGroup">우리 모임이 많이 간 곳</label>
								</div>
								<div class="custom-control custom-radio mx-2 mb-3">
								  <input type="radio" id="recommendByAll" value="all" name="recommendTypeRadio" class="custom-control-input">
								  <label class="custom-control-label smContent" for="recommendByAll">다른 모임이 많이 간 곳</label>
								</div>
							</div>		
					      	<table class="table table-striped table-sm text-center">
								<thead id="placeRecommendSort" class="lgContent">
									<tr>
										<th></th>
										<th value="title">장소명</th>
										<th value="roadaddress">주소</th>
										<th value="telephone">전화번호</th>
										<th value="maxperson">수용 인원</th>
										<th value="eachspend">1인당 예상 금액</th>										
									</tr>
								</thead>
				
								<tbody id="placeRecommendContent" class="smContent">
									
								</tbody>
				
							</table>
							<div class="m-2">								
								<div class="float-right">
									<button id="writePlanBtn" class="btn btn-outline-primary my-2 my-sm-0" >글쓰기</button>
								</div>								
							</div>							
			      		</div>
			    	</div>
			  	</div>
			</div>
    	</div>

</div>


<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>


<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/header.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=slvC1SL1B78rI5IoCUhs&submodules=geocoder"></script>
<script type="text/javascript">

	$(document).ready( function() {	
		//내비바 가계부 탭 활성화
		$('.menuTab').removeClass("active");
		$("#placerecommend").addClass("active");
	
	    $(".carousel").carousel({
	        interval: 10000
	    })
	    
	    var mode = 'food';
	    var recommendType = $('input:radio[name="recommendTypeRadio"]:checked').attr("value");
	    sortCol = '';
	    fetchPlaceRecommendList(mode,recommendType,sortCol);
	    
	    function fetchPlaceRecommendList(mode,recommendType,sortCol) {
			$.ajax({
				url : "${pageContext.request.contextPath }/placerecommend/${gvo.groupNo}/getplacerecommendlist",
				type : "post",
				//contentType : "application/json",
				data : { 	mode : mode,
							recommendType : recommendType,
							sortCol : sortCol
				},
				dataType : "json",
				success : function(recommendList) {
					$("#bestRecommend").empty();
					$("#placeRecommendContent").empty();
					
					for (var i = 0; i < recommendList.length-1; i++) {
						render(recommendList[i],i);
					}
					bestRender(recommendList[recommendList.length-1],0);
				},
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
			});
		}
	    
	  	//가계부 리스팅
		function bestRender(placeRecommendVo,i) {
			
			var str = "";
	
			str += "<tr value='장소명 : " + placeRecommendVo.title  + "\n주소 : " + placeRecommendVo.roadaddress + "\n전화번호 : " + 
					placeRecommendVo.telephone + "\n1인당 예상금액 : " + placeRecommendVo.eachspend + "원\n'>";
			str += "<td>" 
			
			str += "<div class='custom-control custom-checkbox'>";
			str += "<input type='checkbox' class='custom-control-input' id='bestCustomCheck" + i + "' tabindex='-1' name='chk'>";
			str += "<label class='custom-control-label'  for='bestCustomCheck" + i + "'>&nbsp;</label>";
			str += "</div>";
			str += "</td>";

			str += "<td>" + placeRecommendVo.title + "</td>";
			str += "<td>" + placeRecommendVo.roadaddress + "</td>";
			str += "<td>" + placeRecommendVo.telephone + "</td>";
			str += "<td>" + placeRecommendVo.maxperson + "&nbsp↑</td>";
			str += "<td>" + placeRecommendVo.eachspend + "원</td>";
			str += "</tr>";
			
			$("#bestRecommend").append(str);
			
	  	}
	  	
		function render(placeRecommendVo,i) {
			
			var str = "";
	
			str += "<tr value='장소명 : " + placeRecommendVo.title  + "\n주소 : " + placeRecommendVo.roadaddress + "\n전화번호 : " + 
					placeRecommendVo.telephone + "\n1인당 예상금액 : " + placeRecommendVo.eachspend + "원\n'>";
			str += "<td>" 
			
			str += "<div class='custom-control custom-checkbox'>";
			str += "<input type='checkbox' class='custom-control-input' id='customCheck" + i + "' tabindex='-1' name='chk'>";
			str += "<label class='custom-control-label'  for='customCheck" + i + "'>&nbsp;</label>";
			str += "</div>";
			str += "</td>";

			str += "<td>" + placeRecommendVo.title + "</td>";
			str += "<td>" + placeRecommendVo.roadaddress + "</td>";
			str += "<td>" + placeRecommendVo.telephone + "</td>";
			str += "<td>" + placeRecommendVo.maxperson + "&nbsp↑</td>";
			str += "<td>" + placeRecommendVo.eachspend + "원</td>";
			str += "</tr>";
			
			$("#placeRecommendContent").append(str);
			
	  	}
	  	
	  	$("#v-pills-tab").on("click",".nav-link",function(){
	  		mode = $(this).attr("name");
	  		recommendType = $('input:radio[name="recommendTypeRadio"]:checked').attr("value");
	  		
	  		fetchPlaceRecommendList(mode,recommendType,sortCol);
	  	})
	  	
	  	$("[name=recommendTypeRadio]").on("click",function(){
	  		recommendType = $(this).attr("value");
	  		fetchPlaceRecommendList(mode,recommendType,sortCol);
	  	})
	  	
	  	$("#placeRecommendSort").on("click","th",function(){
	  		$("#placeRecommendSort tr th").css('color','');
	  		$(this).css('color','blue');
	  		sortCol = $(this).attr("value");
	  		fetchPlaceRecommendList(mode,recommendType,sortCol);
	  	})
	  	
	  	$("#writePlanBtn").on("click",function(){
	  		var content = '';
	  		$('input:checkbox[name=chk]').each(function() {
	        	if($(this).is(':checked')){
	        		content += $(this).closest("tr").attr("value");
	        		content += "=================================\n";
	        	}
	      	});
	  		
	  		var form = document.createElement('form');
			var objs;
			objs = document.createElement('input');
			objs.setAttribute('type', 'hidden');
			objs.setAttribute('name', 'placePlan');
			objs.setAttribute('value', content);
			form.appendChild(objs);
			form.setAttribute('method', 'post');
			form.setAttribute('action', "${pageContext.request.contextPath}/board/${gvo.groupNo}/write" );
			document.body.appendChild(form);
			form.submit();
	  	})

	});
</script>
</body>
</html>