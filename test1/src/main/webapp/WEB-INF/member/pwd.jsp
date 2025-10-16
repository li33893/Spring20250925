
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>

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
         <div v-if="!authFlg">
            <div>
                <label>아이디<input v-model="userId"></label>
            </div>
            <div>
                <label>이름<input v-model="name"></label>
            </div>
            
            <div>
                <label>번호<input v-model="phone">"-" 없이 입력</label>
            </div>
            <div>
                <button @click="fnAuth">인증</button>
            </div>
         </div>

    


    <div v-else>
        <div>
            <label>비밀번호: <input v-model="pwd1"></label>
        </div>
        <div>
            <label>비밀번호 확인:<input v-model="pwd2"></label>
        </div>
        
        <div>
            <button @click="fnUpdatePwd">확인</button>
        </div>
    </div>
</div>
</body>
</html>

<script>
    IMP.init("imp12485203"); // 예: imp00000000

    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                authFlg:false,
                userId:"",
                name:"",
                phone:"",
                pwd1:"",
                pwd2:""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAuth: function () {
                let self = this;
                let param = {
                    userId:self.userId,
                    name:self.name,
                    phone:self.phone
                };
                $.ajax({
                    url: "/member/search.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result=="success"){
                            // return self.authFlg=true;
                            self.fnCerti();

                        }else{
                            alert(data.msg);
                        }
                        
                    }
                });
            },

            fnUpdatePwd:function(){
                let self = this;
                let param = {
                    pwd:self.pwd1,
                    userId:self.userId,
                    id:self.userId
                };

                 if(self.pwd1!=self.pwd2){
                    self.fnAuth();
                }else{
                    $.ajax({
                    url: "/member/updatepwd.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result==true){
                            alert(data.msg);
                            
                        }else{
                            alert(data.msg);
                        }
                        
                        
                    }
                });
            }
                

                

            },

            fnCerti:function(){
                let self=this;
                // IMP.certification(param, callback) 호출
                IMP.certification(
                {
                    // param
                    channelKey: "{channel-key-ca48c447-a980-48f2-b883-6074f4598d80}",
                    merchant_uid: "merchant_"+new Date().getTime() // 주문 번호
                    
                    
                },
                function (rsp) {
                    
                    // callback
                    if (rsp.success) {
                    // 인증 성공 시 로직
                        alert("certification succeeded");
                        console.log(rsp);
                        self.authFlg=true;
                        
                    } else {
                    // 인증 실패 시 로직
                        alert("ceritification failed");
                        console.log(rsp);
                        
                    }
                },
                );
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>



