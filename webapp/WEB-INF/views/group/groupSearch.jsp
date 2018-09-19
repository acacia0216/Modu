<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>그룹 첫 페이지</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.css"> <!-- stylesheet 외부의 css 가져오겟다 -->
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/Modu.css"> <!-- stylesheet 외부의 css 가져오겟다 --> 
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap-datetimepicker.min.css">
</head>
<style type="text/css">
  .dom{
     position: relative;
}

.card-img-overlay{
display: none;
background-image: url('${pageContext.request.contextPath }/assets/images/over.png');background-repeat: no-repeat; 
background-size: cover;
background-position: top;
position: absolute; 
top:0px;left: 16%;margin-left: -50px; 
width:320px;
border-radius:2px;
}

.kkk{
display: none;
cursor: hand;
filter:alpha(opacity=1);
position: absolute;
top:50%;left: 22%;z-index: 100;


}

.dom:hover .card-img-overlay {
   display: block;
   cursor: pointer;
} 
.dom:hover .btn{
   display: block;
   cursor: pointer;
} 



 
</style>
<body style="overflow-x:hidden; overflow-y:auto;">

<!-----------header------------------>
  <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
  
  <div class="container">
		<div class="text-center mt-5 searchresult">		      
		<h3 class="lgTitle my-2">‘${param.gSearch}’ 으(로) 검색한 결과입니다.</h3>
	</div>
	<%-- <c:if test="${gName ne null }">
	<div class="text-center mt-5 search" style="font-weight:400px;color: red; ">		
	<h5>${gName.groupName} 신청하였습니다. 승인이되면, 카테고리에서 볼 수 있습니다. </h5>
	</div>
	</c:if> --%>
	<div class="text-left mt-5 searchlist">	

		<ul class="domm mt-5 p-0">
		<!-- 생각해보기 !!! -->
		<c:forEach items="${searchList}" var="Sea">

			
             <li class="dom" >
             <input type="hidden" name="isJoin" value="${Sea.isJoin}">
             <input type="hidden" name="groupNo" value="${Sea.groupNo}">
             
          
           <div class="card  mb-3 text-center mx-4 p-2 " style="width: 20rem;" id="${Sea.groupNo}">
               <div class="card-img" >
                  <img class="card-img-top " src="${pageContext.request.contextPath }/upload/${Sea.groupImg}" style="height:201.33px;"  alt="Card image cap">&nbsp;
                  <div class="over text-center " >
                  </div>
               </div>
               <div>
                  <h4 class="card-title mt-3 smTitle" style="width: 262px;height: 34px;">${Sea.groupName}</h4>
               </div>
               <div class="card-body">
                  <p class="card-text smContent" style="width: 262px;height: 50px;">${Sea.groupExplain}</p>
               </div>
             </div>  
         </li>
			</c:forEach>
						
		</ul>
	</div>
</div>
  
  

<!----------------- footer------------------->		
<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>

<!--신청하기 Modal -->
   <div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered" role="document">
       <div class="modal-content">
         <div>
           <button type="button" class="close mr-2" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="form-group text-center mx-5 introduce">
             <label for="introduce">가입 신청 메세지</label>
             <textarea class="form-control" id="joinMessage" rows="3" name="joinMessage" placeholder="글을 입력해주세요."></textarea>
             <input type="hidden" id="giveNo" name="groupNo" value="">
             <input type="hidden" name="gSearch" id="gSearch" value="${param.gSearch}">
           </div>
         <div class="text-center mb-3">
           <button class="btn btn-primary" type="submit" value="" id="joinManagecheck">신청하기</button>
         </div>
       </div>
     </div>
   </div>
	
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>

<script type="text/javascript">
$(document).ready( function() {   

	 $('.domm').on("click","li",function(){

	    console.log("연결");
	   var groupNo = $(this).find("[name=groupNo]").val()
	   console.log(groupNo);
	    $("#giveNo").val(groupNo); 
	   
	   
	});
	 

	   $('.domm').on("mouseenter","li",function(){
	      console.log("연결되라");
	     
	      console.log( $(this).find("[name=isJoin]").val());
	      
	      
	    var str ="";
	    str +="<img class='card-img-overlay  mr-1' src='' style=''   >"; 
	    
	     
	    if(  $(this).find("[name=isJoin]").val() == 'yes' ){
	       str +="<button type='button' style=' background:transparent; font-size: 15px;color: white' class='kkk btn btn-light btn-lg'>이미가입한 모임입니다</button>";
	    } else if( $(this).find("[name=isJoin]").val() == 'ing'){
	       str +="<button type='button' style=' background:transparent; font-size: 15px;color: white' class='kkk btn btn-light btn-lg'>가입대기중입니다.</button>";
	    } else{
	       str +="<button type='button' value='${Sea.groupNo}' name='join' class='kkk btn btn-outline-light btn-lg ml-2' data-toggle='modal' data-target='#exampleModalCenter2'>모임 신청하기</button>";
	    } 
	    
	    $(".over").prepend(str);
	    
	    
	    
	 });  
	  

	  
	   $('.domm').on("mouseleave","li",function(){
	     $(".over").empty();
	 }); 
	   
	   $("#joinManagecheck").on("click",function(){
	      
	      var joinMessage = $("#joinMessage").val();
	      var groupNo = $("#giveNo").val();
	      var gSearch = $("#gSearch").val();
	      
	      console.log(joinMessage,groupNo,gSearch);
	      
	      $.ajax({
	           url: "${pageContext.request.contextPath }/joinGroup",
	           type: "post",
	           data: {joinMessage:joinMessage, groupNo:groupNo, gSearch:gSearch},

	           dataType: "json",
	           success: function (no) {
	               if (no == 1) {
	                  alert("모임 신청이 완료되었습니다. 승인이되면, 모임카테고리에서 확인할 수 있습니다.");
	                  location.href = "${pageContext.request.contextPath }/main";
	               }
	                  
	           }, error: function (request, status, error) {
	               console.error(request, status, error);
	               alert("통신 실패");
	           }
	       });
	      
	      
	     
	   });
	     

	});
</script>
</body>
</html>