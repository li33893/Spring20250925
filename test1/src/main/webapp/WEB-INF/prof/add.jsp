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
                <label>교수번호: <input type="text" v-model="profNo" v-if="!checkFlg">
                <input type="text" v-model="profNo" v-else disabled></label>
                <button @click="fnRepCheck(id)">중복체크</button>
            </div>
        
            <div>
                이름: <input v-model="name">
            </div>

            <div>
                주소: <input v-model="addr"><button @click="fnAddr">주소검색</button>
            </div>

            <div>
                아이디: <input v-model="id">
            </div>

            <div>
                직업: <input v-model="position">
            </div>

            <div>
                급여: <input v-model="pay">
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
                    name: "",
                    addr: "",
                    pay:0,
                    position:"",
                    profNo:"",
                    checkFlg:false,

                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnRepCheck: function (profNo) {
                    let self = this;
                    let param = {
                        profNo: self.profNo
                    };
                    $.ajax({
                        url: "/prof/check.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            alert(data.msg);
                            self.checkFlg=true;

                        }
                    });
                },

                fnAddr: function () {
                    window.open("/addr.do", "addr", "width=500,height=500")
                },

                // fnValidatePassword() {
                //     const pwd = this.pwd;
                //     this.lenEnough = pwd.length >= 8;
                //     this.hasNumber = /[0-9]/.test(pwd);
                //     this.hasAlphabet = /[A-Za-z]/.test(pwd);
                //     this.hasSpecial = /[^A-Za-z0-9]/.test(pwd);
                //     this.withoutInvalidChar = /^[A-Za-z0-9!@#$%^&*]+$/.test(pwd);
                // },

                fnResult: function (roadFullAddr, roadAddrPart1, addrDetail) {
                    let self = this;
                    self.addr = roadFullAddr;

                },


                fnJoin: function () {
                    let self = this;
                    //문자인증이 완료되지 않으면
                    //회원가입이 불가능하도록
                    if(!self.checkFlg){
                        alert("중복체크를 먼저 하십시오");
                        return;
                    }
                    if (self.id==null||self.id=="") {
                        alert("아이디는 빈값이 아니어야 합니다.");
                        return;
                    }
                    if (self.name == null || self.name == "") {
                        alert("이름은 빈값이 아니어야 합니다.");
                        return;
                    }
                    // if (self.addr == null || self.addr == "") {
                    //     alert("주소는 빈값이 아니어야 합니다.");
                    //     return;
                    // }
                    if (self.position == null || self.position == "") {
                        alert("직업는 빈값이 아니어야 합니다.");
                        return;
                    }
                    if (self.pay == null || self.pay == "") {
                        alert("급여는 빈값이 아니어야 합니다.");
                        return;
                    }
                    if (self.profNo == null || self.profNo == "") {
                        alert("교수번호는 빈값이 아니어야 합니다.");
                        return;
                    }
                    // let phone=self.phone1+"-"+self.phone2+"-"+self.phone3;
                    // if(self.phone.length<13||self.phone==""||self.phone==null){
                    //     alert("정확한 잔화번호 형식이 아닙니다.");
                    //     return;
                    // 

                    // if (!self.joinFlg) {
                    //     alert("문자 인증을 진행해주세요");
                    //     return;
                    // }
                    

                    let param={
                        id: self.id,
                        profNo: self.profNo,
                        name: self.name,
                        addr: self.addr,
                        pay:self.pay,
                        position:self.position
                        
                    }
                    $.ajax({
                        url: "/prof/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if(data.result=="success"){
                                alert("가입되었습니다.");

                            }else{
                                alert("가입이 실패되었습니다.");

                            }

                        }
                    });
                    

                },

                // fnSmsAuth: function () {
                //     let self = this;
                //     if (self.ranstr == self.inputNum) {
                //         alert("문자 인증이 성공되었습니다.");
                //         self.joinFlg = true;
                //     } else {
                //         alert("문자 인증이 실패되었습니다.");
                //     }
                // },

                // fnNext: function (current, nextId) {
                //     if (current.value.length >= current.maxLength) {
                //         document.getElementById(nextId).focus();
                //     }
                // }




            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                window.vueObj = this;
            }
        });

        app.mount('#app');
    </script>