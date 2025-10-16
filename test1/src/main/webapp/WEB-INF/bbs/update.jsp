<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
       
        #board table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
        }
        th{
            background-color: beige;
        }
        input{
            width: 350px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <table>
                <tr>
                    <th>제목</th>
                    <th>내용</th>
                    <th>조회수</th>
                    <th>작성일</th>
                </tr>
                <tr>
                    <td><input type="text" v-model="title"></td>
                    <td><input type="text" v-model="contents"></td>
                    <td>{{bbs.hit}}</td>
                    <td>{{bbs.cdate}}</td>
                </tr>
            </table>
         </div>

         <div>
            <button @click="fnBBSUpdate">
                수정
            </button>
         </div>


        
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                bbsNum:"${bbsNum}",
                bbs:{},
                sessionId:"${sessionId}",
                userId:"${sessionId}",
                title:"",
                contents:"",
                hit:0,
                cdate:""     
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnBBS: function () {
                let self = this;
                let param = {
                    bbsNum:self.bbsNum
                };
                $.ajax({
                    url: "/bbs/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.bbs=data.bbs;
                        self.title=self.bbs.title;
                        self.contents=self.bbs.contents;    
                    }
                });
            },
            fnBBSUpdate: function () {
                let self = this;
                let param = {
                    bbsNum:self.bbsNum
                };
                $.ajax({
                    url: "/bbs/update.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.bbs=data.bbs;
                        
                    }
                });
            },
           
            

        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnBBS();
            
        }
    });

    app.mount('#app');
</script>