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
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>내용</th>
                    <th>조회수</th>
                </tr>
                <tr>
                    <td>{{boardNo}}</td>
                    <td>{{info.title}}</td>
                    <td>{{info.userId}}</td>
                    <td>{{info.content}}
                        <img v-for="item in fileList" :src="item.filePath">
                        <div v-html="info.contents2"></div>
                    </td>
                    <td>{{info.cnt}}</td>
                

                </tr>
            </table>
         </div>


           <div>
            <table>
                <tr >
                    <th>닉네임</th>
                    <th>작성 내용</th>
                    <th>삭제</th>
                    <th>수정</th>
                </tr>
               
                <tr v-for="comment in commentList">
                    <td>{{comment.nickName}}</td>
                    <td>{{comment.contents}}</td>
                    <td><button>삭제</button></td>
                    <td><button>수정</button></td>
                </tr>
            </table>
         </div>

        <hr>
        <table id="input">
            <th>댓글 입력</th>
            <td>
                <textarea cols="40" rows="4" v-model="content">
                    <br>
                    <div ></div>
                </textarea>
            </td>
            <td><button @click="fnAddComment">저장</button></td>
        </table>

        
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                boardNo:"${boardNo}",
                info:{},
                commentList:[],
                content:"",
                sessionId:"${sessionId}",
                cnt:0,
                fileList:[],
                commentcontent:"",
                
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {
                    boardNo:self.boardNo
                };
                $.ajax({
                    url: "board-view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info=data.info;
                        self.commentList=data.commentList;
                        self.fileList=data.fileList;

                    }
                });
            },
            fnAddComment:function(content){
                let self=this;
                 let param = {
                    boardNo:self.boardNo,
                    content:self.content,
                    id:self.sessionId,
                    commentContent:self.commentContent,
                };

                $.ajax({
                    url: "/comment/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        alert(data.msg);
                        self.fnInfo();
                        self.content="";

                    }
                });
                
            },
            fnCntPlus:function(cnt){
                let self=this;   
                let param={
                    cnt:self.cnt,
                    boardNo:self.boardNo
                }
                 $.ajax({
                    url: "",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        
                    }
                });                
            }

        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
            self.fnCntPlus();
        }
    });

    app.mount('#app');
</script>