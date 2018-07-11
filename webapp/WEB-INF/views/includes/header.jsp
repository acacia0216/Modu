<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!-----------header------------------>
<header>
    <%--첫번째 네비바--%>
    <nav class="container navbar navbar-expand-lg navbar-light bg-light">
        <%-- 공통 로고 --%>
        <a class="navbar-brand" href="${pageContext.request.contextPath }/main">
            <img class="mb-1" src="${pageContext.request.contextPath }/assets/images/logo1.png" width="168" height="72"
                 alt="모두의 가계부">
        </a>
        <c:if test="${authUser ne null}">
            <%--모임 검색창--%>
            <form class="form-inline mt-3">
                <input class="form-control mr-sm-1 searchForm"
                       style="border-bottom-width:2px; border-color: #0070c0; width: 300px;" type="search"
                       placeholder="모임을 검색하세요" aria-label="search">
                <button class="t-button mt-2" type="submit"><img
                        src="${pageContext.request.contextPath }/assets/images/search.png"></button>
            </form>
        </c:if>
        <c:if test="${authUser eq null}">
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav mt-2">
                    <%--로그인/회원가입 버튼--%>
                <button class="mr-2" style="border:2px solid #0179c1;  background-color:white;">
                    <a class="nav-link" href="#" style="color: #0179c1; font-weight: bold;" data-toggle="modal"
                       data-target="#exampleModalCenter">로그인/회원가입</a>
                </button>
                </c:if>
                <c:if test="${authUser ne null}">
                <div class="collapse navbar-collapse justify-content-end">
                    <ul class="navbar-nav mt-2">
                            <%--로그인/회원가입 버튼--%>
                        <button class="mr-2" style="border:2px solid #0179c1;  background-color:white;">
                          <a href="${pageContext.request.contextPath }/logout" class="nav-link" style="color: #0179c1; font-weight: bold;">로그아웃</a>
                        </button>
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
        <nav id="secNav" class="container navbar navbar-expand-lg navbar-light bg-light">

            <div class="collapse navbar-collapse justify-content-center" width="70">

                <ul class="navbar-nav icon">
                        <%--나의 모임 링크--%>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath }/groupmain"
                           style="font-size: 1.4em;  font-weight: 800; color: #54c9ad;">나의 모임 <span class="sr-only">(current)</span></a>
                    </li>
                        <%--모임 리스트--%>
                    <li class="nav-item">
                        <div class="clubIcon active">
                            <img src="${pageContext.request.contextPath }/assets/images/club01.png" alt="club01">
                            <br>
                            <a class="nav-link" href="${pageContext.request.contextPath }/groupmain">모임1</a>
                        </div>

                    </li>
                    <li class="nav-item">
                        <div class="clubIcon">
                            <img src="${pageContext.request.contextPath }/assets/images/club02.png" alt="club02">
                            <a class="nav-link" href="${pageContext.request.contextPath }/groupmain">모임2</a>
                        </div>

                    </li>
                    <li class="nav-item">
                        <div class="clubIcon">
                            <img src="${pageContext.request.contextPath }/assets/images/club03.png" alt="club03">
                            <a class="nav-link" href="${pageContext.request.contextPath }/groupmain">모임3</a>
                        </div>

                    </li>

                    <li class="nav-item">
                        <div class="clubIcon">
                            <img src="${pageContext.request.contextPath }/assets/images/club04.png" alt="club04">
                            <a class="nav-link" href="${pageContext.request.contextPath }/groupmain">모임4</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <div class="clubIcon">
                            <img src="${pageContext.request.contextPath }/assets/images/club05.png" alt="club05">
                            <a class="nav-link" href="${pageContext.request.contextPath }/groupmain">모임5</a>
                        </div>
                    </li>
                        <%--모임 5개이상 보기 버튼--%>
                    <li class="nav-item ml-0">
                        <div class="clubIcon">
                            <button class="t-button"><img
                                    src="${pageContext.request.contextPath }/assets/images/down.png"
                                    alt="more"></button>
                        </div>
                    </li>
                        <%--모임 추가하기 버튼--%>
                    <li class="nav-item ml-0">
                        <div class="clubIcon">
                            <button class="btn btn-sm btn-mint" data-toggle="modal" data-target="#exampleModalCenter01">
                                모임
                                추가하기
                            </button>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>

        <%--세번째 네비바--%>
        <nav id="thirdNav" class="container navbar navbar-expand-lg navbar-light bg-light">


            <div class="collapse navbar-collapse justify-content-center">

                <ul class="navbar-nav ">
                        <%--메인--%>
                    <li id="btn_main" class="nav-item menuTab active">
                        <a class="nav-link" href="${pageContext.request.contextPath }/main">메인 <span class="sr-only">(current)</span></a>
                    </li>
                        <%--가계부--%>
                    <li id="accountbook" class="nav-item menuTab">
                        <a class="nav-link" href="${pageContext.request.contextPath }/accountbook/accountbook">가계부</a>
                    </li>
                        <%--통계(풀다운메뉴)--%>
                    <li class="nav-item menuTab dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">
                            통계
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <%--경로 = 최상경로/모임번호/annualreport--%>
                            <a id="goToAnnual" class="dropdown-item" href="" onclick="goToAnnualReport()">연간</a>
                            <a id="goToMonthly" class="dropdown-item" href="" onclick="goToMonthlyReport()">월간</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="${pageContext.request.contextPath }/getRecentEvent/${authUser.groupNo}">행사별</a>
                        </div>
                    </li>
                        <%--게시판--%>
                    <li id="btn_board" class="nav-item menuTab">
                        <a class="nav-link" href="${pageContext.request.contextPath }/board"
                           onclick="btn_board()">게시판</a>
                    </li>
                        <%--회비관리--%>
                    <li class="nav-item menuTab">
                        <a class="nav-link" href="${pageContext.request.contextPath }/membershipfee">회비관리</a>
                    </li>
                        <%--모임관리--%>
                    <li class="nav-item menuTab">
                        <a class="nav-link" href="${pageContext.request.contextPath }/groupmanage">모임관리</a>
                    </li>
                </ul>
            </div>

        </nav>
        <%--<input type="hidden" id="userNo" value="${authUser.userNo}">--%>
        <%--<input type="hidden" id="groupNo" value="${authUser.groupNo}">--%>
    </c:if>
</header>


<!-- Modal -->
<div class="modal fade" id="exampleModalCenter01" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content text-center">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                    <img alt="groupImg02" src="${pageContext.request.contextPath }/assets/images/groupImg02.png">&emsp;
                    모임 정보 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <center>
                <form id="join-form" name="joinForm" method="get" action="${pageContext.request.contextPath}/plusgroup"
                      enctype="multipart/form-data">
                    <div class="modal-body">
                        <!-- <label for="gname1">모임 이름</label> -->
                        <input type="text" class="form-control w-75 text-center" aria-label="Large"
                               aria-describedby="inputGroup-sizing-sm" id="gname1" name="gname" placeholder="모임이름"
                               value=""><br>
                        <!-- <label for="gtag1">모임 설명, 해시태그</label> -->
                        <input type="text" class="form-control w-75 text-center" aria-label="Large"
                               aria-describedby="inputGroup-sizing-sm" id="gtag1" name="gtag" placeholder="모임설명, 해시태그"
                               value=""><br>

                        <div class="form-group p-2 w-75" style="position: relative;">
                            <input type="file" class="custom-file-input" id="boardUpload" multiple="true"
                                   onchange="loadFile(event);">
                            <label class="custom-file-label text-center pr-5" for="boardUpload">이미지 업로드 &emsp;</label>
                            <img id="addImg" src="" class="w-100 mx-auto mt-3">
                        </div>

                        <br>

                        <label for="gcar1" style="font-weight: bold">*모임 성격</label>
                        <!-- <input type="text" class="form-control w-75" aria-label="Large" aria-describedby="inputGroup-sizing-sm" id="gcar1" name="gcar"> -->
                        <br>

                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="customRadioInline1" name="customRadioInline"
                                   class="custom-control-input">
                            <label class="custom-control-label" for="customRadioInline1">계모임</label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="customRadioInline2" name="customRadioInline"
                                   class="custom-control-input">
                            <label class="custom-control-label" for="customRadioInline2">동아리/동호회</label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="customRadioInline3" name="customRadioInline"
                                   class="custom-control-input">
                            <label class="custom-control-label" for="customRadioInline3">친목모임</label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="customRadioInline4" name="customRadioInline"
                                   class="custom-control-input">
                            <label class="custom-control-label" for="customRadioInline4">기타</label>
                        </div>
                        <div class="text-center mb-3">
                            <br>
                            <input class="btn btn-success" name="" type="submit" value="모임 생성하기">
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
    /*  이미지 미리보기 , 확장자 체크  */

    var goToAnnualReport = function () {
        var getYear = new Date().getFullYear();
        var getGroupNo = $("#groupNo").val();
        $("#goToAnnual").attr("href","${pageContext.request.contextPath }/annualreport/"+getGroupNo+"/"+getYear);
    }
    var goToMonthlyReport = function () {
        var getYear = new Date().getFullYear();
        var getMonth = new Date().getMonth()+1;
        $("#goToMonthly").attr("href","${pageContext.request.contextPath }/monthlyreport/"+getYear+"/"+getMonth);
    }

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


</script>


