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
        .map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
        .map_wrap {position:relative;width:100%;height:350px;}
        #category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
        #category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
        #category li.on {background: #eee;}
        #category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
        #category li:last-child{margin-right:0;border-right:0;}
        #category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
        #category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
        #category li .bank {background-position: -10px 0;}
        #category li .mart {background-position: -10px -36px;}
        #category li .pharmacy {background-position: -10px -72px;}
        #category li .oil {background-position: -10px -108px;}
        #category li .cafe {background-position: -10px -144px;}
        #category li .store {background-position: -10px -180px;}
        #category li.on .category_bg {background-position-x:-46px;}
        .placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
        .placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
        .placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
        .placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
        .placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
        .placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
        .placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
        .placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
        .placeinfo .tel {color:#0f7833;}
        .placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
        
    </style>
</head>
<body>
    <div id="app">
        <p style="margin-top:-12px">
            <em class="link">
                <a href="/web/documentation/#CategoryCode" target="_blank">카테고리 코드목록을 보시려면 여기를 클릭하세요!</a>
            </em>
        </p>
        <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
            <ul id="category">
                <li id="BK9" data-order="0" @click="onClickCategory"> 
                    <span class="category_bg bank"></span>
                    은행
                </li>       
                <li id="MT1" data-order="1" @click="onClickCategory"> 
                    <span class="category_bg mart"></span>
                    마트
                </li>  
                <li id="PM9" data-order="2" @click="onClickCategory"> 
                    <span class="category_bg pharmacy"></span>
                    약국
                </li>  
                <li id="OL7" data-order="3" @click="onClickCategory"> 
                    <span class="category_bg oil"></span>
                    주유소
                </li>  
                <li id="CE7" data-order="4" @click="onClickCategory"> 
                    <span class="category_bg cafe"></span>
                    카페
                </li>  
                <li id="CS2" data-order="5" @click="onClickCategory"> 
                    <span class="category_bg store"></span>
                    편의점
                </li>      
            </ul>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                placeOverlay:null,
                map:null,
                contentNode:null,
                currCategory:"",
                ps:null,
                markers:[]
            };
        },
        methods: {
            
            //1.生成浮窗 
            displayPlaceInfo (place) {
                var content = '<div class="placeinfo">' +
                '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   

                if (place.road_address_name) {
                    content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
                } else {
                    content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
                }                
   
                content += '    <span class="tel">' + place.phone + '</span>' + 
                '</div>' + 
                '<div class="after"></div>';

               this.contentNode.innerHTML = content;
               this.placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
               this.placeOverlay.setMap(this.map);  
            },

            //2.生成categories的点击事件
            // 각 카테고리에 클릭 이벤트를 등록합니다
            addCategoryClickEvent() {
                var category = document.getElementById('category'),
                children = category.children;

                for (var i=0; i<children.length; i++) {
                    children[i].onclick = this.onClickCategory;
                }
            },



            //3.点击后的函数
            // 카테고리를 클릭했을 때 호출되는 함수입니다
            onClickCategory() {
                const element = event.currentTarget;  // ✅ 获取被点击的元素
                const id = element.id;                // ✅ 从元素获取 id
                const className = element.className;   // ✅ 从元素获取 className
                this.placeOverlay.setMap(null);

                if (className === 'on') {
                    this.currCategory = '';
                    this.changeCategoryClass();
                    this.removeMarker();
                } else {
                    this.currCategory = id;
                    this.changeCategoryClass(this);
                    this.searchPlaces();
                }
            },


            //点击时点击的categor样式发生改变
            changeCategoryClass(el) {
                var category = document.getElementById('category'),
                    children = category.children,
                    i;

                for ( i=0; i<children.length; i++ ) {
                    children[i].className = '';
                }

                if (el) {
                    el.className = 'on';
                } 
            },

            //清除地图上的marker
            removeMarker() {
                for ( var i = 0; i < this.markers.length; i++ ) {
                    this.markers[i].setMap(null);
                }   
                this.markers = [];
            },

            //搜索地点
            searchPlaces() {
                 if (!this.currCategory) {
                return;
                }
                this.ps.categorySearch(
                this.currCategory,           // 搜索的类别代码
                (data, status, pagination) => {  // 搜索完成的回调函数
                    this.placesSearchCB(data, status, pagination);
                }, 
                {
                    useMapBounds: true  // 只搜索当前地图可见范围
                }
                );
            }, 
            
            

            //4.搜索结束以后回调的函数(产生marker)
            placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {

                    // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
                    this.displayPlaces(data);
                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                    // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

                } else if (status === kakao.maps.services.Status.ERROR) {
                    // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
                    
                }
            },

            displayPlaces(places) {

                // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
                // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
                var order = document.getElementById(this.currCategory).getAttribute('data-order');



                this.removeMarker();  // ✅ 添加：先清除旧标记

                 for (let i = 0; i < places.length; i++) {
                    const marker = this.addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

                    ((m, p) => {  // ✅ 使用箭头函数
                        kakao.maps.event.addListener(m, 'click', () => {  // ✅ 内部也用箭头函数
                            this.displayPlaceInfo(p);  // ✅ this 正确指向 Vue 实例
                        });
                    })(marker, places[i]);
                }
            },

            addMarker(position, order) {
                var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                    imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
                    imgOptions =  {
                        spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
                        spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                        offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                    },
                    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                        marker = new kakao.maps.Marker({
                        position: position, // 마커의 위치
                        image: markerImage 
                    });

                marker.setMap(this.map); // 지도 위에 마커를 표출합니다
                this.markers.push(marker);  // 배열에 생성된 마커를 추가합니다

                return marker;
            },

            // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
            addEventHandle(target, type, callback) {
                if (target.addEventListener) {
                    target.addEventListener(type, callback);
                } else {
                    target.attachEvent('on' + type, callback);
                }
            },

           
            
           
            
        }, // methods
        mounted() {
            // let self=this;
            // // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
            // self.placeOverlay = new kakao.maps.CustomOverlay({zIndex:1});
        
            
            // var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            //     mapOption = {
            //         center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            //         level: 5 // 지도의 확대 레벨
            //     };  

            // // 지도를 생성합니다    
            // self.map = new kakao.maps.Map(mapContainer, mapOption); 

            // // 장소 검색 객체를 생성합니다
            // self.ps = new kakao.maps.services.Places(map); 

            // // 지도에 idle 이벤트를 등록합니다
            // kakao.maps.event.addListener(map, 'idle', searchPlaces);

            // // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
            // contentNode.className = 'placeinfo_wrap';

            // // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
            // // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
            // self.addEventHandle(self.contentNode, 'mousedown', kakao.maps.event.preventMap);
            // self.addEventHandle(self.contentNode, 'touchstart', kakao.maps.event.preventMap);

            // // 커스텀 오버레이 컨텐츠를 설정합니다
            // self.placeOverlay.setContent(self.contentNode);  

            // // 각 카테고리에 클릭 이벤트를 등록합니다
            // self.addCategoryClickEvent();


          
            // ✅ 1. 先创建 contentNode
            this.contentNode = document.createElement('div');
            this.contentNode.className = 'placeinfo_wrap';

            // ✅ 2. 创建覆盖层
            this.placeOverlay = new kakao.maps.CustomOverlay({zIndex: 1});
            this.placeOverlay.setContent(this.contentNode);

            // ✅ 3. 创建地图
            const mapContainer = document.getElementById('map');
            const mapOption = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567),
                level: 5
            };
            this.map = new kakao.maps.Map(mapContainer, mapOption);

            // ✅ 4. 创建搜索对象（传入 this.map）
            this.ps = new kakao.maps.services.Places(this.map);

            // ✅ 5. 注册地图事件（使用箭头函数）
            kakao.maps.event.addListener(this.map, 'idle', () => {
                this.searchPlaces();
            });

            // ✅ 6. 注册覆盖层事件
            this.addEventHandle(this.contentNode, 'mousedown', kakao.maps.event.preventMap);
            this.addEventHandle(this.contentNode, 'touchstart', kakao.maps.event.preventMap);

            // ✅ 7. 删除 addCategoryClickEvent() 调用




        
            
        }
    });

    app.mount('#app');
</script>
