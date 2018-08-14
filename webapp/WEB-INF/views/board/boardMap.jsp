<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>테스트 인덱스</title>
</head>
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath }/assets/jquery/jquery.autocomplete.css"/>
<body>
<hr>
<h2>테스트용</h2>


<input type="text" id="address" placeholder="주소입력">
<input type="button" id="submit" value="검색">
<div id="map" style="width:400px;height:400px;"></div>

<table id="resultTable">
</table>
<table id="selectedShop">
</table>

</body>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript"
        src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=slvC1SL1B78rI5IoCUhs&submodules=geocoder"></script>
<script>
    var map = new naver.maps.Map("map", {
        center: new naver.maps.LatLng(37.3595316, 127.1052133),
        zoom: 10,
        mapTypeControl: true
    });

    var infoWindow = new naver.maps.InfoWindow({
        anchorSkew: true,
        disableAnchor:true
    });

    map.setCursor('pointer');

    // search by tm128 coordinate
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

            infoWindow.setContent(['<div style="padding:10px;min-width:0px;line-height:150%;">', '<h4 style="margin-top:5px;">검색 좌표</h4><br />', htmlAddresses.join('<br />'), '</div>'].join('\n'));

            infoWindow.open(map, latlng);
            console.log(item.addrdetail);
        });
    }

    // result by latlng coordinate
    //주소를 좌표로 바꿔주고 지도에 찍기
    function searchAddressToCoordinate(address) {
        console.log("searchAddressToCoordinate");
        naver.maps.Service.geocode({
            address: address
        }, function (status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                return alert('Something Wrong!');
            }

            var item = response.result.items[0],
                addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]',
                point = new naver.maps.Point(item.point.x, item.point.y);

            infoWindow.setContent([
                '<div style="padding:10px;min-width:200px;line-height:150%;">',
                '<h4 style="margin-top:5px;">검색 주소 : ' + response.result.userquery + '</h4><br />', addrType + ' ' + item.address + '<br />',
                '</div>'
            ].join('\n'));


            map.setCenter(point);
            infoWindow.open(map, point);
        });
    }

    function initGeocoder() {
        console.log("initGeocoder");
        map.addListener('click', function (e) {
            searchCoordinateToAddress(e.coord);
        });

        $('#address').on('keydown', function (e) {
            var keyCode = e.which;

            if (keyCode === 13) { // Enter Key
                searchAddressToCoordinate($('#address').val());
                // console.log("입력 값 : "+$("#address").val());
            }
        });

        $('#submit').on('click', function (e) {
            console.log("When button is on clicked");
            e.preventDefault();

            var localName = $('#address').val();
            $.ajax({
                url: "${pageContext.request.contextPath }/searchLocal",
                type: "post",
                data: {localName: localName},
                dataType: "json",
                success: function (result) {
                    $("#resultTable").empty();
                    var itemmm = JSON.parse(result).items;
                    console.log(itemmm);
                    for (var i = 0; i < itemmm.length; i++) {
                        $("#resultTable").append("<tr><td><button onclick='searchAddressToCoordinate(\"" + itemmm[i].roadAddress + "\")'>장소 : " + itemmm[i].title + "</button></td><td>주소 : " + itemmm[i].roadAddress + "</td><td>전화번호 : " + itemmm[i].telephone + "</td>" +
                            "<td><img src='" + itemmm[i].thumbnail + "'</img></td><td><button onclick='DataBaseInputTest(\"" + itemmm[i].roadAddress + "\")'>선택</button></td></tr>")
                    }
                }, error: function () {
                    alert("통신 실패");
                }
            });
            // searchAddressToCoordinate();
            // console.log("입력 값 : "+$("#address").val());
        });

        // searchAddressToCoordinate('정자동 178-1');
    }

    function DataBaseInputTest(selectedShop) {
        console.log("searchAddressToCoordinate");
        naver.maps.Service.geocode({
            address: selectedShop
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

            $.ajax({
                url: "${pageContext.request.contextPath }/whenShopIsSelected",
                type: "post",
                data: {country:country,sido:sido,sigugun:sigugun,dongmyun:dongmyun,ri:ri,rest:rest},
                dataType: "json",
                success: function (result) {
                    if (result == 1){
                    console.log("성공")}
                }, error: function () {
                    alert("통신 실패");
                }
            });
        });
    }

    naver.maps.onJSContentLoaded = initGeocoder;

</script>
</html>