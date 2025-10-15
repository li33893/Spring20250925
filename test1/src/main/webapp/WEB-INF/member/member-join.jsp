<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
        <style>
            table,
            tr,
            td,
            th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
                text-align: center;
            }

            th {
                background-color: beige;
            }

            tr:nth-child(even) {
                background-color: azure;
            }

            #testul {
                list-style: none;
            }

            .phone {
                width: 40px;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div>
                <label>id <input type="text" v-model="id" v-if="!checkFlg">
                <input type="text" v-model="id" v-else disabled></label>
                <button @click="fnRepCheck(id)">중복체크</button>
            </div>
            <div>
                <label>password <input type="password" v-model="pwd"></label>
            </div>
            <div>
                <label>
                비밀번호 확인<input type="password" v-model="pwd2" /></label>
            </div>
        

            <div>
                이름: <input v-model="name">
            </div>

            <div>
                주소: <input v-model="addr" disabled><button @click="fnAddr">주소검색</button>
            </div>

            <div>
                핸드폰 번호:
                <!--oninput会在用户输入的时候触发-->
                <input class="phone" v-model="phone1" maxlength="3" size="3" >-
                <input class="phone" v-model="phone2" maxlength="4" size="4" >-
                <input class="phone" v-model="phone3" maxlength="4" size="4">
            </div>

            <div v-if="!joinFlg">
                문자인증: <input v-model="inputNum" :placeholder="timer">
                <template v-if="!smsFlg">
                    <button @click="fnSms">문자인증 번호 전송</button>
                </template>
                <template v-else>
                    <button @click="fnSmsAuth">인증</button>
                </template>
            </div>
            <div v-else style="color:red">
                문자인증이 완료되었습니다.
            </div>

            <div>
                성별:
                <label><input type="radio" name="gender" value="M">남</label>
                <label><input type="radio" name="gender" value="F">여</label>
            </div>

            <div>
                가입 권한:
                <select v-model="status">
                    <option value="A">관리자</option>
                    <option value="S">판매자</option>
                    <option value="C">소비자</option>
                </select>
            </div>

            <div><button @click="fnJoin">회원 가입</button></div>


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
                    id: "",
                    pwd: "",
                    pwd2: "",
                    name: "",
                    addr: "",
                    phone1: "",
                    phone2: "",
                    phone3: "",
                    gender: "M",
                    status: "A",

                    inputNum: "",
                    smsFlg: false,
                    timer: "",
                    count: 180,
                    joinFlg: false,//문자 인증 유무 판별 
                    ranstr: "",
                    checkFlg:false,


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
                        id: self.id
                    };
                    $.ajax({
                        url: "/member/check.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            alert(data.msg);
                            self.checkFlg=true;

                        }
                    });
                },
                fnSms: function () {
                    let self = this;
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
                            if (data.res.statusCode == "2000") {
                                alert("문자 전송 완료");
                                self.ranstr = data.ranstr;
                                self.smsFlg = true;
                                self.fnTimer();

                            } else {
                                alert("잠시 후 다시 시도 해주세요.");
                            }


                        }
                    });

                },

                fnAddr: function () {
                    window.open("/addr.do", "addr", "width=500,height=500")
                },

                fnValidatePassword() {
                    const pwd = this.pwd;
                    this.lenEnough = pwd.length >= 8;
                    this.hasNumber = /[0-9]/.test(pwd);
                    this.hasAlphabet = /[A-Za-z]/.test(pwd);
                    this.hasSpecial = /[^A-Za-z0-9]/.test(pwd);
                    this.withoutInvalidChar = /^[A-Za-z0-9!@#$%^&*]+$/.test(pwd);
                },

                fnResult: function (roadFullAddr, roadAddrPart1, addrDetail) {
                    let self = this;
                    self.addr = roadFullAddr;

                },

                fnTimer: function () {
                    let self = this;
                    let int = setInterval(() => {
                        if (self.count == 0) {
                            clearInterval(int);
                            alert("시간이 만료되었습니다");
                        } else {

                            let min = parseInt(self.count / 60);
                            let sec = self.count % 60;
                            min = min < 10 ? "0" + min : min;
                            sec = sec < 10 ? "0" + sec : sec;
                            self.timer = min + ":" + sec;

                            self.count--;
                        }
                    }, 1000);
                },

                fnJoin: function () {
                    let self = this;
                    //문자인증이 완료되지 않으면
                    //회원가입이 불가능하도록
                    if(!self.checkFlg){
                        alert("중복체크를 먼저 하십시오");
                        return;
                    }
                    if (self.id.length < 5) {
                        alert("아이디는 5글자 이상이어야 합니다.");
                        return;
                    }
                    if(self.id==null||self.id==""){
                        alert("아이디를 입력해 주세요.");
                        return;
                    }
                    if (self.pwd.length < 6) {
                        alert("비밀번호는 6글자 이상이어야 합니다.");
                        return;
                    }
                    if (self.pwd!=self.pwd2){//记得self总是落下
                        alert("비밀번호가 일치하지 않습니다.");
                        return;
                    }
                    if (self.name == null || self.name == "") {
                        alert("이름은 빈값이 아니어야 합니다.");
                        return;
                    }
                    if (self.addr == null || self.addr == "") {
                        alert("주소는 빈값이 아니어야 합니다.");
                        return;
                    }
                    // let phone=self.phone1+"-"+self.phone2+"-"+self.phone3;
                    // if(self.phone.length<13||self.phone==""||self.phone==null){
                    //     alert("정확한 잔화번호 형식이 아닙니다.");
                    //     return;
                    // }
                    if(self.phone1==""||self.phone3==""||self.phone3==""){
                        alert("핸드폰번호를 입력해주세요.");
                    }
                    if(self.gender==null){
                        alert("성별을 입력해 주세요.");
                        return;
                    }

                    // if (!self.joinFlg) {
                    //     alert("문자 인증을 진행해주세요");
                    //     return;
                    // }
                    

                    let param={
                        id: self.id,
                        pwd: self.pwd,
                        name: self.name,
                        addr: self.addr,
                        phone:self.phone1+"-"+self.phone2+"-"+self.phone3,
                        gender: self.gender,
                        status: self.status
                    }
                    $.ajax({
                        url: "/member/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if(data.result=="success"){
                                alert("가입되었습니다.");
                                location.href="/member/login.do"

                            }else{
                                alert("가입이 실패되었습니다.");

                            }

                        }
                    });
                    

                },

                fnSmsAuth: function () {
                    let self = this;
                    if (self.ranstr == self.inputNum) {
                        alert("문자 인증이 성공되었습니다.");
                        self.joinFlg = true;
                    } else {
                        alert("문자 인증이 실패되었습니다.");
                    }
                },

                fnNext: function (current, nextId) {
                    if (current.value.length >= current.maxLength) {
                        document.getElementById(nextId).focus();
                    }
                }




            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                window.vueObj = this;
            }
        });

        app.mount('#app');
    </script>