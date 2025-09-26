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
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
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
                    <th>작성자</th>
                    <th>내용</th>
                </tr>
                <tr>
                    <td><input type="text" v-model="title"></td>
                    <td><input type="text" v-model="userId"></td>
                    <td><textarea v-model="content"></textarea></td>
                </tr>
            </table>
            <div><button @click="fnInsert()">삽입</button></div>
        </div>
		
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
				userId:"",
                boardNo:"",
                title:"",
                cnt:0,
                list:[],
                kind:"",
                option:"boardNo",
                content:""
				
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInsert: function () {
                let self = this;
                let param = {
                    userId:self.userId,
                    content:self.content,
                    title:self.title
				};
                $.ajax({
                    url: "board-add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삽입되었습니다.");
                        location.href="board-list.do";
						
                    }
                });
            },


          
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        
        }
    });

    app.mount('#app');
</script>