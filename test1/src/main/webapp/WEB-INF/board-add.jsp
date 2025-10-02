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
                        <th>파일첨부</th>
                        <th>내용</th>
                    </tr>
                    <tr>
                        <td><input type="text" v-model="title"></td>
                        <td><input type="text" v-model="userId" readonly></td>
                        <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td>
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
                    userId: "${sessionId}",
                    boardNo: "",
                    title: "",
                    cnt: 0,
                    list: [],
                    kind: "",
                    option: "boardNo",
                    content: "",
                    sessionid: "${sessionId}"
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnInsert: function () {
                    let self = this;
                    let param = {
                        userId: self.userId,
                        content: self.content,
                        title: self.title
                    };
                    $.ajax({
                        url: "board-add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            alert("삽입되었습니다.");
                            console.log(data.boardNo);
                            var form = new FormData();
                            form.append("file1", $("#file1")[0].files[0]);
                            form.append("boardNo", data.boardNo); // 임시 pk
                            self.upload(form);
                            // location.href="board-list.do";
                        }
                    });
                },
                upload: function (form) {
                    var self = this;
                    $.ajax({
                        url: "/fileUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (data) {
                            console.log(data);

                        }
                    });
                }







            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                if (self.sessionId == "") {
                    alert("you must log in first");
                    location.href = "/member/login.do";
                }

            }
        });

        app.mount('#app');
    </script>