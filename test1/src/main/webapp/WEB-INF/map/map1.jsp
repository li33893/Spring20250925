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
         <select style="margin-bottom : 20px; padding:5px" v-model="markedPosition" @change="fnSearch">
            <option value="">:: 선택 ::</option>
            <option value="MT1">대형마트</option>
            <option value="CS2">편의점</option>
            <option value="PS3">어린이집, 유치원</option>
            <option value="SC4">학교</option>
            <option value="AC5">학원</option>
            <option value="PK6">주차장</option>
            <option value="OL7">주유소, 충전소</option>
            <option value="SW8">지하철역</option>
            <option value="BK9">은행</option>
            <option value="CT1">문화시설</option>
            <option value="AG2">중개업소</option>
            <option value="PO3">공공기관</option>
            <option value="AT4">관광명소</option>
            <option value="AD5">숙박</option>
            <option value="FD6">음식점</option>
            <option value="CE7">카페</option>
            <option value="HP8">병원</option>
            <option value="PM9">약국</option>
        </select>
        <div id="map" style="width:500px;height:400px;"></div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                infowindow:null,
                map:null,//地图本图（id）
                markedPosition:"",//
                ps:null,
                markerList:[]
                
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            //回调函数callback function 
            //function greet(name, callback) {
                // console.log("你好，" + name);
                // callback(); // 这里调用了回调函数
                // }
                // function afterGreet() {
                //     console.log("欢迎来到网站！");
                // }
                // greet("小明", afterGreet);
                

                //1. 搜索完了以后调用的回调函数
                placesSearchCB (data, status, pagination) {
                    let self=this;
                    if (status === kakao.maps.services.Status.OK) {
                        for (var i=0; i<data.length; i++) {
                                self.displayMarker(data[i]);    
                        }       
                    }
                },

                //2. 显示地图标记
                displayMarker(place) {
                    //生成地图标记并显示
                    let self=this;
                    var marker = new kakao.maps.Marker({
                        map: self.map,
                        position: new kakao.maps.LatLng(place.y, place.x) 
                    });

                    //！！！这段为什么不能在上面的display下面：因为marker是局部变量
                    this.markerList.push(marker);

                    // 生成地图标记的点击事件
                    kakao.maps.event.addListener(marker, 'click', function() {
                        self.infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
                        self.infowindow.open(self.map, marker);
                    });
                },

                fnSearch(){
                    let self=this;

                    for(let i=0; i<self.markerList.length;i++){
                    self.markerList[i].setMap(null);
                    }
                    //先清空
                    self.markerList=[];
                    self.ps.categorySearch(self.markedPosition, self.placesSearchCB, {useMapBounds:true});
                }
            
           
            
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            //1. 提示地址信息，点击时才会生效
            self.infowindow = new kakao.maps.InfoWindow({zIndex:1});


            //2.地图
            //2.1地图本图（容器）
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            //2.2地图初始化的配置
            mapOption = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표//逗号是为了一个var可以声明多个变量
                level: 3 // 지도의 확대 레벨
            };  
            //2.3生成地图 
            self.map = new kakao.maps.Map(mapContainer, mapOption); 


            //3.被搜索的地点
            self.ps = new kakao.maps.services.Places(self.map); 


            // 4.调用搜索方法
            //搜索的对象ps.搜索地点方法（搜索的东西，遍历搜多后调用的方法，分页）
            // ps.categorySearch(self.markedPosition, self.placesSearchCB, {useMapBounds:true}); 
            
        }
    });

    app.mount('#app');
</script>
