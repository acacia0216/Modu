<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>회비관리 시작페이지</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.css"> <!-- stylesheet 외부의 css 가져오겟다 -->
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/Modu.css"> 
	<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css">
	
	<style type="text/css">
		::-webkit-scrollbar {
			display:none;
		} 
	</style>
	
</head>
<body style="overflow-x:hidden; overflow-y:auto;">

<!-----------header------------------>

  <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

	<!----------------- container------------------->
	<div class="container">
		<div class="carousel-item active">
			<div class="carousel-caption d-none d-md-block mb-5  text-left">	
			<div class="mb-0">
				<c:if test="${gvo.manager eq authUser.userNo}">
					<h1 class="mr-5">아직,&nbsp;&ensp;&ensp;&ensp;</h1>
	                <h1 class="ml-4">회비설정을 </h1>
	                <h1 class="mb-5">안하셨나요?</h1>
	            </c:if>
            </div>
            	<c:if test="${gvo.manager eq authUser.userNo}">
					<button id="initialSetMemberfee" class="btn btn-primary btn-lg ml-5 mt-0" style="text-shadow:none; ">회비설정하기</button>
				</c:if>
				<br>
			</div>
				<c:if test="${gvo.manager eq authUser.userNo}">
               		<img class="d-block w-100" src="${pageContext.request.contextPath }/assets/images/membership3.jpg" alt="membershipsetting">
               	</c:if>
               	<c:if test="${gvo.manager ne authUser.userNo}">
               		<center>
               		
               		<div class="carousel-item active" style="height:500px;">
						<div class="carousel-caption d-none d-md-block mb-5  text-center">	
							<div style="margin-bottom:110px;">
	           
							<h4 class="mx-auto lgclick" style="color: black;text-shadow:none;" >회비내역을 </h4>
							<h4 class="mx-auto lgclick" style="color: black;text-shadow:none;"> 멤버들과 <span style="color:#00b0f0; text-shadow:none;"> 공유 </span>하는 공간입니다.</h4>
							<br>
	               			 <h4 class="mx-auto lgclick" style="color: black;text-shadow:none;"  ><span style="color:#00b0f0; text-shadow:none;">아직 회비관리가 설정되지 않았습니다. </span></h4>
	           			 </div>
					<br>
			</div>
               <img class="d-block w-100" src="${pageContext.request.contextPath }/assets/images/board1.png" alt="">
		</div>
               		
               		
               		 <%-- <img class="d-block" style="width:1000px ;height:200px; margin-bottom:300px " src="${pageContext.request.contextPath }/assets/images/board1.png" alt="membershipsetting">  --%>
               			<%-- <div class="carousel-item active bg-light" style="width:1000px ;height:600px; margin-bottom:50px;">
               				<br><br>
               				<img class="d-block" style="width:100px; height:auto; margin-top:100px; margin-bottom:50px;" src="${pageContext.request.contextPath }/assets/images/sad.png" alt="membershipsetting">
               					<div>
               					<h5 class='lgContent'  style='color:gray; font-weight:bold;'> 회비가 아직 정해지지 않았습니다,</h5>
               					<h5 class='lgContent'  style='color:gray; font-weight:bold;'> 조금더 기다려주세요</h5>
               					</div>
               			</div> --%>
               		</center>
               	</c:if>
		</div>
	</div>
	
 <!----------------- 회비 추가 (모달) ------------------->
   <div class="modal fade" id="insertMemberfee" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
               <div class="modal-header">
                 <h5 class="modal-title smTitle">회비 추가하기</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                         <span aria-hidden="true">&times;</span>
                    </button>
               </div>
               <div class="modal-body">   
                  <center>
                     <ul class="nav nav-tabs">
                     <li class="nav-item linkText">
                         <a id="byRank" style="cursor:pointer;" class="nav-link active ">등급별</a>
                       </li>
                       <li class="nav-item linkText">
                         <a id="byName" style="cursor:pointer;" class="nav-link ">회원별</a>
                       </li>       
                  </ul>                  
               </center>
               <br> 
               
               <div>
                  <div class="form-inline">
                      <label for="feeGroupName" class="col-sm-3 col-form-label smContent">모임 회비명</label> 
                     <input type="text" id="feeGroupName" class="form-control text-center mr-1 smContent" placeholder="회비명">
                     <input type='text'  id="paymentDate" style="color:gray; width:142px;border:none; background:transparent;cursor:pointer;" readonly='readonly' class='feedate datepicker form-control text-center smContent' placeholder='납부일'>
                      <label for="paymentFee" class="col-sm-3 col-form-label smContent">회비</label> 
                     <input type="text" id="paymentFee" class="form-control text-center my-1 mr-3 smContent" placeholder="회비">
                     <button id="paymentFeeSettingBtn" style="border-color: gray;background:transparent;" type="button" class="btn smContent">일괄적용</button>   
                  </div>
               </div>
               <br>
        
               <table class="table table-striped table-sm text-center my-0 smContent">
                  <thead>
                     <tr>
                        <th width="10%">
                           <div class="custom-control custom-checkbox">
                              <input type="checkbox" class="custom-control-input" id="checkAll">
                              <label class="custom-control-label" for="checkAll">&nbsp;</label>
                           </div>
                        </th>
                        <th id="RankOrName"  width="20%">등급명</th>
                        <th width="35%" >회비</th>
                     </tr>
                  </thead>
               </table>
               <div style="overflow:scroll; width:466px; height:450px;" >
                  <table class="table table-striped table-sm text-center smContent">
                     <thead>
                        <th width="10%"></th>
                        <th width="20%"></th>
                        <th width="35%"></th>
                     </thead>
                     <tbody id="insertMemberfeeContent" > 
                                                
                     </tbody>
                  </table>
               </div>            
               </div>
               <div class="modal-footer"> 
                <!--   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>      -->
                  <button type="button" id="insertMemberfeeBtn" class="btn btn-primary smContent">회비 추가</button>      
               </div>
          </div>
        </div>
   </div>
   
	<!-- 계좌설정하기 Modal -->
   <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">계좌설정하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body text-center">
            
   <ul>         
   <li>
     <label class="my-1 mr-2" for="inlineFormCustomSelectPref">입금계좌</label>
   </li>
   <li>
     <div class="form-block w-75">
      <select class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref" name="groupBank" style="width: 110px"> 
       <option selected>은행</option>
       <option value="KB국민">KB국민</option>
       <option value="신한">신한</option>
       <option value="우리">우리</option>
       <option value="KEB하나">KEB하나</option>
       <option value="케이뱅크">케이뱅크</option>
       <option value="카카오뱅크">카카오뱅크</option>
       <option value="NH농협">NH농협</option>
       <option value="수협">수협</option>
       <option value="대구">대구</option>
       <option value="BNK부산">BNK부산</option>
       <option value="BNK경남">BNK경남</option>
       <option value="광주">광주</option>
       <option value="전북">전북</option>
       <option value="제주">제주</option>
     </select>
   </div>  
   </li>
   
   </ul>
  <!-- 계좌번호  와 예금주명-->

   <div class="form-inline col-auto my-2" style="padding-left: 125px;">
    <label class="my-1 mr-2" for="">계좌번호</label>
    <input type="text" name="groupAccount" id=inputBox class="form-control w-50 text-center" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="계좌번호">
  </div>
  <div class="form-inline col-auto my-2" style="padding-left: 125px;">
    <label class="my-1 mr-2" for="">예금주명</label>
    <input type="text" name="groupAccountHolder" class="form-control w-50 text-center" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="예금주명">
  </div>

            <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
               <button type="button" class="btn btn-info" data-dismiss="modal" id="setting" >설정하기</button>
            </div>
      
         </div>
      </div>
   </div>
</div>

<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>

<script src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/header.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/locales/bootstrap-datetimepicker.ko.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath }/assets/jquery/jquery.mtz.monthpicker.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js"></script>
<script type="text/javascript">	
	
	$(document).ready( function() {	
		
		$('.menuTab').removeClass("active");
		$("#membershipfee").addClass("active");
		
		$("#initialSetMemberfee").on("click",function(){
			$("#insertMemberfee").modal('hide');
			$("#feeGroupName").val('');
			$("#paymentFee").val('');
			todayInfo();
			fetchinsertMemberfee(mode);
			$("#exampleModal").modal();
		})
		
		//회비 계좌 설정하기
		 $("#setting").on("click",function(){
	         var groupBank =$("[name=groupBank]").val();
	         var groupAccount =$("[name=groupAccount]").val();
	         var groupAccountHolder =$("[name=groupAccountHolder]").val();
       
	           $.ajax({
	                //요청할때
	                url : "${pageContext.request.contextPath }/membershipfee/${gvo.groupNo}/accountSettting",

	                type : "post",
	                data : {groupBank:groupBank, groupAccount:groupAccount, groupAccountHolder:groupAccountHolder}, 
	                //응답받을때
	                dataType : "json",
	                success : function(accountGvo) {                   
	                	$("#insertMemberfee").modal();	 
	                },
	                error : function(XHR, status, error) {
	                       console.error(status + " : " + error);
	                }
	           }); 
	      });
		
		function comma(str) {
		    str = String(str);
		    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') + "원";
		}

		//원 콤마제거
		function uncomma(str) {
		    str = String(str);
		    return str.replace(/[^\d]+/g, '');
		}
		
		//최상단 체크박스 클릭시 체크박스 전체 선택 / 전체 해제
		$("#checkAll").click(function() {
			//클릭되었으면
			if ($("#checkAll").prop("checked")) {
				//input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
				$("input[name=chk]").prop("checked", true);
			//클릭이 안되있으면
			} else {
				//input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
				$("input[name=chk]").prop("checked", false);
			}
		})
				
		//append시 datepicker 이벤트 먹지 않는 문제 발생 - datepicker 이벤트 제거후 재 실행
		function datepickerReset() {
			$(document).find(".datepicker").removeClass('hasdatepicker').datepicker();

			$.datepicker.setDefaults({
				prevText : '이전 달',
				nextText : '다음 달',
				monthNames : [ 	'1월', '2월', '3월', '4월',
								'5월', '6월', '7월', '8월', '9월',
								'10월', '11월', '12월' ], //월 이름
				monthNamesShort : [ '1월', '2월', '3월', '4월',
									'5월', '6월', '7월', '8월', '9월',
									'10월', '11월', '12월' ], //
				dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				showMonthAfterYear : true,
				yearSuffix : '년',
				changeMonth : true,
				changeYear : true,
				dateFormat : "yy년 mm월 dd일"
			});
		}
		
		var mode = "byRank";
		
		$("#paymentFee").on("focusin",function(){
			var paymentFee = $(this).val();		
			$(this).val(uncomma(paymentFee));
		})
		
		$("#paymentFee").on("focusout",function(){
			var regexp = /^[0-9]*$/;
			var paymentFee = $(this).val();
			if( !regexp.test(paymentFee) ) {
				alert("숫자만 입력하세요");
				$(this).val('');
			}else{
				$(this).val(comma(paymentFee));
			}
		})
				
		$("#insertMemberfeeContent").on("focusin",".fee",function(){
			var paymentFee = $(this).val();		
			$(this).val(uncomma(paymentFee));
		})
		
		$("#insertMemberfeeContent").on("focusout",".fee",function(){
			var regexp = /^[0-9]*$/;
			var paymentFee = $(this).val();
			if( !regexp.test(paymentFee) ) {
				alert("숫자만 입력하세요");
				$(this).val('0');
			}else{
				$(this).val(comma(paymentFee));
			}
		})

		//오늘 날짜 납부일에 삽입
		function todayInfo(){
			var today = new Date();
			var yyyy = today.getFullYear();
			var mm = today.getMonth() + 1;
			if(mm<10){
				mm = '0'+mm;
			}
			var dd = today.getDate();
			if(dd<10){
				dd = '0'+dd;
			}

			var todayInfo = yyyy + "년 " + mm + "월 " + dd + "일";
			$("#paymentDate").val(todayInfo);	
		}
		
		//회원별 등급별 탭 활성화
		$(".nav-link").on("click",function(){
			var navTab = $(this).attr("id");
			if(navTab == "byRank"){
				$("#byName").removeClass("active");
				$(this).addClass("active");
				$("#RankOrName").html("등급명");
				mode = "byRank";
				$("#checkAll").prop("checked",false);
				fetchinsertMemberfee(mode);		
			}else{
				$("#byRank").removeClass("active");
				$(this).addClass("active");
				$("#RankOrName").html("회원명");
				mode = "byName";
				$("#checkAll").prop("checked",false);
				fetchinsertMemberfee(mode);		
			}
		})
				
		//회원별 등급별 리스팅
		function fetchinsertMemberfee(mode){
			$.ajax({
				url : "${pageContext.request.contextPath }/membershipfee/${gvo.groupNo}/getinsertmemberfeelist",
				type : "post",
				//contentType : "application/json",
				data : { 
					mode : mode
				},
				dataType : "json",
				success : function(memberfeeList) {
					$("#insertMemberfeeContent").empty();
					
					for (var i = 0; i < memberfeeList.length; i++) {
						insertMemberfeeRendner(memberfeeList[i],mode);
					}
					
					datepickerReset();
				},
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
			});
		}
		
		function insertMemberfeeRendner(memberfeeVo,mode){
	
			var str = "";

			if(mode == "byRank"){
				str += "<tr id='" + memberfeeVo.rankNo +"'>";
			}else{
				str += "<tr id='" + memberfeeVo.user_groupNo +"'>";
			}
			str += "<td>"							
			str += "<div class='custom-control custom-checkbox'>";	
			if(mode == "byRank"){
				str += "<input type='checkbox' class='custom-control-input' id='customCheck" + memberfeeVo.rankNo + "' name='chk' tabindex='-1'>";
				str += "<label class='custom-control-label' style='margin-top: 7px' for='customCheck" + memberfeeVo.rankNo + "'>&nbsp;</label>";
			}else{
				str += "<input type='checkbox' class='custom-control-input' id='customCheck" + memberfeeVo.user_groupNo + "' name='chk' tabindex='-1'>";
				str += "<label class='custom-control-label' style='margin-top: 7px' for='customCheck" + memberfeeVo.user_groupNo + "'>&nbsp;</label>";	
			}
			str += "</div>"
			str += "</td>"
			if(mode == "byRank"){
				str += "<td><p style='margin-top: 7px'>" + memberfeeVo.rankName +"</p></td>"
			}else{
				str += "<td><p style='margin-top: 7px'>" + memberfeeVo.userName +"</p></td>"
			}
			if(mode == "byRank"){
				str += "<td><input type='text' id='fee" + memberfeeVo.rankNo + "' class='fee form-control text-center' value='0'></td>"
			}else{
				str += "<td><input type='text' id='fee" + memberfeeVo.user_groupNo + "' class='fee form-control text-center' value='0'></td>"
			}
			str += "</tr>"

			$("#insertMemberfeeContent").append(str);	

		}
		
		//회비 추가
		$("#insertMemberfeeBtn").on("click",function(){
			var feeGroupName = $("#feeGroupName").val();
			var paymentDate = $("#paymentDate").val();				
			var trLength = $('#insertMemberfeeContent tr').length;
			var data = "";
			
			for(var i=0;i<trLength;i++){
				data += "," + $('#insertMemberfeeContent tr').eq(i).attr("id");
				data += "," + $('#insertMemberfeeContent tr p').eq(i).html();
				data += "," + uncomma($('#insertMemberfeeContent tr .fee').eq(i).val());
			}
			insertMemberfee(feeGroupName,data,mode,paymentDate);
			$("#insertMemberfee").modal("hide");	
			
		})
		
		function insertMemberfee(feeGroupName,data,mode,paymentDate){
			$.ajax({
				url : "${pageContext.request.contextPath}/membershipfee/${gvo.groupNo}/insertmemberfee",
				type : "post",
				//contentType : "application/json",
				data : {
					data : data,
					feeGroupName : feeGroupName,
					mode : mode,
					paymentDate : paymentDate
				},
				dataType : "json",
				success : function(result) {
					console.log(result);
					if(result == 'fail'){
						alert("회비명이 중복되었습니다.");
					}else{
						location.replace('${pageContext.request.contextPath }/membershipfee/${authUser.groupNo}/feemanage');
					}	
				},
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
			});
		}
		
		$("#paymentFeeSettingBtn").on("click",function() {
			var paymentFee = $("#paymentFee").val();
			$('input:checkbox[name=chk]').each(function() {
	        	if($(this).is(':checked')){
	        		var feeNo = $(this).closest("tr").attr("id");
	        		$("#fee"+feeNo).val(paymentFee);
	        	}
	      	});
		});
		
	});

	</script>
	
</body>
</html>