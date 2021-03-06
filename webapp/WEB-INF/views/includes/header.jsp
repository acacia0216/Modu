<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!-----------header------------------>
<header style="z-index: 4">

    <style type="text/css">
        .dropdown:hover .dropdown-menu {
            display: block;
            margin-top: 0;
        }

    </style>
    <%--첫번째 네비바--%>
    <nav class="container navbar navbar-expand-lg navbar-light navBack" >
        <%-- 공통 로고 --%>
        <a class="navbar-brand"
           href="${pageContext.request.contextPath }/main"> <img
                class="mb-1"
                src="${pageContext.request.contextPath }/assets/images/logo1.png"
                width="168" height="72" alt="모두의 가계부">
        </a>

		<c:if test="${authUser ne null}">
			<%--모임 검색창--%>
			<form class="form-inline mt-3" method="post" action="${pageContext.request.contextPath}/groupmain/groupSearch">
				<input class="form-control smContent mr-sm-1 searchForm " id="searchbox" name="gSearch"
					style="border-bottom-width: 2px; border-color: #0070c0; width: 300px;"
					type="text" placeholder="모임을 검색하세요" aria-label="search">
				<button class="t-button mt-2" type="submit" id="sumit">
					<img style="width:20px;height:20px;"  src="${pageContext.request.contextPath }/assets/images/search03.png">
				</button>
			</form>

			<!-- <form action="#" name="form1" method="post">
			<input type="text" id="searchbox">
			<input type="submit" id="submit" value="검색">
			</form> -->
		</c:if>

		<c:if test="${authUser eq null}">
			<div class="collapse navbar-collapse justify-content-end">

          <ul class="navbar-nav mt-2"> 
                        <%--로그인/회원가입 버튼--%>
                  <!--   <button class="mr-2"
                            style="border: 2px solid #0179c1; background-color: white;">
                        <a class="nav-link" href="#"
                           style="color: #0179c1; font-weight: bold;" data-toggle="modal"
                           data-target="#exampleModalCenter">로그인/회원가입</a>
                    </button>  -->
                    
             <button class="mr-2" style="border:none;background-color:transparent;" >
               <a class="nav-link mt-2" href="#" data-toggle="modal" data-target="#exampleModalCenter">
               <h5 class="linkText"><img alt="" src="${pageContext.request.contextPath }/assets/images/user.png"style="width: 25px;height: 25px;">&nbsp;&nbsp;로그인/회원가입</h5></a>
               </button>
           </ul>

            </div>
        </c:if>
        <c:if test="${authUser ne null}">
            <div class="collapse navbar-collapse justify-content-end">
                <ul class="navbar-nav mt-2">
                    <div class="clubIcon float-right mb-3">
                        <!-- <button class="btn btn-sm btn-mint" data-toggle="modal"
                                data-target="#exampleModalCenter01">모임 추가하기
                        </button> -->
                        <button  class="clubIcon" style="border:none;background-color:transparent;" data-toggle="modal" data-target="#exampleModalCenter01">
                        <h5 class="mt-2 linkText">
                         <img alt="ico-plusGroup"  src="${pageContext.request.contextPath }/assets/images/groImg1.png" style="width: 25px;height: 25px;">&nbsp;&nbsp;모임 추가하기</h5>
                        </button>
                    
                        <%--로그인/회원가입 버튼--%>
                     <!-- style="border: 2px solid #0179c1; background-color: white;" --><!--style="color: #0179c1; font-weight: bold;"  -->
                        <button id="logout" class="" style="border:none;background-color:transparent;" >
                        <h5 class="linkText">로그아웃</h5>
                            <%-- <a href="${pageContext.request.contextPath }/logout"
                               class="nav-link mb-1" >로그아웃</a> --%>
                        </button>
                    </div>
                </ul>

            </div>
        </c:if>
        <%--<button class="mr-2"style="border:2px solid #0179c1; background-color:white; ">--%>
        <%--<a class="nav-link" href="#" style="color: #0179c1; font-weight: bold;" data-toggle="modal" data-target="#exampleModalCenter3">회원가입</a>--%>
        <%--</button>--%>

        </ul>

        </div>
    </nav>
    <!-- <div style="margin-bottom: 80px;"></div> -->
    <c:if test="${authUser ne null}">
        <%--두번째 네비바--%>
        <nav id="secNav" class="container navbar navbar-expand-lg navbar-light navBack"  >

			<div class="collapse navbar-collapse " width="70">
				<ul class="navbar-nav icon" id="check">



					<%--모임 리스트--%>
					<c:choose>
						<c:when test="${gList ne null}">
							<div class="btn-group active ml-0 dropdown navText">
								<div style="width:200px;  overflow:hidden; text-overflow:ellipsis; height: 50px;">
									<c:if test="${gvo.groupImg==null}" >
										<img src="${pageContext.request.contextPath }/assets/images/groupImg00.png"
											alt="" style="height: 40px; width: 40px; border-radius:20px;">
									</c:if>
									<c:if test="${gvo.groupImg!=null}" >
										<img src="${pageContext.request.contextPath }/upload/${gvo.groupImg}"
											alt="" style="height: 40px; width: 40px; border-radius:20px;">&nbsp;
									</c:if>
										${gvo.groupName!=null?gvo.groupName:'모임을 선택하세요' }
								</div>

									<button class="btn btn-lg dropdown-toggle ml-0 dropdown"
									type="button" id="dropdownMenuButton" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false" style="background-color: white" >
									</button>

								<div class="dropdown-menu " aria-labelledby="dropdownMenuButton">
									<c:forEach items="${gList }" var="gro">
										<a class="dropdown-item navText" href="${pageContext.request.contextPath }/groupmain/${gro.groupNo}">
										<img src="${pageContext.request.contextPath }/upload/${gro.groupImg}"
											alt="" style="height: 40px; width: 40px; border-radius:20px;">
											&nbsp; ${gro.groupName}</a>
									</c:forEach>
								</div>
							</div>

		 <c:if test="${gvo.groupNo ne null}">
			<!-- <nav id="thirdNav"
				class="container navbar navbar-expand-lg navbar-light bg-light">
 -->
				<div class="collapse navbar-collapse " style="position:absolute; right:100px; width:800px;">

					<ul class="navbar-nav" >
						<%--메인--%>
						<li id="btn_main" class="nav-item menuTab">
							<a class="nav-link navText" href="${pageContext.request.contextPath }/groupmain/${authUser.groupNo}">메인</a>
						</li>
						<%--가계부--%>
						<li id="accountbook" class="nav-item menuTab">
							<a class="nav-link navText" href="${pageContext.request.contextPath }/accountbook/${authUser.groupNo}">가계부</a>
						</li>
						<%--통계(풀다운메뉴)--%>
						<li class="nav-item menuTab dropdown"><a
							class="nav-link dropdown-toggle navText" href="#"
							id="navbarDropdownMenuLink" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"> 통계 </a>
							<div class="dropdown-menu"
								aria-labelledby="navbarDropdownMenuLink">
								<%--경로 = 최상경로/모임번호/annualreport--%>
                                    <a id="goToReportByPeriod" class="dropdown-item navText" href="" onclick="goToReportByPeriod()">기간별 보고서</a>
                                    <a id="goToReportByTag" class="dropdown-item navText" href="" onclick="goToReportByTag()">태그별 보고서</a>
							</div></li>
						<%--게시판--%>
						   <c:if test="${authUser.userNo eq gvo.manager }">
		                  	  <!-- 총무 글쓰기 있는 드랍다운 -->
			                  <li class="nav-item menuTab dropdown"><a
			                     class="nav-link dropdown-toggle navText" href="#"
			                     id="navbarDropdownMenuLink" data-toggle="dropdown"
			                     aria-haspopup="true" aria-expanded="false"> 게시판 </a>
			                     <div class="dropdown-menu"
			                        aria-labelledby="navbarDropdownMenuLink">
			                        <%--경로 = 최상경로/모임번호/annualreport--%>
			                                    <a  class="dropdown-item navText" href="${pageContext.request.contextPath }/board/${authUser.groupNo}" >게시글 보기</a>
			                                    <a  class="dropdown-item navText" href="${pageContext.request.contextPath }/board/${gvo.groupNo}/write" >글 쓰기</a>
			                     </div>
			                  </li>
		                  </c:if>
		                  
		                  <c:if test="${authUser.userNo ne gvo.manager }">
			                  <li id="btn_board" class="nav-item menuTab"><a
			                     class="nav-link navText"
			                     href="${pageContext.request.contextPath }/board/${authUser.groupNo}">게시판</a></li>
		                  </c:if>
                  

						<%--회비관리--%>
					   <li id="membershipfee" class="nav-item menuTab">
					   		<a class="nav-link navText" href="${pageContext.request.contextPath }/membershipfee/${authUser.groupNo}/feemanage">회비관리</a>
					   </li>

						<c:if test="${authUser.userNo eq gvo.manager }">
						<%--모임관리--%>
						<li id="groupManage" class="nav-item menuTab"><a class="nav-link navText"
							href="${pageContext.request.contextPath }/groupmanage/${authUser.groupNo}">모임관리</a></li>
						</c:if>
						<%-- 장소추천 --%>
						
						<li id="placerecommend" class="nav-item menuTab">
							<a class="nav-link navText" href="${pageContext.request.contextPath }/placerecommend/${authUser.groupNo}">장소추천</a>
						</li>

				</div>

			<!-- </nav> -->
		 </c:if>

						</c:when>
						<c:otherwise>
							<li class="nav-item">

								<div class="btn-group active">
								<button class="btn btn-light btn-lg dropdown-toggle"
									type="button" id="dropdownMenuButton" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false">
								</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
										<a class="dropdown-item" href="#"
										style="font-size: 15px">&emsp;모임이없습니다.&emsp;</a>
								</div>
								</div>
							</li>
						</c:otherwise>
					</c:choose>

				</ul>

			</div>
		</nav>

	</c:if>
</header>


<!-- Modal -->
<div class="modal fade" id="exampleModalCenter01" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content text-center">
			<div class="modal-header">
				<h5 class="modal-title" style="margin-left:25%" id="exampleModalCenterTitle">
					 <img
						alt="groupImg02"
						src="${pageContext.request.contextPath }/assets/images/groupImg02.png">&emsp;
					모임 정보 입력
				</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="join-form" name="joinForm" method="post"
				action="${pageContext.request.contextPath}/plusgroup"
				enctype="multipart/form-data">
				<center>
					<div class="modal-body">
						<!-- <label for="gname1">모임 이름</label> -->
						<input type="text" name="groupName"
							class="form-control w-75 text-center" aria-label="Large"
							aria-describedby="inputGroup-sizing-sm" id="gname1" 
							placeholder="모임이름" value=""><br>
						<!-- <label for="gtag1">모임 설명, 해시태그</label> -->
						<textarea class="form-control w-75 text-center" rows="3"
							id="gtag1" name="groupExplain" aria-label="Large"
							aria-describedby="inputGroup-sizing-sm" placeholder="모임설명, 해시태그"></textarea>

						<div class="form-group p-2 w-75 mt-4" style="position: relative;">
							<input type="file" name="file" class="custom-file-input"
								id="boardUpload" multiple="true" onchange="loadFile(event);">
							<label class="custom-file-label text-center pr-5"
								for="boardUpload">이미지 업로드 &emsp;</label> <img id="addImg" src=""
								class="w-100 mx-auto mt-3">
						</div>

						<label for="gcar1" style="font-weight: bold">*모임
							성격</label>
						<!-- <input type="text" class="form-control w-75" aria-label="Large" aria-describedby="inputGroup-sizing-sm" id="gcar1" name="gcar"> -->
						<br>

						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" id="customRadioInline1" name="groupType"
								class="custom-control-input" value="1"> <label
								class="custom-control-label" for="customRadioInline1">계모임</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" id="customRadioInline2" name="groupType"
								class="custom-control-input" value="2"> <label
								class="custom-control-label" for="customRadioInline2">동아리/동호회</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" id="customRadioInline3" name="groupType"
								class="custom-control-input" value="3"> <label
								class="custom-control-label" for="customRadioInline3">친목모임</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" id="customRadioInline4" name="groupType"
								class="custom-control-input" value="4"> <label
								class="custom-control-label" for="customRadioInline4">기타</label>
						</div>
						<input type="hidden" name="userNo" value="${authUser.userNo}">
						<div class="text-center mb-3">
							<br> <input class="btn btn-success" id="groupPlus" name="" type="submit"
								value="모임 생성하기">

                        </div>
                    </div>
            </form>
            </center>
        </div>
    </div>
</div>
<input type="hidden" name="groupNo" id="groupNo" value="${authUser.groupNo}">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript">

	$("#logout").on("click",function(){
		location.href="${pageContext.request.contextPath }/logout";
	})
    /*  이미지 미리보기 , 확장자 체크  */

    var goToReportByPeriod = function () {
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var groupNo = $("#groupNo").val();
        $("#goToReportByPeriod").attr("href", "${pageContext.request.contextPath}/reportbyperiod/" + groupNo + "/" + year + "/" + 1 + "/" + year + "/" + month);
    }

    var goToReportByTag = function () {
        var groupNo = $("#groupNo").val();
        //제일 최근 태그 가져와야함
        //ajax 구현
        $("#goToReportByTag").attr("href", "${pageContext.request.contextPath}/report/getRecentTag/" + groupNo);
    }

    /*  이미지 미리보기 , 확장자 체크  */

    var loadFile = function (event) {
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
    
    /* $("#groupPlus").on(click,function{
    	var gname = $("#gname1").val();
    	if(gname == null){
    		alert("모임 이름을 입력해 주세요");
    	}
    	
    	var gEx = $("#gtag1").val();
    	if(gEx == null){
    		alert("모임 설명을 입력해 주세요");
    	}

    	
    }); */


</script>



