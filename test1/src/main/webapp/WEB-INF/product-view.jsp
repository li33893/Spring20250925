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
                    <th>
                        카테고리

                    </th>
                    <td>
                        {{Info.foodUpperName}}
                    </td>
                </tr>
                <tr>
                    <th>
                        제품번호
                    </th>
                    <td>
                        {{Info.foodNo}}
                    </td>
                </tr>
                <tr>
                    <th>
                        음식명
                    </th>
                    <td>
                        {{Info.foodName}}
                    </td>
                </tr>
                <tr>
                    <th>
                        음식 설명
                    </th>
                    <td>
                        {{Info.foodInfo}}
                    </td>
                </tr>
                <tr>
                    <th>
                        가격
                    </th>
                    <td>
                        {{Info.price}}
                    </td>
                </tr>

                <tr>
                    <th>
                        개수
                    </th>
                    <td>
                        <input v-model="num">
                    </td>
                </tr>
                <tr>
                    <th>
                        이미지
                    </th>
                    <td>
                        <img v-for="item in fileList" :src="item.filePath">
                    </td>
                </tr>
            </table>

            <div>
                <button @click="fnPayment">주문하기</button>
            </div>
        </div> 


        
    </div>
</body>
</html>

<script>
    IMP.init("imp12485203");
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                foodNo:"${foodNo}",
                sessionId:"${sessionId}",
                Info:{},
                fileList:[],
                num:0,
                paymentList:[]
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {
                    foodNo:self.foodNo
                };
                $.ajax({
                    url: "/product/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.Info=data.Info;
                        self.fileList=data.fileList;

                    }
                });
            },

            fnPayment:function(){
                let self=this;
                IMP.request_pay({
				    pg: "html5_inicis",
				    pay_method: "card",
				    merchant_uid: "merchant_"+new Date().getTime(),
				    name: self.Info.foodName,
				    amount: 1,//这里指的是价格
				    buyer_tel: "010-0000-0000",
                    
				  }	, function (rsp) { // callback
			   	      if (rsp.success) {

			   	        // 결제 성공 시
						console.log(rsp);
                        self.fnPayHistory(rsp.merchant_uid,rsp.amount);
			   	      } 
		   	  	});
                
            },

            fnPayHistory:function(uid,amount){
                let self=this;
                let param={
                    foodNo:self.foodNo,
                    uid:uid,
                    amount:amount,
                    sessionId:self.sessionId
                }
                $.ajax({
                    url: "/history/insert.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result=="success"){
                            alert("결제가 성공되었습니다.");
                        }else{
                            alert("결제가 실패되었습니다.")
                        }

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