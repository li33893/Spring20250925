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
                    <td>{{prof.name}}</td>
                    <td>{{prof.id}}</td>
                    <td>{{prof.address}}</td>
                    <td>{{prof.dName}}</td>
                </tr>
            </table>
         </div>

         <div>
            <!--！！！！！！！！！要传到下一页，所有需要pagechange！！！！！！！！-->
            <button @click="fnEdit()">
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
                prof:{},
                // sessionId:"${sessionId}",
                // userId:"${sessionId}" ,
                // fileList:[],
                // hit:0    
                
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
                        console.log(data);
                        self.prof=data.prof;
                        
                    }
                });
            },
            

              fnView:function(profNo, deptNo){
        		pageChange("/prof/edit.do", {
            		profNo: profNo,
           			deptNo: deptNo
        		});
    		},

            

            

        
           
            

        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            // self.fnHitPlus();
            self.fnProf();
            
        }
    });

    app.mount('#app');
</script>
