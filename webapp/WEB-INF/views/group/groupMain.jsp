<%--
  Created by IntelliJ IDEA.
  User: cnrp
  Date: 2018-07-03
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<!-- <meta name="viewport" content="width=device-width", initial-scale="1"> 반응형 -->
<title>모두의 가계부</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/css/bootstrap.css">
<!-- stylesheet 외부의 css 가져오겟다 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/css/Modu_sh.css">
<!-- stylesheet 외부의 css 가져오겟다 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic"
	rel="stylesheet">

</head>
<body style="overflow-x: hidden; overflow-y: auto;">

	<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

	<div class="container">

		<br>
		<br>

	<div class="news form-control">
		<table width="100%">
			<tr>
				<td align="center"><strong>새소식</strong></td>
				<c:if test="${!empty newsList }">
					<c:forEach var="newsList" items="${newsList}">
						<tr>
							<td><a href="${pageContext.request.contextPath }/reportbytag/${authUser.groupNo }/${newsList.tagNo}">
									<${newsList.tagName}> 보고서가 작성되었습니다.</a></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty newsList }">
					<tr>
						<td align="center">새 소식이 없습니다</td>
					</tr>
				</c:if>
			</tr>
		</table>
	</div>


	<div id="map"
		style="width: 50%; height: 400px; margin: auto auto 50px auto"></div>
	</div>


	<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>


	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script
		src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/header.js"></script>
	<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=slvC1SL1B78rI5IoCUhs&submodules=geocoder"></script>
	<script type="text/javascript">
		$(".carousel").carousel({
			interval : 10000
		})
		var map = new naver.maps.Map('map');
		var myaddress = '서울특별시 서초구 서초대로74길33'; // 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
		naver.maps.Service.geocode({
			address : myaddress
		}, function(status, response) {
			if (status !== naver.maps.Service.Status.OK) {
				// return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
			}
			var result = response.result;
			// 검색 결과 갯수: result.total
			// 첫번째 결과 결과 주소: result.items[0].address
			// 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
			var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
			map.setCenter(myaddr); // 검색된 좌표로 지도 이동
			// 마커 표시
			var marker = new naver.maps.Marker({
				position : myaddr,
				map : map
			});
			// 마커 클릭 이벤트 처리
			naver.maps.Event.addListener(marker, "click", function(e) {
				if (infowindow.getMap()) {
					infowindow.close();
				} else {
					infowindow.open(map, marker);
				}
			});
			// 마크 클릭시 인포윈도우 오픈
			var infowindow = new naver.maps.InfoWindow({
				content : '<h4> [여기가 현재위치]</h4><a href="file:///D:/bootstrap-4.1.1-dist/sample.html#" target="_blank"><img src="../../../assets/images/club03.png" alt="??"></a>'
			});
		});
	</script>
</body>
</html>