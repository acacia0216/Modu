<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta charset="UTF-8">
   <title>모임관리</title>
   <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.css"> <!-- stylesheet 외부의 css 가져오겟다 -->
   <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
   <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/Modu.css"> <!-- stylesheet 외부의 css 가져오겟다 --> 
</head>
<body style="overflow-x:hidden; overflow-y:auto;">


<!-----------header------------------>
   
<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
   

   <div class="container">
      <div class="text-center my-4">
         <h4 class="lgTitle">모임관리</h4>
      </div>
      <center>
        <!--  <div class="col-5 my-5">
            <h1 class="mt-4 lgbanner">모임관리</h1>
         </div> -->
         <div class="col-9 my-3">
            <table class="table table-striped text-center" id="myList">
               <thead class="lgContent">
                  <tr>
                     <th>가입신청자</th>
                     <th>자기소개</th>
                     <th>수락/거절</th>
                  </tr>
               </thead>
               <tbody id="applyList" class="smContent">
               <!-- 가입신청자 -->
               <c:forEach items="${joinList}" var="user">
                  <tr>
                     <td>${user.userName}</td>
                     <td>${user.joinMessage}</td>
                     <td class="check">
                        <button class="btn btn-sm btn-outline-primary mr-2 " id="${user.user_groupNo}"  name="0" value="${user.userName}" data-toggle="modal" data-target="#exampleModalAccept">수락</button>
                        <button class="btn btn-sm btn-outline-secondary" id="${user.user_groupNo }" name="1" value="${user.userName}" data-toggle="modal" data-target="#exampleModalFire">거절</button>
                     <%--    <input type="hidden" name="user_groupNo" value="${user.user_groupNo }"> --%>
                     </td>
                  </tr>
               </c:forEach>
               
                 <c:if test="${empty joinList}">
               <tr>
               <td></td>
               <td>가입신청자가 없습니다. </td>
               <td></td> 
               </tr>
               </c:if>  
               </tbody>
            </table>
         </div><br>
            
            <!-- 회원명단  -->
         <div class="col-4 float-left mt-3" style="margin-left: 15%">
            <table class="table table-striped text-center" id="myUserList">
               <thead class="lgContent">
                  <tr>
                     <th colspan="2">회원 명단</th>
                  </tr>
               </thead>
               <tbody class="del smContent" id="userList">
               <c:forEach items="${selectUserList }" var="userList">
               <c:choose>
               <c:when test="${userList.userNo eq gvo.manager }">
                  <tr>
                     <td>${userList.userName }</td>
                     <td>
                         <button class="selRank btn btn-sm btn-outline-dark" id="selRank" style='width:100px;' value="${userList.user_groupNo }" name="${userList.groupNo }" data-toggle="modal" data-target="#exampleModal5">${userList.rankName}</button>  
                        <input type="button" class="btn btn-sm btn-outline-secondary"  style="width: 134px;" value="총무">
                     </td>
                  </tr>
               </c:when>
               
               <c:otherwise>
                     <tr id="${userList.userNo }">
                        <td>${userList.userName }</td>
                        <td class="">
                           <button class="selRank btn btn-sm btn-outline-dark" id="" style='width:100px;' value="${userList.user_groupNo }"  name="${userList.groupNo }" data-toggle="modal" data-target="#exampleModal5">${userList.rankName }</button>
                           <button class="huu btn btn-sm btn-outline-danger mr-2" id="huu" name="${userList.user_groupNo }" data-toggle="modal" data-target="#exampleModal">추방</button>  
                           <button class="cho1 btn btn-sm btn-outline-info" id="${userList.userNo }" value="${userList.groupNo }" data-toggle="modal" data-target="#exampleModal2">총무위임</button>
                        </td>
                     </tr>
                    </c:otherwise>
               </c:choose>   
               </c:forEach>   
                  
               </tbody>
            </table>
         </div><br><br>

           <form  action="${pageContext.request.contextPath }/groupModify" method="post"  enctype="multipart/form-data">
            <div class="col-5 float-right mt-3" style="margin-right: 8%">
               <h5 class="mb-3 smTitle">모임 정보 수정</h5><br>
                   
               <label class="lgContent" for="gname1">모임 이름</label>
               <input type="text" class="smContent form-control w-75 " value="${gvo.groupName }" aria-label="Large" aria-describedby="inputGroup-sizing-sm" id="gname1" name="groupName"><br>
               <label for="gtag1" class="lgContent">모임 설명, 해시태그</label>
               <textarea class="smContent form-control w-75 " rows="3" aria-label="Large" aria-describedby="inputGroup-sizing-sm" id="gtag1" name="groupExplain" >${gvo.groupExplain }</textarea>
               <input type="hidden" name="groupNo" value="${authUser.groupNo }">
   
               
                  <div class="form-group p-2 w-75 mt-4" style="position: relative;">
                        <input type="file" name="file" class="custom-file-input" id="boardUpload2" multiple="true" onchange="loadFile2(event);">
                        <input type="hidden" name="groupImg" value="${gvo.groupImg}">
                        <label class="custom-file-label text-center pr-5 smContent" for="boardUpload2" >이미지 업로드 &emsp;</label> 
                           <img id="addImg2"  name="groupImg"  src="" class="w-100 mx-auto mt-3">
                     </div>
            </div>
            <div style="clear:both;"></div><br>
   
            <button class="btn btn btn-primary mr-4" data-toggle="modal" data-target="#exampleModal3">&ensp;초대용 링크 생성&ensp;</button>
            <input type="submit" class="btn btn btn-secondary" data-toggle="modal" data-target="#exampleModal4" style="width: 134px;"  value="저장하기">
          </form>

      </center>


   </div><br>
   <!----------------- footer------------------->      
    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    
    <!-- 수락하기 Modal -->
   <div class="modal fade" id="exampleModalAccept" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title smTitle" id="exampleModalLabel">확인</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body smContent">
               수락이 완료되었습니다.
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-dismiss="modal" id="accept">확인</button>
            </div>
         </div>
      </div>
   </div>
   <!-- 거절하기 Modal -->
   <div class="modal fade" id="exampleModalFire" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title smTitle" id="exampleModalLabel">확인</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body smContent">
               거절이 완료되었습니다.
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-dismiss="modal" id="reject">확인</button>
            </div>
         </div>
      </div>
   </div>
   
    <!-- 등급 Modal -->
   <div class="modal fade" id="exampleModal5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title smTitle" id="exampleModalLabel">등급 설정하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
            <table class="table table-striped text-center smContent" id="">
               <thead>
                  <tr>
                     <th style="width:40px;">회원등급</th>
                     <th >등급 설명</th>
                     <th >설정/삭제</th>
                  </tr>
               </thead>
            
               <tbody class="rankUser" id="rankUser">
             <!--<tr>
                     <td><input type="text" class="text-center"  style="border:none;background-color:transparent;width: 100px;" value="골드"></td>
                     <td><textarea class="text-center" style="border:none;background-color:transparent;" rows="3" id="" name="" >등급설명등급설명등급설명등급설명v등급설명</textarea></td>
                     <td>
                     <button type="submit" class="btn btn-secondary btn-sm">확인</button>&nbsp;
                     <button type="button" class="btn btn-danger btn-sm">삭제</button>
                     </td>
                  </tr> -->
               </tbody>   
               
            </table>
                <div class="form-inline">
               <input type="text" name="rankName" class="form-control w-25 smContent" value="" placeholder="등급명">&nbsp;&nbsp;
               <input type="text" name="rankExplain" class="form-control w-50 smContent" value=""  placeholder="등급설명">&nbsp;&nbsp;
               <button type="submit" class="btn btn-info btn-sm smContent" id="plusRank">추가하기</button>
               </div>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
            </div>
         </div>
      </div>
   </div>

   <!-- 추방하기 Modal -->
   <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">경고</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
               정말 추방하시겠습니까? 
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
               <button type="button" class="btn btn-danger" id="delUser" value="">추방하기</button>
            </div>
         </div>
      </div>
   </div>
   <!-- 총무위임  Modal -->
   <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">확인</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
               총무로 위임이 됩니다. 총무로 위임하시겠습니까?
            </div>
            <form action="${pageContext.request.contextPath }/updateMana" method="post" >
            <div class="modal-footer">
               <input type="button" class="btn btn-secondary" data-dismiss="modal" value="취소하기">
               <input type="submit" class="afterMana btn btn-info" id="afterMana" value="위임하기">
               <input type="hidden"  id="afterMana1" name="userNo" value="">
               <input type="hidden" id="afterMana2" name="groupNo" value="">
            </div>
            </form>
         </div>
      </div>
   </div>
   <!-- 초대용 링크생성  Modal -->
   <div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">초대용 링크 생성</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
                  초대용 링크가 복사되었습니다.
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
            </div>
         </div>
      </div>
   </div>
   <!-- 초대용 링크생성  Modal -->
   <div class="modal fade" id="exampleModal4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">확인</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
                  변경사항이 저장되었습니다.
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
            </div>
         </div>
      </div>
   </div>
   <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
   <script src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
   <script type="text/javascript">
   
 		//내비바 메인 탭 활성화
 		$('.menuTab').removeClass("active");
 		$("#groupManage").addClass("active");
      
      /*  이미지 미리보기 , 확장자 체크  */      

   var loadFile = function(event) {
        var addImg = document.getElementById('addImg');
        addImg.src = URL.createObjectURL(event.target.files[0]);

        var fileName = $("#boardUpload").val();

        fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
        console.log(fileName);
        if (fileName != "jpg" && fileName != "png" && fileName != "gif" && fileName != "bmp") {

            alert("이미지 파일은 (jpg, png, gif, bmp) 형식만 등록 가능합니다.");

            $("#boardUpload").val('');
            $("#addImg").hide();

            /*$('#boardUploadModal').modal('hide');*/

        } else {
            $("#addImg").show();
        }

    };
    
     $('#accept').click(function() {
        location.reload();
    });
    
    $('#reject').click(function() {
        location.reload();
    });
 
      
    //가입신청자 거절하기 수락하기 
    $('.check').on("click","button",function(){
       
       
       var joinState = $(this).attr("name")
       var user_groupNo =$(this).attr("id")
       var userName = $(this).val();
       console.log(userName);
       console.log("joinState");
       
       
       $.ajax({
               //요청할때
               url : "${pageContext.request.contextPath }/check", 
               type : "post",
               data : {joinState:joinState,user_groupNo:user_groupNo,userName:userName},  
               dataType : "json",
               success : function(List) {
                      console.log("성공");
                      
                      
                $("#userList").empty();
               
                
               $.each(List,  function(index, vo) { 
                      var str="";
                      
                      
                      if(vo.userNo == ${gvo.manager }){

                        str +="  <tr>"; 
                        str +='     <td>'+ vo.userName +'</td>'; 
                        str +="     <td>"; 
                        str +="        <button class='btn btn-sm btn-outline-dark' id='selRank' style='width:100px;' value='${userList.user_groupNo  }' name='${userList.groupNo }' data-toggle='modal' data-target='#exampleModal5'>"+vo.rankName+"</button> "; 
                        str +="        <input type='button' class='btn btn-sm btn-outline-secondary'  style='width: 134px;' value='총무'>"; 
                        str +="     </td>"; 
                         str +="  </tr>";      
                         
                         
                      }else{
                         
                         str +="  <tr id="+vo.userNo+">"; 
                          str +='     <td>'+ vo.userName +'</td>'; 
                          str +="     <td>"; 
                          str +="       <button class='btn btn-sm btn-outline-dark' id='selRank' style='width:100px;' value='${userList.user_groupNo  }' name='${userList.groupNo }' data-toggle='modal' data-target='#exampleModal5'>"+vo.rankName+"</button> "; 
                          str +="       <button class='huu btn btn-sm btn-outline-danger mr-2' id='huu' name='${userList.user_groupNo }' data-toggle='modal' data-target='#exampleModal'>추방</button>  "; 
                          str +="       <button class='cho1 btn btn-sm btn-outline-info' id='${userList.userNo }' value='${userList.groupNo }' data-toggle='modal' data-target='#exampleModal2'>총무위임</button>"; 
                          str +="     </td>"; 
                          str +="  </tr>"; 
                      }
                     
                      $("#userList").append(str);
                      
                 });
                   
                                        
               },
               error : function(XHR, status, error) {
                      console.error(status + " : " + error);
               }
          });
        $(this).closest('tr').remove();
       
       
       if(${empty joinList}){
           
           $("#applyList").append("<tr><td></td> <td> 가입 신청자가 없습니다. </td><td></td></tr>");
        } 
        
    });
    
    
  //회원 명단 - 등급추가하기 
    $("#plusRank").on("click",function(){
       
       var rankName1 = $(this).parent().find("[name=rankName]").val();
       var rankExplain1 =  $(this).parent().find("[name=rankExplain]").val();
       
       console.log(rankName1,rankExplain1);
       
       
          $.ajax({
                  //요청할때
                  url : "${pageContext.request.contextPath }/plusRank", 
                  type : "post",
                  data : {rankName: rankName1,rankExplain: rankExplain1},  
                  dataType : "json",
                  success : function(plusRankList) {
                         console.log("성공");
                         
                         $("#rankUser").empty();  
                         
                         $.each(plusRankList,  function(index, vo) { 
                            var str="";
                            
                               str +="  <tr>"; 
                                str +="     <td><input type='text' class='text-center smContent' style='border:none;background-color:transparent;width:100px;' value='"+ vo.rankName +"'></td>"; 
                                str +="     <td>"; 
                                str +="       <textarea class='text-center smContent' style='border:none;background-color:transparent;' rows='3' id='' name='' >"+vo.rankExplain+"</textarea>"; 
                                str +="     </td>"; 
                                str +="     <td>"; 
                                str +="      <li class='nav flex-column ml-4 '  style='width:60px;'>"; 
                                str +="       <button class='btn btn-secondary btn-sm smContent' id='fixRank' data-dismiss='modal' name='"+vo.rankName +"' type='button'>설정</button>  "; 
                                str +="       <button class='btn btn-info btn-sm smContent' id='updateRank'  type='button'>수정</button>  "; 
                                str +="       <button class='btn btn-danger btn-sm smContent' id='delRank'  name='"+vo.rankNo+"'  type='button'>삭제</button>  "; 
                                str +="     </li>";  
                                str +="     </td>"; 
                                str +="  </tr>"; 
                           
                           
                            $("#rankUser").append(str);
                            $("[name=rankName]").val("");
                         $("[name=rankExplain]").val("");
                         
                            
                       });
                 
                  },
                  error : function(XHR, status, error) {
                         console.error(status + " : " + error);
                  }
             });
          
             // $("#huu").closest('tr').remove();
          });
    
    
     
       
   //리스트 보여주기     
    $("#userList").on("click",".selRank",function(){

       var groupNo = $(this).attr("name");
       var user_groupNo = $(this).attr("value");
       console.log("groupNo = " + groupNo);
       console.log("user_groupNo = " + user_groupNo);
       
       $.ajax({
           //요청할때
           url : "${pageContext.request.contextPath }/seleckRank", 
           type : "post",
           data : {groupNo: groupNo},  
           dataType : "json",
           success : function(rankList) {
                  console.log("성공");
                  
                  $("#rankUser").empty();  
                  
                  
                  $.each(rankList,  function(index, vo) { 
                     var str="";
                     
                        str +="  <tr>"; 
                         str +="     <td><input type='text' class='rank1 text-center' name='rankName' style='border:none;background-color:transparent;width:100px;' value='"+ vo.rankName +"' readonly></td>"; 
                         str +="     <td>"; 
                         str +="       <textarea class='rank2 text-center' name='rankExplain' style='border:none;background-color:transparent;' rows='3' id='' name='' >"+vo.rankExplain+"</textarea>"; 
                         str +="     </td>"; 
                         str +="     <td>"; 
                         str +="      <li class='nav flex-column ml-4 '  style='width:60px;'>"; 
                         str +="       <button class='fixRank btn btn-secondary btn-sm' id='fixRank'  data-dismiss='modal' name='"+vo.rankNo +"' value='"+user_groupNo+"' type='button'>설정</button>  "; 
                         str +="       <button class='updateRank btn btn-info btn-sm ' id='updateRank' value=''  name='"+vo.rankNo +"' type='submit'>수정</button>  "; 
                         str +="       <button class='delRank btn btn-danger btn-sm' id='delRank'  name='"+vo.rankNo+"'  type='button'>삭제</button>  "; 
                         str +="     </li>";  
                         str +="     </td>"; 
                         str +="  </tr>"; 
                    
                     $("#rankUser").append(str);
                  
                });
          
           },
           error : function(XHR, status, error) {
                  console.error(status + " : " + error);
           }
      });
         
    });
    
 
    //등급 설정버튼 눌렀을때
    $("#rankUser").on("click",".fixRank",function(){
          var fixRankName = $(this).attr("name");
          var user_groupNo = $(this).attr("value");
          console.log("랭크번호 : "+fixRankName);
          console.log("유저그룹번호 : "+user_groupNo);
          
          $.ajax({
              //요청할때
              url : "${pageContext.request.contextPath }/fixRank", 
              type : "post",
              data : {rankNo: fixRankName,user_groupNo:user_groupNo},  
              dataType : "json",
              success : function(List) {
                     console.log("성공");
                     
                     $("#userList").empty();
                     console.log("연결");
                     
                     $.each(List,  function(index, vo) { 
                            var str="";
                            
                            
                            if(vo.userNo == ${gvo.manager }){

                              str +="  <tr>"; 
                              str +='     <td>'+ vo.userName +'</td>'; 
                              str +="     <td>"; 
                              str +="        <button class='selRank btn btn-sm btn-outline-dark' id='selRank' style='width:100px;' value='"+vo.user_groupNo+"' name='"+vo.groupNo+"' data-toggle='modal' data-target='#exampleModal5'>"+vo.rankName+"</button> "; 
                              str +="        <input type='button' class='btn btn-sm btn-outline-secondary'  style='width: 134px;' value='총무'>"; 
                              str +="     </td>"; 
                              str +="  </tr>";      
                               
                               
                           }else{
                               
                              str +="  <tr  id="+vo.userNo+">"; 
                              str +='     <td>'+ vo.userName +'</td>'; 
                              str +="     <td>"; 
                              str +="       <button class='selRank btn btn-sm btn-outline-dark' id='selRank' style='width:100px;' value='"+vo.user_groupNo+"' name='"+vo.groupNo+"' data-toggle='modal' data-target='#exampleModal5'>"+vo.rankName+"</button> "; 
                              str +="       <button class='huu btn btn-sm btn-outline-danger mr-2' id='huu' name='"+vo.user_groupNo+"' data-toggle='modal' data-target='#exampleModal'>추방</button>  "; 
                              str +="       <button class='cho1 btn btn-sm btn-outline-info' id='"+vo.userNo+"' value='"+vo.groupNo+"' data-toggle='modal' data-target='#exampleModal2'>총무위임</button>"; 
                              str +="     </td>"; 
                              str +="  </tr>"; 
                           }
                           
                            $("#userList").append(str);
                            
                       });
                         
              },
              error : function(XHR, status, error) {
                     console.error(status + " : " + error);
              }
         });
   
   
          
       });
    
    
    //등급 수정하기 
    $(".rankUser").on("click",".updateRank",function(){
        var rankNo = $(this).attr("name");
        var rankName =$(this).parent().parent().parent().find("[name=rankName]").val();
        var rankExplain = $(this).parent().parent().parent().find("[name=rankExplain]").val();
        console.log("rankNo : "+rankNo);
        console.log("rankName : "+rankName);
        console.log("rankExplain : "+rankExplain);
       
        
         $.ajax({
             //요청할때
             url : "${pageContext.request.contextPath }/updateRank", 
             type : "post",
             data : {rankNo: rankNo,rankName:rankName,rankExplain:rankExplain},  
             dataType : "json",
             success : function(no) {
                    console.log("성공"+no);
                    
             },
             error : function(XHR, status, error) {
                    console.error(status + " : " + error);
             }
        }); 
  
       
    });
    
    //등급삭제하기  -> 기본 디폴트값은 지우지 못한다.
    $("#rankUser").on("click",".delRank",function(){
       var RankNo = $(this).attr("name");
       console.log("랭크 삭제: "+RankNo);
       
        $.ajax({
               //요청할때
               url : "${pageContext.request.contextPath }/deleteRank", 
               type : "post",
               data : {RankNo: RankNo},  
               dataType : "json",
               success : function(delRankList) {
                      console.log("성공"+delRankList);
                      
                      $("#rankUser").empty();  
                      
                      $.each(delRankList,  function(index, vo) { 
                         var str="";
                         
                            str +="  <tr>"; 
                             str +="     <td><input type='text' class='text-center' style='border:none;background-color:transparent;width:100px;' value='"+ vo.rankName +"'></td>"; 
                             str +="     <td>"; 
                             str +="       <textarea class='text-center' style='border:none;background-color:transparent;' rows='3' id='' name='' >"+vo.rankExplain+"</textarea>"; 
                             str +="     </td>"; 
                             str +="     <td>"; 
                             str +="      <li class='nav flex-column ml-4 '  style='width:60px;'>"; 
                             str +="       <button class='btn btn-secondary btn-sm' id='fixRank' data-dismiss='modal' name='"+vo.rankName +"' type='button'>설정</button>  "; 
                             str +="       <button class='btn btn-info btn-sm ' id='updateRank'  type='button'>수정</button>  "; 
                             str +="       <button class='btn btn-danger btn-sm' id='delRank'  name='"+vo.rankNo+"'  type='button'>삭제</button>  "; 
                             str +="     </li>";  
                             str +="     </td>"; 
                             str +="  </tr>"; 
                        
                        
                         $("#rankUser").append(str);
                      
                    });
              
               },
               error : function(XHR, status, error) {
                      console.error(status + " : " + error);
               }
          });
       // $("#delRank").closest('tr').remove();
    });
    
    
    
    
    
      //회원 명단 - 추방하기
      
      $(".del").on("click",".huu",function(){
         
         var user_groupNo =$(this).attr("name")
         $("#delUser").val(user_groupNo);
         var userNo = $(this).closest("tr").attr("id");
          
         
         $("#delUser").on("click",function(){
            
         console.log("추방");
         var user_groupNo = $(this).attr("value")
         console.log(user_groupNo);
         
            
         $.ajax({
                 //요청할때
                 url : "${pageContext.request.contextPath }/deleteUser", 
                 type : "post",
                 data : {user_groupNo:user_groupNo},  
                 dataType : "json",
                 success : function(no) {
                        console.log(no+"성공");
                
                $("#exampleModal").modal("hide");
                //$('#myUserList > tbody:last > tr:last').remove();
                 },
                 error : function(XHR, status, error) {
                        console.error(status + " : " + error);
                 }
            });
         
             $('.huu').closest('#'+userNo).remove();
         });
         
          
         
      }); 
      
      // 총무위임
      $(".del").on("click",".cho1",function(){
         
         
         var userNo = $(this).attr("id");
         $("#afterMana1").val(userNo);

         var groupNo = $(this).attr("value");
         console.log("총무에서 사용하는 그룹번호:"+groupNo);
         $("#afterMana2").val(groupNo);
         
         $("#afterMana").on("click",function(){
         console.log("총무");
            var userNo = $("#afterMana1").val()
            var groupNo = $("#afterMana2").val()
            console.log("총무-유저번호 :"+userNo);
            console.log("총무-그룹번호 :"+groupNo);
            
            
              $("#exampleModal2").modal("hide");
            alert("총무가 변경되었습니다");
              
         });
         
      });
      
         
      
      
   </script>
</body>
</html>