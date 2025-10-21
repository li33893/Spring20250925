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
                    <th>교수번호</th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>주소</th>
                    <th>소속학과 이름</th>
                </tr>
                <tr>
                    <td>{{prof.profNo}}</td>
                    <td><input type="text" v-model="name"></td>
                    <td><input type="text" v-model="id"></td>
                    <td><input type="text" v-model="address"></td>
                    <td><input type="text" v-model="dName"></td>
                </tr>
            </table>
         </div>

         <div>
            <button @click="fnProf">
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
                profNo:"${profNo}",
                deptNo:"${deptNo}",
                prof:{},
                // sessionId:"${sessionId}",
                // userId:"${sessionId}",
                name:"",
                id:"",
                address:"",
                dName:""     
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnProf: function () {
                let self = this;
                let param = {
                    profNo:self.profNo
                };
                $.ajax({
                    url: "/prof/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.prof=data.prof;
                        self.name=data.prof.name;
                        self.id=data.prof.id;    
                        self.address=data.prof.address;    
                        self.dName=data.prof.dName;    
                    }
                });
            },
            fnProfUpdate: function () {
                let self = this;
                let param = {
                    profNo:self.profNo,
                    name:self.name,
                    id:self.id,
                    address:self.address,
                    dName:self.dName

                };
                $.ajax({
                    url: "/prof/edit.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("수정되었습니다.");
                        self.fnBack();
                        
                    }
                });
            },

            fnDUpdate: function () {
                let self = this;
                let param = {
                    deptNo:self.deptNo

                };
                $.ajax({
                    url: "/d/edit.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("수정되었습니다.");
                        self.fnBack();    
                    }
                });
            },

            fnBack:function(){
                location.href="/prof/list.do";
            }

            
           
            

        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnProf();
            
        }
    });

    app.mount('#app');
</script>
