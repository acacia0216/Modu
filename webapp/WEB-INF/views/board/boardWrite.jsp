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
   <!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" /> -->
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
   

<div class="container" > 

	<%-- <div class="text-right mb-5 mx-auto w-75"  >
        <input type="button" style="border:none;" class="btn btn-outline-secondary btn-lg smContent" onclick="location.href='${pageContext.request.contextPath }/board/${authUser.groupNo}'" value="취소">
        <input style="border:none;" class="btn btn-outline-primary btn-lg smContent " type="submit" value="공유" >      
    </div> --%>
    <div class="text-center">
    	<h4 class="lgTitle my-4">글쓰기</h4>
    </div>
            
   <form id="form_board" action="${pageContext.request.contextPath}/board/${authUser.groupNo}/add" onkeydown="return captureReturnKey(event)" method="post" enctype="multipart/form-data"  >
      <input type="hidden" name="userNo" value="${authUser.userNo}"><span>&nbsp;</span>
      <input type="hidden" name="tagNo" id="tagNo" value=""><span>&nbsp;</span>
      <div>
      <input class="form-control mx-auto col-9 my-3 smContent" id="boardTitle" name="boardTitle" placeholder="제목을 입력하세요" >
      <textarea class="form-control col-9 mx-auto my-3 smContent" name="boardContent" id="boardContent" rows="10" placeholder="내용을 입력하세요">${placePlan}</textarea>
      </div>
      <div class="card col-9 mx-auto my-3">
         <div class="card-header" style="background:transparent;">
            <h5 class="navText mt-3" style="font-size: 1.2em;">가계부 첨부</h5>
         </div>
         <div class="card-body">
   
            <!-- Button trigger modal -->
            <div class="float-left mr-2">
               <button type="button" class="btn btn-primary smContent" data-toggle="modal" data-target="#dateModal">
                  날짜로 불러오기          
               </button>
            </div>
   
   
   
            <!-- Button trigger modal -->
            <div class="float-left mb-3">
               <button type="button" id="btn_tag" class="btn btn-info smContent" data-toggle="modal" data-target="#tagModal">
                  태그로 불러오기          
               </button>
            </div>
   
         
            <div style="clear: both;"> </div>
   
            <div id='tagDiv' class="mb-2" style="text-align:justify;">
               <span id="tagName" style= "display:inline-block; width:200px;">
               <!--    <span  class="p-2 float-left" style=" border:#54c9ad 2px solid;  border-radius: 15px; ">
                     #태그
                  </span> --> 
                   <!-- <input id='tagInput' name='tagName' class='form-control float-left;' type='text' style='font-weight:bold; border:#54c9ad 2px solid; border-radius: 15px; width:200px;' placeholder='#태그명을 입력하세요' > -->
               </span>
            </div>
            <div style="clear: both;"> </div>
            

            <div>
               <table class="table table-sm text-center smContent">
                  <thead class="thead-light">
                     <tr id='acc_tr'>
                        <th scope="col"></th>
                        <th scope="col">날짜</th>
                        <th scope="col">내역</th>
                        <th scope="col" >금액</th>
                        <th scope="col" >인원(명)</th>
                        <th scope="col">장소</th>
                        <!-- <th scope="col">지도</th> -->
                        <th id="delCol" scope="col">삭제</th>
                        <th class='hidden' style='display:none;'>히든</th>
                     </tr>
                  </thead>
                  <tbody id="accountList">

                     	<c:if test="${!empty fromAccountbookList}">
							<input id="fromAccFlag" name=${fromAccountbookList} type="hidden" value="0">
						</c:if>
						<c:if test="${empty fromAccountbookList}">
							<tr>                       
                          		<td colspan="8" style="color:gray;">가계부를 첨부해 주세요.</td>                
                     		</tr>
							<input id="fromAccFlag" type="hidden" value="1">
                    	</c:if>
            
                  </tbody>
               </table>
   
   
   
            </div>
   
   
   
         </div>
   
      </div>
      



<!-- <script src="https://code.jquery.com/jquery-3.3.1.js"></script> -->
<script src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/header.js"></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery.devbridge-autocomplete/1.2.26/jquery.autocomplete.min.js'></script>
<!-- 
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
 -->
<script type="text/javascript"
        src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=YX8YchtPnKuE7FGKGyW6&submodules=geocoder"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery.daterangepicker.min.js"></script> --%>






         <div class="form-group p-2 col-9 mx-auto my-3" style="position: relative;">
            <input type="file" class="custom-file-input" id="boardUpload"  name="files" multiple="multiple" onchange="loadFile(event);">
            <label class="custom-file-label up-label text-center pr-5 smContent" for="inputGroupFile04">이미지 업로드 &emsp;</label>
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
            <input type="button"  class="btn btn-secondary btn-lg mr-2 smContent" onclick="location.href='${pageContext.request.contextPath }/board/${authUser.groupNo}'" value="취소">
            <input class="btn btn-primary btn-lg smContent " type="submit" value="공유" >      
          </div> <!--다른 싸이트들은 보통공유하는걸 상단 우측에 놔두더라구요..  -->
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
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" >닫기</button>
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
                           <input class="searchForm form-control ml-4 mb-1" id="searchTag" style= "border-bottom-width:2px; border-color: #0070c0; width: 400px;" type="search" placeholder="태그명을 검색하세요" aria-label="search">
                           <a class="t-button mt-2 ml-1"  > <img src="${pageContext.request.contextPath }/assets/images/search02.png" style="width:24px; height:24px;"> </a>
                        </form>
                        <div class="mt-4">
                           <div class="ml-4">
                           <h3 class="ml-2" style="font-weight: bold; font-size: 1.2em">최근 태그</h3>
   
                           <div style="clear: both;"></div>
   
                           <c:forEach items="${tagList}" end='15' var="vo">
                              <div id="tag" data-tagno="${vo.tagNo}" class="p-2 m-2 float-left" style="border:#54c9ad 2px solid; border-radius: 15px; font-weight:bold; cursor:pointer;">
                                   #${vo.tagName}
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
                  <div class="modal-dialog modal-dialog-centered modal-lg"  role="document">
                     <div class="modal-content">
                        <div class="modal-header" id='tempNo'>
   							
                           <h4 class="modal-title mt-2" id="exampleModalCenterTitle">&nbsp;장소 찾기</h4>
                           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span>&times;</span>
                           </button>
                        </div>
                        <div class="modal-body" >
   
   
                     <!--       <div class="form-group p-2" style="position: relative;">
                              
                           </div> -->
                            <div class='mb-3'>
    							  <input id="storeSearch" type="text" class="form-control" placeholder="상호명을 입력하세요.">
    						</div>
   							<div class='mb-3' id="tableDiv" style="max-height:300px;">
						
							</div>
						
							<div id="map" class="mt-2" style="width:760px;height:250px;"></div>
                         </div>
   
                     </div>
                  </div>
               </div>
               
               
               <!-- <div id="map" style="width:450px;height:450px;"></div> -->
      
            
            
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
 
<script src="${pageContext.request.contextPath }/assets/js/jquery.daterangepicker.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/demo.js"></script>
<script type="text/javascript">


   $(document).ready(function(){
         
	  if($("#fromAccFlag").val() == "0"){
		  $.ajax({
	           
	           url : "${pageContext.request.contextPath}/board/${authUser.groupNo}/getAccountListFromAccountbook",
	           type : "POST",
	           data : {AccountbookList : $("#fromAccFlag").attr("name")},
	           dataType : "json",   
	         
	           success : function(list){
	              
	              console.log(list);
	              $("#accountList").empty(); 
	              $("#tagName").empty(); 
	              $("#tagName").append("<input id='tagNameVal' name='tagName' class='form-control float-left;' type='text' style='font-weight:bold; border:#54c9ad 2px solid; border-radius: 15px; width:200px;' placeholder='태그명을 입력하세요.' >"); 
	              $("#btn_selectDel").remove();
	              $("#tagDiv").append("<span id='btn_selectDel'  class='mb-2 mr-1 p-2 btn btn-sm btn-outline-danger float-right'  >선택 삭제 </span>");
	              $.each(list, function(idx,val){

	            	  val.accountbookSpend = comma(val.accountbookSpend);
	                  renderAccount(val,"down",idx);
	                  
	              })
	              $('#dateModal').modal('hide');
	            /*   $("#likeCount_"+boardNo).text(resultVo.likeCount+"명의 회원이 좋아합니다.");
	              $("[data-likeno="+boardNo+"]").data("state",resultVo.likeState);    */               
	           },
	           
	           error : function(XHR, status, error){
	             console.error(XHR+status+error);
	           }
	           
	        });
	  }
	   
      $('.menuTab').removeClass("active");
      $("#btn_board").addClass("active");
      var up_files = new Array();
      
      
   });

   /* 태그이름 validation 검증 */
   
   $(document).on('click','[type=submit]', function(){
         
      var tagName = $('#tagNameVal').val();
      var accountIdx = $('[data-idx]').data('idx');
      var boardTitle = $('#boardTitle').val(); 
      var boardContent = $('#boardContent').val(); 
      if(accountIdx!=null){
    	  if(tagName!=null&&tagName!=""&&tagName!=undefined){
    	         
    	         
    	         
          }else{
             alert('태그이름을 입력하세요.');
             return false;
             
          }
    	  
      }
      
      if(boardTitle!=null&&boardTitle!=""&&boardTitle!=undefined){
	         
	         
	         
      }else{
         alert('제목을 입력하세요.');
         return false;
         
      }
      
      if(boardContent!=null&&boardContent!=""&&boardContent!=undefined){
	         
	         
	         
      }else{
         alert('내용을 입력하세요.');
         return false;
         
      }
      
   });
   
   /* 엔터 방지 */
   
   function captureReturnKey(e) {
       if(e.keyCode==13 && e.srcElement.type != 'textarea')
       return false;
   }


   
   /* 지도 불러오기  */
   
     var map = new naver.maps.Map("map", {
        center: new naver.maps.LatLng(37.3595316, 127.1052133),
        zoom: 10,
        mapTypeControl: true
    });

     var marker = new naver.maps.Marker({
          position: new naver.maps.LatLng(37.3595704, 127.105399),
          map: map
      });
     

    
/*     
    infoWindow.setContent([
       
        '<div style="padding:10px;min-width:200px;line-height:150%;">',
        '<h5 style="margin-top:5px;">검색 주소 : ' + response.result.userquery + '</h5><br />', addrType + ' ' + item.address + '<br />',
        '</div>' 
    ]); */

    map.setCursor('pointer');

 /*    // search by tm128 coordinate
    //좌표를 지도에 표시하고 주소를 가져옴(마우스로 지도 클릭시)
    function searchCoordinateToAddress(latlng) {
        console.log("searchCoordinateToAddress"+latlng);
        var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);

        infoWindow.close();
        console.log("체크포인트" + tm128);
        naver.maps.Service.reverseGeocode({
            location: tm128,
            coordType: naver.maps.Service.CoordType.TM128
        }, function (status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                return alert('Something Wrong!');
            }

            var items = response.result.items,
                htmlAddresses = [];

            for (var i = 0, ii = items.length, item, addrType; i < ii; i++) {
                item = items[i];
                addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]';

                htmlAddresses.push((i + 1) + '. ' + addrType + ' ' + item.address);
            }

            infoWindow.setContent(['<div style="padding:10px;min-width:200px;line-height:150%;">', '<h4 style="margin-top:5px;">검색 좌표</h4><br />', htmlAddresses.join('<br />'), '</div>'].join('\n'));

            infoWindow.open(map, latlng);
            console.log(item.addrdetail);
        });
    }
 */
 
    // 마커 클릭시 이벤트
    
    naver.maps.Event.addListener(marker, "click", function(e) {
    if (infowindow.getMap()) {
        infowindow.close();
    } else {
        infowindow.open(map, marker);
    }
});
 
 
 
    // result by latlng coordinate
    //주소를 좌표로 바꿔주고 지도에 찍기
    function searchAddressToCoordinate(address) {
        console.log("searchAddressToCoordinate");
        naver.maps.Service.geocode({
            address: address
        }, function (status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                /* return alert('Something Wrong!'); */
            }

            var item = response.result.items[0],
                addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]',
                point = new naver.maps.Point(item.point.x, item.point.y);
      
			console.log(point);
			console.log(item.point.x+" : "+ item.point.y);
            map.setCenter(point);
            marker.setPosition(point);
            
             
        });
    }
    // result by latlng coordinate
    //주소를 좌표로 바꿔주고 지도에 찍기
    function putPoint(address) {
        console.log("searchAddressToCoordinate");
        naver.maps.Service.geocode({
            address: address
        }, function (status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                /* return alert('Something Wrong!'); */
            }

            var item = response.result.items[0],
                addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]',
                point = new naver.maps.Point(item.point.x, item.point.y);
      
			console.log(point);
			console.log(item.point.x+" : "+ item.point.y);
			var pointX = item.point.x + "",
				pointY = item.point.y + "";
			console.log(pointX+" : "+ pointY);
			var accountNo=$("#tempNo").val();
			$("#pointX"+accountNo).val(pointX);
			$("#pointY"+accountNo).val(pointY);
			console.log("!!!@!@!@!@!@!@" + $("#pointX"+accountNo).val());
            map.setCenter(point);
            marker.setPosition(point);
            
             
        });
    }

    function initGeocoder() {
        console.log("initGeocoder");
       /*  map.addListener('click', function (e) {
            searchCoordinateToAddress(e.coord);
        }); */

        $('#address').on('keydown', function (e) {
            var keyCode = e.which;

            if (keyCode === 13) { // Enter Key
                searchAddressToCoordinate($('#address').val());
                // console.log("입력 값 : "+$("#address").val());
            }
        });

        $(document).on('keyup','div #storeSearch', function (e) {
            /* console.log("When button is on clicked"); */
            $("#guideMsg").remove();
            e.preventDefault();

            var localName = $(this).val();
            $.ajax({
                url: "${pageContext.request.contextPath }/board/${authUser.groupNo}/searchLocal",
                type: "post",
                data: {localName: localName},
                dataType: "json",
                success: function (result) {
                    $("#tableDiv").empty();
                    var itemmm = JSON.parse(result).items;
                    console.log(itemmm);
                    $("#tableDiv").attr("style","min-height:300px");
                    $("#tableDiv").append("<table class='mt-1' id='resultTable' style='vertical-align:top;' min-height:300px>");
                    for (var i = 0; i < itemmm.length; i++) {
                    	
						
						var str= "";
						str += "<tr ><td>&nbsp;&nbsp;<a href='javascript:;' onclick='DataProcess(\"" + itemmm[i].title+"!"+ itemmm[i].category+"!"+ itemmm[i].roadAddress+"!"+ itemmm[i].telephone+ "\")' >" + itemmm[i].title + "</a> </td>";
						str += "<td><button onclick='searchAddressToCoordinate(\"" + itemmm[i].roadAddress + "\")' type='button' class='btn t-button p-0 pb-1'><img style='width:20px;' src='${pageContext.request.contextPath }/assets/images/mapIcon.png'></button></td>";
						str += "<td>&emsp;" + itemmm[i].roadAddress + "</td></tr> <br>";
                        $("#tableDiv").append(str);
                            
                    }
                    
                    for(var j=0; j< 10-itemmm.length; j++){
                    	
                    	$("#tableDiv").append("<tr></tr><br>");
                    	
                    }
                    
                    $("#tableDiv").append("</table>");
                    
                    /* <td><button class='btn-outline-secondary m-1' onclick='DataBaseInputTest(\"" + itemmm[i].roadAddress + "\")'>선택</button></td> */
                }, error: function () {
                    alert("통신 실패");
                }
            });
            // searchAddressToCoordinate();
            // console.log("입력 값 : "+$("#address").val());
        });

        // searchAddressToCoordinate('정자동 178-1');
    }
    
    
    /* 장소 데이터 처리해서 보내기 */
    function DataProcess(items){
    	item = items.split("!");
    	var title = item[0];
    	item[0] = item[0].replace("<b>","");
    	item[0] = item[0].replace("</b>","");
    	var category = item[1];
    	var adddress = item[2];
    	var telephone = item[3];
        
    	
    	addrDetail(item);
        
        
 		/* DataBaseInput(item) */
    	
    	/* DataBaseInput(selectedShop); */
    } 
    
    function addrDetail(items) {
        console.log(items);
        console.log(items[0]);
        var title = items[0];
        var category = items[1];
    	var roadAddress = items[2];
    	var telephone = items[3];
        naver.maps.Service.geocode({
            address: roadAddress
        }, function (status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                return alert('Something Wrong!');
            }
            var item = response.result.items[0],
                addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]';
            var country = item.addrdetail.country;
            var sido = item.addrdetail.sido;
            var sigugun = item.addrdetail.sigugun;
            var dongmyun = item.addrdetail.dongmyun;
            var ri = item.addrdetail.ri;
            var rest = item.addrdetail.rest;
            
            putPoint(roadAddress);
            
            items.push(country);
            items.push(sido);
            items.push(sigugun);
            items.push(dongmyun);
            items.push(ri);
            items.push(rest);
			console.log("@@"+items);
			console.log(item.addrdetail);
			
			
			var accountNo=$("#tempNo").val();
			
			/* $("#addrNo"+accountNo).val(addrNo); */
			$("#country"+accountNo).val(country);
			$("#sido"+accountNo).val(sido);
			$("#sigugun"+accountNo).val(sigugun);
			$("#dongmyun"+accountNo).val(dongmyun);
			$("#ri"+accountNo).val(ri);
			$("#rest"+accountNo).val(rest);
			$("#telephone"+accountNo).val(telephone);
			$("#category"+accountNo).val(category);
			$("#title"+accountNo).val(title);
			$("#roadAddress"+accountNo).val(roadAddress);
			
			$("#place_"+accountNo).val(title);
			$("#mapModal").modal('hide');
           /*  $.ajax({
                url: "${pageContext.request.contextPath }/board/${authUser.groupNo}/whenShopIsSelected",
                type: "post",
                data: {country:country,sido:sido,sigugun:sigugun,dongmyun:dongmyun,ri:ri,rest:rest},
                dataType: "json",
                success: function (result) {
                    if (result == 1){
                    console.log("성공")}
                }, error: function () {
                    alert("통신 실패");
                }
            }); */
            
        });
    }

    naver.maps.onJSContentLoaded = initGeocoder;
   


	/* 장소 넣기  */
	function inputPlace(place){
		
		alert(place);
		$("#mapModal").modal('hide');
		
		
	}
	
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
      var accountbookList = accountbookNo.split(',') ;
      
      for(var i = 0 ; i< accountbookList.length;i++){
            $("#delAcc_"+accountbookList[i]).remove();
      }

      
      $("#deleteAccModal").modal('hide');
         
      
   })
    

   /* 가계부 선택 삭제  */
   
         $(document).on('click',"div #btn_selectDel",function() {
            var accountbookList = [];
               $('input:checkbox[name=chk]').each(function() {
                    if($(this).is(':checked')){
                       accountbookList.push($(this).data('seldelno'));   
                       
                    }
               });
             if(accountbookList.length==0){
                
                alert("삭제할 가계부 항목을 선택하세요.");
                
             } else{
                $("#btn_delAcc").val(accountbookList);
                var accountbookUsage = $("#accUsage_"+accountbookList[0]).text();
               $('#delMent').text("'"+accountbookUsage+"' 등 "+accountbookList.length+"개의 항목을 삭제하시겠습니까?");
               $("#deleteAccModal").modal();
             }
             
         });
   
   
   
   /* 날짜로 불러오기  */
   
   
   $("#btn_date").on('click',function(){
      
      
      var accountbookRegDate = $("#date-range12").val();
        
      $.ajax({
           
           url : "${pageContext.request.contextPath}/board/${authUser.groupNo}/getAccountListByDate",
           type : "POST",
           data : {accountbookRegDate : accountbookRegDate},
           dataType : "json",   
         
           success : function(list){
              
              console.log(list);
              $("#accountList").empty(); 
               $("#tagName").empty(); 
               $("#tagName").append("<input id='tagNameVal' name='tagName' class='form-control float-left;' type='text' style='font-weight:bold; border:#54c9ad 2px solid; border-radius: 15px; width:200px;' placeholder='태그명을 입력하세요.' >"); 
              $("#btn_selectDel").remove();
              $("#tagDiv").append("<span id='btn_selectDel'  class='mb-2 mr-1 p-2 btn btn-sm btn-outline-danger float-right'  >선택 삭제 </span>");
              $.each(list, function(idx,val){

            	  val.accountbookSpend = comma(val.accountbookSpend);
                  renderAccount(val,"down",idx);
                  
              })
              $('#dateModal').modal('hide');
            /*   $("#likeCount_"+boardNo).text(resultVo.likeCount+"명의 회원이 좋아합니다.");
              $("[data-likeno="+boardNo+"]").data("state",resultVo.likeState);    */               
           },
           
           error : function(XHR, status, error){
             console.error(XHR+status+error);
           }
           
        });
      
   });
   
   
   
   /*   태그로 불러오기   */
   $(document).on('click','div [data-tagno]', function(){
      
     var tagNo =$(this).data('tagno');
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
              $("#btn_selectDel").remove();
              $("#tagName").empty();
              $("#tagName").append("<span  class='p-2 float-left mb-0 navText' style='border:#54c9ad 2px solid;  border-radius: 15px;'>#"+list[0].tagName+"</span>");
              $("#tagName").append("<input id='tagNameVal' name='tagName'  type='hidden' value='"+list[0].tagName+"'>");
            /*   $("#tagName").attr("style","border:#54c9ad 2px solid;  border-radius: 15px;"); 
              $("#tagName").text("#"+list[0].tagName) */
              $("#accountList").empty(); 
              
            	  
              
              $.each(list, function(idx,val){
            	  val.accountbookSpend = comma(val.accountbookSpend);
                 renderAccount(val,"down",idx);
                 
              })
            /*   $("#likeCount_"+boardNo).text(resultVo.likeCount+"명의 회원이 좋아합니다.");
              $("[data-likeno="+boardNo+"]").data("state",resultVo.likeState);    */               
           },
           
           error : function(XHR, status, error){
             console.error(XHR+status+error);
           }
           
        });

   
        return false;
   });    
   
   
   /*  콤마 찍기    */
   
   function comma(str) {
       str = String(str);
       return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') + "원";
   }

   /* 가계부 그리기 */ 
   
   function renderAccount(vo,updown,i){
        str= "  ";
        
        str+= "           <tr id='delAcc_"+vo.accountbookNo+"' data-idx='"+i+"'>";
        str+= "               <th scope='row'>";
        str+= "                  <div class='custom-control custom-checkbox'>";
        str+= "						<input type='checkbox' class='custom-control-input data" + i + "' id='delCheck" + i + "' name='chk' data-seldelno='"+vo.accountbookNo+"' aria-label='Checkbox for following text input'>";
		str+= "						<label class='custom-control-label'  for='delCheck" + i + "' style='margin-top: 7px'>&nbsp;</label>";
//        str+= "                     <input class='yj-checkbox' id='delCheck' data-seldelno='"+vo.accountbookNo+"' type='checkbox' aria-label='Checkbox for following text input'>";
        str+= "               	</div>";
        str+= "            </th>";
        str+= "                  <td>"+vo.accountbookRegDate+"</td>";
        str+= "                  <td id='accUsage_"+vo.accountbookNo+"'>"+vo.accountbookUsage+"</td>";
        str+= "                  <td>"+vo.accountbookSpend+"</td>";
        str+= "                  <td style='width:80px;'><input class='form-control smContent' name='accountList["+i+"].accountbookPersonnel' type='text' placeholder='인원' value='"+((vo.accountbookPersonnel!=null)?vo.accountbookPersonnel:'')+"' style='width:70px;' ></td>";
        str+= "                  <td><button data-btnmap='"+vo.accountbookNo+"' type='button' class='btn t-button p-0 w-100' data-toggle='modal' data-target='#mapModal' ><input readonly='readonly' data-addressno='"+vo.accountbookNo+"' class='form-control smContent' id='place_"+vo.accountbookNo+"' data-auto='"+vo.accountbookNo+"' type='text'  name='accountList["+i+"].accountbookPlace' placeholder='장소를 검색하세요.' value='"+((vo.accountbookPlace!=null)?vo.accountbookPlace:'')+"'></button></td>";
        
        /* str+= "                  <td><img src='${pageContext.request.contextPath }/assets/images/mapIcon.png'></td>"; */
        if(vo.tagNo==null){
           
           $('#delCol').remove();
           $('#acc_tr').append("<th id='delCol' scope='col'>삭제</th>");
           str+= "                  <td class='delAccount' data-accno='"+vo.accountbookNo+"' style='cursor:pointer;'>&times;</td>";  
        } else{
           $('#delCol').remove();
        }
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].accountbookAddressNo' id='addrNo"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].country' id='country"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].sido' id='sido"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].sigugun' id='sigugun"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].dongmyun' id='dongmyun"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].ri' id='ri"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].rest' id='rest"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].telephone' id='telephone"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].category' id='category"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].title' id='title"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].roadAddress' id='roadAddress"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].accountbookNo' value='"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].pointX' id='pointX"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "                  <td style='display:none;'> <input name='addressList["+i+"].pointY' id='pointY"+vo.accountbookNo+"' type='hidden'></td>";
        str+= "         </tr>";
        
        str+= "          <input type='hidden' name='accountList["+i+"].accountbookNo' value='"+vo.accountbookNo+"' >";
        
        if(updown=="up"){
           
           $("#accountList").prepend(str);
           
        } else{
         
           $("#accountList").append(str);
        }
      
   }
   
   
   /* 지도 모달 버튼 클릭시	 */
   
   $(document).on('click',"div [data-btnmap]",function(){
	   var accountNo = $(this).data('btnmap');
	   $('#tempNo').val(accountNo);
	   $("#storeSearch").val('');
	   $("#tableDiv").empty();
	   $("#tableDiv").append("<div id='guideMsg' class='text-center'> <span style='color:blue;'> 검색 후 상호명을 클릭하면 자동 입력됩니다.</span></div>"); 
	   
	   /* data-btnmap */
	   
   });
   
   
   

   
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


   
   
   /*  다중 이미지 미리보기 , 확장자 체크  */      
   
   
   var loadFile = function(event) {

      var addImg = new Array();
      
      //초기화
      for(var k=0; k<18 ;k++){
         addImg[k]= document.getElementById('addImg'+k);
         addImg[k].src='';   
      }
      up_files = event.target.files 
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
         /*       for(var i=0;i<event.target.files.length; i++ ){
               addImg[i].src='';
               } */
               return false;
               /*$('#boardUploadModal').modal('hide');*/
      
            } else{
               
            }
   
         }
      }
      
      

   };
   
   
   
   
   $("#test").on('click',function(){
      
      up_files = Array.prototype.slice.call(up_files);  
      up_files.splice(0,1);
      console.log(up_files);
      
   });
   
   /* 업로드 이미지 개별 삭제 */
   $(document).on('click',"#imgPreview img",function(){
      
      var imgName=$(this).attr('id');
      var imgNo = imgName.slice(imgName.indexOf("g") + 1);
      alert(imgNo);
      console.log(up_files);
      up_files = Array.prototype.slice.call(up_files);  
      console.log(up_files);
      up_files.splice(imgNo,1);
      Array.prototype.slice.call(up_files); 
      
      var addImg= document.getElementById('addImg'+imgNo);
      addImg.src='';
      /* $("#boardUpload").val(up_files); */
   });
   
   

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

     
     /* 장소 검색 자동완성 */
     
     /*  var places = [
           { value: '춘하추동', data: 'USD' },
           { value: '언더그라운드', data: 'EUR' },
           { value: '놀란치킨', data: 'JPY' },
           { value: '만끽치킨', data: 'CNY' },
           { value: '하나우동', data: 'HKD' },
           { value: '초선과여포', data: 'TWD' },
           { value: '하나김밥', data: 'GBP' },
           { value: '웃사브', data: 'OMR' },
           { value: '레타스', data: 'CAD' },
           { value: 'Swiss franc', data: 'CHF' },
           { value: 'Swedish krona', data: 'SEK' },
           { value: 'Australian dollar', data: 'AUD' },
           { value: 'New Zealand dollar', data: 'NZD' },
           { value: 'Czech koruna', data: 'CZK' },
           { value: 'Chilean peso', data: 'CLP' },
           { value: 'Turkish new lira', data: 'TRY' },
           { value: 'Mongolian tugrik', data: 'MNT' },   
           { value: 'Israeli new sheqel', data: 'ILS' },
           { value: 'Danish krone', data: 'DKK' },
           { value: 'Norwegian krone', data: 'NOK' }
         ];

     
        $(document).on('click','div [data-auto]',function(){
           
             var autoNo = $(this).data('auto');
             console.log(autoNo);
           
             $('#autocomplete_'+autoNo).autocomplete({
                   lookup: places,
                   onSelect: function (suggestion) {
                     var content = '<strong>상호명:</strong> ' + suggestion.value + ' <br> <strong>주소:</strong> ' + suggestion.data;
                     $('#outputcontent').html(content);
                   }
                 });
           
        });
         */

 }
</script>

</body>
</html>