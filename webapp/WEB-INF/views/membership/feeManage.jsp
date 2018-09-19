<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta charset="UTF-8">
   <title>회비 관리</title>
   <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.css"> <!-- stylesheet 외부의 css 가져오겟다 -->
   <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
   <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/Modu.css"> 
   <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css">
   
   <style type="text/css">
      ::-webkit-scrollbar {
         display:none;
      } 

 .modal-dialog .modal-fullsize {
   width: 1000px;
   height: 800px;
   margin: 0;
   padding: 0;
   padding-right:15%;
}

.modal-content .modal-fullsize {
   height: auto;
   min-height: 100%;
   border-radius: 0;
} 

/* .modal .modal-center { 
   text-align: center; 
} */


/* @media screen and (min-width: 768px) { 
        .modal:before {
                display: inline-block;
                vertical-align: middle;
                content: " ";
                height: 100%;
        }
} */
 
/* .modal-dialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
}
 */

      
   </style>
   
</head>
<body style="overflow-x:hidden;overflow-y:auto;">

<!-----------header------------------>
  <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

   <div class="container" style="min-height:650px;">
     <div class="text-center mt-4 mb-1">
        <h4 class="lgTitle">회비관리</h4>
      </div>
      <center>
         <div class="form-inline feemanage col-8 mt-2" id="fix">
            <input type="hidden" id="groupManager" value="${gvo.manager}">
            <input type="hidden" id="userNo" value="${authUser.userNo}">
            <div class="form-inline">
	           <table class="table table-sm table-light border text-center" style="margin-top:15px;margin-left:150px; width: 500px">
	               <tr>
	                  <td class="border border-primary rounded-left lgclick" style="background:#99CAFF; " >모임 계좌</td>
	                  <td class="border border-secondary lgclick" style="color:gray">${gMembershipfee.groupBank} ${gMembershipfee.groupAccount}</td>
	                  <td class="border border-primary lgclick" style="background:#99CAFF;">계좌 주인</td>
	                  <td class="border rounded-right border-secondary lgclick" style="color:gray">${gMembershipfee.groupAccountHolder}</td>
	               </tr>            
	            </table> 
            </div>
           
            <c:if test="${gvo.manager eq authUser.userNo}">
	            <div style="margin-left:0px;"> 
	                 <button class="btn mx-2" style="border:none;background: transparent;" data-toggle="modal" data-target="#exampleModal">
	                  		<img alt="" src="${pageContext.request.contextPath }/assets/images/more01.png" style="width:20px;height:20px;">
	                  	</button>
	                  <div style="clear:both;"></div>
	            </div>
            </c:if>     
         </div>
         
         <div id="memberfeeCardList" class="form-inline">
         
         </div>
            
         </center>
</div>

<!-- 회비 추가하기 설명 -->
<div class="modal modal-center fade" tabindex="-1" role="dialog" id="MemberfeeEx" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-fullsize" role="document">
    <div class="modal-content modal-fullsize">
      <div class="modal-header">
       <h5 class="modal-title smTitle">회비 추가하는 방법</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <img alt="" style="width:100%;height:100%;" src="${pageContext.request.contextPath }/assets/images/membershipEx01.png">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
       <!--  <button type="button" id='insertMemberfeeBtn' class="btn btn-primary">회비추가 하러가기</button> -->
      </div>
    </div>
  </div>
</div>

   <!----------------- 회비 상세보기 (모달) ------------------->
   <div class="modal fade" id="memberfeeDetail" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
               <div class="modal-header">
                 <h5 class="modal-title smTitle">회비 상세내역</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                         <span aria-hidden="true">&times;</span>
                    </button>
               </div>
               <div class="modal-body">   
                  <table class="table table-striped table-sm text-center smContent">
                  <thead>
                     <tr>
                        <th>회원명</th>
                        <th>회비</th>
                        <th colspan="2">납부 상태</th>
                     </tr>
                  </thead>
                  <tbody id="memberfeeDetailContent">
            
                  </tbody>
               </table>            
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>
          </div>
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
               <h5 class="modal-title smTitle" id="exampleModalLabel">계좌설정하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body text-center">
   <ul>         
   <li>
     <label class="smContent my-1 mr-2" for="inlineFormCustomSelectPref">입금계좌</label>
   </li>
   <li>
     <div class="form-block w-75 smContent">
      <select class="custom-select my-1 mr-sm-2 smContent" id="inlineFormCustomSelectPref" name="groupBank" style="width: 110px"> 
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
    <label class="smContent my-1 mr-2" for="">계좌번호</label>
    <input type="text" name="groupAccount" id=inputBox class="form-control w-50 text-center smContent" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="계좌번호">
  </div>
  <div class="form-inline col-auto my-2" style="padding-left: 125px;">
    <label class="my-1 mr-2 smContent" for="">예금주명</label>
    <input type="text" name="groupAccountHolder" class="form-control w-50 text-center smContent" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="예금주명">
  </div>

            <div class="modal-footer">
              <!--  <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button> -->
               <button type="button" class="btn btn-info smContent" data-dismiss="modal" id="setting" >설정하기</button>
            </div>
      
         </div>
      </div>
   </div>
</div>
<!----------------- footer------------------->      
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
      
      var manager = $("#groupManager").val();
      var authUserNo = $("#userNo").val();
      
      //원 콤마찍기
      function comma(str) {
          str = String(str);
          return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') + "원";
      }

      //원 콤마제거
      function uncomma(str) {
          str = String(str);
          return str.replace(/[^\d]+/g, '');
      }
      
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
                    $("#fix").empty();
       
                    var str='';
                    
                    str+='<input type="hidden" id="groupManager" value="${gvo.manager}">';
	             	str+='<input type="hidden" id="userNo" value="${authUser.userNo}">';
	            	str+='<div>';
	              	str+='<table class="table table-sm table-light border text-center" style="margin-top:15px;margin-left:150px; width: 500px">';
	            	str+='<tr>';
	               	str+='<td class="border rounded-left border-primary lgclick" style="background:#99CAFF; " >모임 계좌</td>';
	            	str+='<td class="border border-secondary lgclick" style="color:gray">' +accountGvo.groupBank+' '+accountGvo.groupAccount +'</td>';
                   	str+='<td class="border border-primary lgclick" style="background:#99CAFF; ">계좌 주인</td>';
                  	str+='<td class="border rounded-right border-secondary lgclick" style="color:gray">'+accountGvo.groupAccountHolder+'</td>';     
                    str+='</tr>';       
                    str+='</table>';
                    str+='</div>';
                          
                    str+='<c:if test="${gvo.manager eq authUser.userNo}">';
                    str+='<div style="margin-left:0px;"> ';
                    str+='<button class="btn mx-2" style="border:none;background: transparent;" data-toggle="modal" data-target="#exampleModal">';
                    str+='<img alt="" src="${pageContext.request.contextPath }/assets/images/more01.png" style="width:20px;height:20px;">';
                    str+='</button>';
                    str+='<div style="clear:both;"></div>';
                    str+='</div>';
                    str+='</c:if>';

                    $("#fix").append(str);     
                   },
                   error : function(XHR, status, error) {
                          console.error(status + " : " + error);
                   }
              }); 
         });
      
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
            monthNames : [    '1월', '2월', '3월', '4월',
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
      
      //모임 회비카드 리스팅
      fetchMemberfeeCardList();
      
      function fetchMemberfeeCardList() {
         $.ajax({
            url : "${pageContext.request.contextPath }/membershipfee/${gvo.groupNo}/getmemberfeecardlist",
            type : "post",
            //contentType : "application/json",
            //data : { },
            dataType : "json",
            success : function(memberfeeCardList) {
               $("#memberfeeCardList").empty();
               
               if(authUserNo == manager){
                  CardInsertRender();
               }
               
               for (var i = 0; i < memberfeeCardList.length; i++) {
                  MemberfeeCardRender(memberfeeCardList[i]);
               }
            },
            error : function(XHR, status, error) {
               console.error(status + " : " + error);
            }
         });
      }
      
       
      //모임 회비 추가 카드 그리기
      function CardInsertRender() {   
         var str = "";

         str += "<div class='card border-secondary bg-light my-2 mx-1' style='width: 302px; height: 180px;border-top-width: 7px;border-left: none;border-right: none;'>";
         str += "<div class='card-body'>" 
         str += "<button id='insertMemberfeeBtn' class='btn btn-outline-primary btn-lg smContent mr-2' style='margin-top:50px;' value=''>회비 추가</button>";
         str += "<button id='MemberfeeExBtn' class='btn btn-outline-secondary btn-lg  smContent' style='margin-top:50px;' value=''>회비 추가 설명</button>";
         str += "</div>"                  
         str += "</div>";

         $("#memberfeeCardList").append(str);
      }
      
      //모임 회비 확인 카드 그리기
      function MemberfeeCardRender(memberfeeCardList) {   
         var str = "";

         str += "<div class='card bg-light my-2 mx-1' style='width: 302px; height: 180px;border-top-width: 7px;border-color: #99CAFF;border-left: none;border-right: none;'>";
         str += "<div class='card-body'>"                         
         str += "<h5 class='card-title'></h5>"
         str += "<h6 class='card-subtitle mb-2 text-muted'></h6>"
         str += "<p class='card-text smTitle'>" + memberfeeCardList.feeGroupName +"</p>"
         str += "<font  size='2'class='smItem'>납부현황 : " + comma(memberfeeCardList.paymentAmount) + " / " + comma(memberfeeCardList.paymentFee) + "<br>";
         str += "납부일 : " + memberfeeCardList.paymentDay + "</font>"+ "<br>"+ "<br>";
         if(authUserNo == manager){
            str += "<button id='memberfeeCheckBtn' class='btn mx-1 btn-outline-primary smContent' value='" + memberfeeCardList.feeGroupName + "'>확인</button>";
         }else{
            str += "<center><button id='memberfeeCheckBtn' class='btn mx-1 w-100  btn-outline-primary smContent smContent' value='" + memberfeeCardList.feeGroupName + "'>확인</button></center>";
         }
         if(authUserNo == manager){
            str += "<button id='memberfeeDeleteBtn' class='btn btn-outline-secondary mx-1 smContent' value='" + memberfeeCardList.feeGroupName + "'>삭제</button><br>";
         }
         str += "</div>"                  
         str += "</div>";

         $("#memberfeeCardList").append(str);
      }

      //모임 회비 상세 내역 모달 팝업 및 리스팅
      $("#memberfeeCardList").on("click","#memberfeeCheckBtn",function() {
         $("#memberfeeDetail").modal();
         var feeGroupName = $(this).val();
         fetchMemberfeeList(feeGroupName);
      });
      
      //모임 회비 상세 리스트 ajax
      function fetchMemberfeeList(feeGroupName) {
         $.ajax({
            url : "${pageContext.request.contextPath }/membershipfee/${gvo.groupNo}/getmemberfeelist",
            type : "post",
            //contentType : "application/json",
            data : {    
               feeGroupName : feeGroupName      
            },
            dataType : "json",
            success : function(memberfeeList) {
               $("#memberfeeDetailContent").empty();

               for (var i = 0; i < memberfeeList.length; i++) {
                  MemberfeeListRender(memberfeeList[i]);
               }
            },
            error : function(XHR, status, error) {
               console.error(status + " : " + error);
            }
         });
      }
      
      //모임 회비 상세 리스트 그리기
      function MemberfeeListRender(memberfeeVo) {      
         var str = "";

         str += "<tr id='" + memberfeeVo.memberfeeNo + "'>";
         str += "<td>" + memberfeeVo.userName + "</td>"                         
         str += "<td>" + comma(memberfeeVo.paymentFee) + "</td>"
         if(memberfeeVo.paymentFee <= memberfeeVo.paymentAmount){
            if(authUserNo == manager){
               str += "<td style='color:blue'>완료</td>"
               str += "<td><img src='${pageContext.request.contextPath}/assets/images/good01.png'></td>"
            }else{
               str += "<td colspan='2' style='color:blue'>완료</td>"
            }
         }else{
            if(authUserNo == manager){
               str += "<td name='" + memberfeeVo.memberfeeNo + "' style='color:red'>미납</td>";
               str += "<td id='notyetBtn'><button id='rcvMemberfeeBtn' class='btn btn-sm smContent' style='border-color: gray;background:transparent;'  value='" + memberfeeVo.paymentFee + "'>확인</button></td>"   
            }else{
               str += "<td colspan='2' name='" + memberfeeVo.memberfeeNo + "' style='color:red'>미납</td>";
            }                     
         }         
         str += "</tr>";

         $("#memberfeeDetailContent").append(str);
      }
      
      //회비 납부 확인 버튼
      $("#memberfeeDetailContent").on("click","#rcvMemberfeeBtn",function() {
         var paymentFee = $(this).val()
         var memberfeeNo = $(this).closest("tr").attr("id");
         rcvMemberfee(paymentFee,memberfeeNo);
         $("#memberfeeDetailContent [name=" + memberfeeNo + "]").replaceWith("<td style='color:blue'>완료</td>");
         $(this).closest("#notyetBtn").replaceWith("<td><img src='${pageContext.request.contextPath}/assets/images/good01.png'></td>");
         fetchMemberfeeCardList();
      });
      
      function rcvMemberfee(paymentFee,memberfeeNo){
         $.ajax({
            url : "${pageContext.request.contextPath }/membershipfee/${gvo.groupNo}/rcvmemberfee",
            type : "post",
            //contentType : "application/json",
            data : { 
               paymentFee : paymentFee,
               memberfeeNo : memberfeeNo
            },
            //dataType : "json",
            success : function() {               
            },
            error : function(XHR, status, error) {
               console.error(status + " : " + error);
            }
         });
      }
      
      var mode = "byRank";
      
      //회비 추가 버튼 클릭시
      $("#memberfeeCardList").on("click","#insertMemberfeeBtn",function() {
    	 $("#checkAll").prop("checked", false);
         $("#feeGroupName").val('');
         $("#paymentFee").val('');
         $("#insertMemberfee").modal();   
         todayInfo();
         fetchinsertMemberfee(mode);      
      });
      
      $("#memberfeeCardList").on("click","#MemberfeeExBtn",function() {
    	  
         $("#MemberfeeEx").css("right", "30%").modal();
      });
      
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
            str += "<td><input type='text' id='fee" + memberfeeVo.rankNo + "' class='fee form-control text-center smContent' value='0'></td>"
         }else{
            str += "<td><input type='text' id='fee" + memberfeeVo.user_groupNo + "' class='fee form-control text-center smContent' value='0'></td>"
         }
         str += "</tr>"

         $("#insertMemberfeeContent").append(str);   
         
         datepickerReset();
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
                  fetchMemberfeeCardList();
               }   
            },
            error : function(XHR, status, error) {
               console.error(status + " : " + error);
            }
         });
      }
      
      //회비 삭제
      $("#memberfeeCardList").on("click","#memberfeeDeleteBtn",function() {
         deleteMemberfee($(this).val())
      });
      
      function deleteMemberfee(feeGroupName){
         $.ajax({
            url : "${pageContext.request.contextPath}/membershipfee/${gvo.groupNo}/deletememberfee",
            type : "post",
            //contentType : "application/json",
            data : {
               feeGroupName : feeGroupName
            },
            //dataType : "json",
            success : function() {
               fetchMemberfeeCardList();
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