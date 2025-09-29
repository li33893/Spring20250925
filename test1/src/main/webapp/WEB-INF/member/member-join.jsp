<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
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

        #testul{
            list-style: none;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div>
                <label >id <input type="text" v-model="id"></label>
                <button @click="fnRepCheck(id)">중복체크</button>
            </div>
            <div>
                <label >password <input type="password" v-model="pwd" @input="fnValidatePassword" ></label>
                <ul class="checklist" id="testul">
                    <li :style="{color: hasNumber ? 'green' : 'red'}">
                    <span class="material-symbols-outlined check-icon">{{ hasNumber ? 'Check_Small' : 'Close_Small' }}</span>
                    숫자 포함
                    </li>
                    <li :style="{color: hasAlphabet ? 'green' : 'red'}">
                    <span class="material-symbols-outlined check-icon">{{ hasAlphabet ? 'Check_Small' : 'Close_Small' }}</span>
                    영어문자 포함
                    </li>
                    <li :style="{color: hasSpecial ? 'green' : 'red'}">
                    <span class="material-symbols-outlined check-icon">{{ hasSpecial ? 'Check_Small' : 'Close_Small' }}</span>
                    특수문자 포함
                    </li>
                    <li :style="{color: lenEnough ? 'green' : 'red'}">
                    <span class="material-symbols-outlined check-icon">{{ lenEnough ? 'Check_Small' : 'Close_Small' }}</span>
                    길이 8자 이상
                    </li>
                    <li :style="{color: withoutInvalidChar ? 'green' : 'red'}">
                    <span class="material-symbols-outlined check-icon">{{ withoutInvalidChar ? 'Check_Small' : 'Close_Small' }}</span>
                    허용되지 않은 문자 없음
                    </li>
                </ul>
                <label>비밀번호 확인<span class="required">※</span></label>
                <input type="password" v-model="confirmPwd" />
            </div>
            <div>
                주소: <input v-model="addr"><button @click="fnAddr">주소검색</button>
            </div>

            <div>
                문자인증: <input v-model="inputNum" :placeholder="timer">
                <template v-if="!smsFlg">
                    <button @click="fnSms">문자인증 번호 전송</button>
                </template>
                <template v-else>
                    <button>인증</button>
                </template>
            </div>

            <div>
                {{timer}}
                <button @click="fnTimer">시작</button>
            </div>

            
    </div>
</body>
</html>

<script>
    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            
			console.log(roadFullAddr);
			console.log(roadAddrPart1);
			console.log(addrDetail);
            window.vueObj.fnResult(roadFullAddr, roadAddrPart1, addrDetail);
    }

    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                id:"",
                pwd:"",
                hasNumber: false,
                hasAlphabet: false,
                hasSpecial: false,
                lenEnough: false,
                withoutInvalidChar: false,
                addr:"",
                inputNum:"",
                smsFlg:false,
                timer:180
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        
                    }
                });
            },
            fnRepCheck: function (id) {
                let self = this;
                let param = {
                    id:self.id
                };
                $.ajax({
                    url: "/member/check.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.msg);

                    }
                });
            },
            fnSms:function(){
                let self=this;
                let param = {
                   
                };
                $.ajax({
                    url: "/send-one",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.msg);
                        console.log(data);
                        if(data.res.statusCode=="2000"){
                            alert("문자 전송 완료");
                            self.smsFlg=true;
                            self.fnTimer();

                        }else{
                            alert("잠시 후 다시 시도 해주세요.");
                        }


                    }
                });

            },

            fnAddr:function(){
                window.open("/addr.do","addr","width=500,height=500")
            },

            fnValidatePassword() {
                const pwd = this.pwd;
                this.lenEnough = pwd.length >= 8;
                this.hasNumber = /[0-9]/.test(pwd);
                this.hasAlphabet = /[A-Za-z]/.test(pwd);
                this.hasSpecial = /[^A-Za-z0-9]/.test(pwd);
                this.withoutInvalidChar = /^[A-Za-z0-9!@#$%^&*]+$/.test(pwd);
            },

            fnResult:function(roadFullAddr, roadAddrPart1, addrDetail){
                let self=this;
                self.addr=roadFullAddr;

            },

            fnTimer:function(){
                 let self=this;
                    let int=setInterval(()=>{
                        self.timer-=1;
                        if(self.timer==0){
                            clearInterval(int);
                            alert("시간이 만료되었습니다");
                        }
                    },1000);
            }

            
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            window.vueObj=this;
        }
    });

    app.mount('#app');
</script>