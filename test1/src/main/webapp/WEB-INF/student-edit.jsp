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
            <p>stuNo = ${stuNo}</p>
            <table>
                <tr>
                    <th>이름</th>
                    <th>학과</th>
                    <th>전체평균</th>
                </tr>
                <tr>
                    <td><input type="text" v-model="student.stuName"></td>
                    <td><input type="text" v-model="student.stuDept"></td>
                    <td>{{student.avgScore}}</td>
                </tr>
            </table>
			<button @click="fnEdit()">제출</button>
         </div>

        
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                stuNo:"${stuNo}",
				
                student:{
					stuNo:"${stuNo}",
					stuName:"",
					stuDept:"",
					
				}
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
			fnInfo: function () {
			                let self = this;
			                let param = {
			                    stuNo:self.stuNo
			                };
			                $.ajax({
			                    url: "/student-view.dox",
			                    dataType: "json",
			                    type: "POST",
			                    data: param,
			                    success: function (data) {
			                        console.log(data);
			                        self.student=data.info;

			                    }
			                });
			            },
            fnEdit: function () {
                let self = this;
                $.ajax({
                    url: "/student-edit.dox",
                    dataType: "json",
                    type: "POST",
                    data: self.student,
                    success: function (data) {
                        console.log(data);
						alert("저장 완료!");
                        self.student=data.stu;

                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>