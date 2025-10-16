
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
         <div>
            <table>
                <tr>
                    <th>선택<input type="checkbox" @click="fnSelectAll"></th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th>조회수</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>마지막 수정일</th>
                </tr>
                <tr v-for="bbs in bbsList">
                    <td><input type="checkbox" :value="bbs.bbsNum" v-model="selectItem" ></td>
                    <td>{{bbs.bbsNum}}</td>
                    <td><a href="javascript:;" @click="fnView(bbs.bbsNum)">{{bbs.title}}</a></td>
                    <td>{{bbs.contents}}</td>
                    <td style="color:red" v-if="bbs.hit>25">{{bbs.hit}}</td>
                    <td style="color:black" v-else>{{bbs.hit}}</td>
                    <td>{{bbs.userId}}</td>
                    <td>{{bbs.cdate}}</td>
                    <td>{{bbs.udate}}</td>
                </tr>
            </table>
         </div>

         <div>
            <button @click="fnInsert">
                글쓰기
            </button>
         </div>
         <div>
            <button @click="fnRemoveAll">
                선택 삭제
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
                bbsList:[],
                sessionId: "${sessionId}",
                selectItem:[],
                flgAllChecked:false
               
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/bbs/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.bbsList=data.bbsList;
                    }
                });
            },
            fnInsert:function(){
                let self=this;
                if(!self.sessionId){
                    alert("로그인 후 사용해 주세요");
                    location.href="/member/login.do";
                    return;
                }
                location.href="/bbs/insert.do";
            },

            fnSelectAll:function(){
                let self=this;
                self.flgAllChecked=!self.flgAllChecked;
                if(self.flgAllChecked){
                    self.selectItem=[];
                    for(i=0;i<self.bbsList.length;i++){
                        self.selectItem.push(self.bbsList[i].bbsNum);
                    }
                }else{
                    self.selectItem=[];
                }
                  

            },

            fnRemoveAll:function(){
                let self = this;

                let fList = JSON.stringify(self.selectItem);//把selectItem变成json形式
                let param = {selectItem : fList};

                $.ajax({
                    url: "/bbs/deleteall.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						alert("삭제되었습니다");
                        self.fnList();
						
                    }
                });
            },

            fnView:function(bbsNum){
                
                pageChange("/bbs/view.do",{bbsNum:bbsNum});

            },
            
        }, // methods

       
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>



