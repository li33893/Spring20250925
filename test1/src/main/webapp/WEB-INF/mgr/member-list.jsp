<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
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
        <table>
            <tr>
                <th>아이디</th>
                <th>비밀번호</th>
                <th>이름</th>
                <th>생일</th>
                <th>닉네임</th>
                <th>주소</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>성별</th>
                <th>상태</th>
                <th>가입날짜</th>
                <th>로그인 오류수</th>
                <th>계정 정지 해제</th>
            </tr>
            <tr v-for="member in memberList">
                <td>
                    <a href="javascript:;" @click="fnView(member.userId)">{{member.userId}}</a>
                </td>
                <td>{{member.passWord}}</td>
                <td>{{member.name}}</td>
                <td>{{member.dateofBirth}}</td>
                <td>{{member.nickName}}</td>
                <td>{{member.address}}</td>
                <td>{{member.phone}}</td>
                <td>{{member.email}}</td>
                <td>{{member.gender}}</td>
                <td>{{member.status}}</td>
                <td>{{member.joinTime}}</td>
                <td>{{member.cnt}}</td> 
                <td><button v-if="member.cnt>=5" @click="fnRemoveCnt(member.userId)">계정 정지 해제</button></td>
        
            </tr>
        </table>

       
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                memberList:[],
                selectedItem:""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/mgr/member/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.memberList=data.memberList;
                    }
                });
            },
            fnRemoveCnt:function(userId){
                let self = this;
                let param = {
                    id:userId
                };
                $.ajax({
                    url: "/mgr/remove-cnt.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result=="success"){
                            alert("계정정지가 헤지되었습니다!");
                            self.fnList();
                        }else{
                            alert("계정정지가 실패하였습니다.");
                            
                        }
                        
                    }
                });

            },

            fnView:function(userId){
                pageChange("/mgr/member/view.do",{userId,userId});
                
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>


