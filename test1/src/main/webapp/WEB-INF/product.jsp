<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>쇼핑몰 헤더</title>
    <link rel="stylesheet" href="/css/product-style.css">
    <script src="/js/page-change.js"></script>
</head>

<body>
    <div id="app">
        <header>
            <div class="logo">
                <img src="/img/logo.png" alt="쇼핑몰 로고">
            </div>

            <nav>
                <ul> 
                    <li class="dropdown" v-for="menu in menuList">
                        <a href="javascript:;" v-if="menu.depth==1" @click="fnList(menu.menuNo,'')">{{menu.menuName}}</a>
                        <ul class="dropdown-menu" v-if="menu.cnt>0">
                            <span v-for="subMenu in menuList">
                                <li v-if="menu.menuNo==subMenu.menuPart"><a href="javascript:;" @click="fnList('',subMenu.menuNo)">{{subMenu.menuName}}</a></li>
                            </span>
                        </ul>
                    </li>
                
                    
                    <!-- <li class="dropdown">
                        <a href="javascript:;"  @click="fnList('한식')" >한식</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">비빔밥</a></li>
                            <li><a href="#">김치찌개</a></li>
                            <li><a href="#">불고기</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="javascript:;"  @click="fnList('중식')" >중식</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">짜장면</a></li>
                            <li><a href="#">짬뽕</a></li>
                            <li><a href="#">마파두부</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="javascript:;"  @click="fnList('양식')" >양식</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">피자</a></li>
                            <li><a href="#">파스타</a></li>
                            <li><a href="#">스테이크</a></li>
                        </ul>
                    </li>
                    <li><a href="#">디저트</a></li>
                    <li><a href="#">음료</a></li> -->
                </ul>
            </nav>
            <div class="search-bar">
                <input type="text" placeholder="상품을 검색하세요..." @keyup.enter="fnList('','')" v-model="keyWord">
                <button @click="fnList('','')">검색</button>
            </div>
            <div class="login-btn">
                <button>로그인</button>
            </div>
        </header>

        <main>
            <section class="product-list">
                <!-- 제품 항목 -->

                 <div class="product-item" v-for="food in foodList">
                    <img :src="food.filePath" alt="제품 1">
                    <h3><a href="javascript:;" @click="fnView(food.foodNo)">{{food.foodName}}</a></h3>
                    <p>{{food.foodInfo}}</p>
                    <p class="price">₩{{food.price.toLocaleString()}}</p>
                </div>

            </section>
        </main>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                foodList:[],
                keyWord:"",
                menuList:[],
                foodNo:""

            };
        },
        methods: {
            fnList(part,menuNo) {
                var self = this;
                var nparmap = {
                    keyWord:self.keyWord,
                    menuPart:part,
                    menuNo:menuNo
                    
                };
                $.ajax({
                    url: "/product/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        self.foodList=data.foodList;
                        self.menuList=data.menuList;

                    }
                });
            },
            fnView:function(foodNo){
                
                pageChange("/product/view.do",{foodNo:foodNo});

            },
        },
        mounted() {
            var self = this;
            self.fnList('','');
        }
    });
    app.mount('#app');
</script>