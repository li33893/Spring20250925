<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5e03846a5bae385cef3b2da33124bd8d&libraries=services"></script>
    <style>
        
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <input type="text" v-model="keyWord">
            <button @click="fnSearch">search</button>
         </div>
         <div id="map" style="width:500px;height:400px;"></div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 全局变量 - (key : value)
                map: null,
                ps: null,
                infowindow: null,
                keyWord:""
            };
        },
        methods: {
            // 키워드 검색 완료 시 호출되는 콜백함수 입니다
            placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {
                    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                    // LatLngBounds 객체에 좌표를 추가합니다
                    var bounds = new kakao.maps.LatLngBounds();

                    for (var i=0; i<data.length; i++) {
                        this.displayMarker(data[i]);    
                        bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                    }       

                    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                    this.map.setBounds(bounds);
                } 
            },

            // 지도에 마커를 표시하는 함수입니다
            displayMarker(place) {
                // 마커를 생성하고 지도에 표시합니다
                var marker = new kakao.maps.Marker({
                    map: this.map,
                    position: new kakao.maps.LatLng(place.y, place.x) 
                });

                // 마커에 클릭이벤트를 등록합니다
                kakao.maps.event.addListener(marker, 'click', () => {
                    // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
                    this.infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
                    this.infowindow.open(this.map, marker);
                });
            },
            
            fnSearch(){
                this.ps.keywordSearch(this.keyWord, this.placesSearchCB.bind(this));
            }
        }, // methods
        mounted() {
            // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
            this.infowindow = new kakao.maps.InfoWindow({zIndex:1});

            var mapContainer = document.getElementById('map'), // 지도를 표시할 div (局部变量)
                mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };  

            // 지도를 생성합니다    
            this.map = new kakao.maps.Map(mapContainer, mapOption); 

            // 장소 검색 객체를 생성합니다
            this.ps = new kakao.maps.services.Places(); 

            // 키워드로 장소를 검색합니다
             
        }
    });

    app.mount('#app');
</script>