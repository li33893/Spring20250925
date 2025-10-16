
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
        .active{
            color:black;
            font-weight:bold;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <select v-model="pageSize" @change="fnList">
                <option value="1">1</option>
                <option value="5">5</option>
                <option value="10">10</option>
            </select>
            <select v-model="option">
                <option value="all">::전체::</option>
                <option value="title">제목</option>
                <option value="contents">내용</option>
            </select>
            <input type="text" v-model="keyWord">
            <button @click="fnList">검색</button>
         </div>

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

         <div><button @click="fnPre()">◀</button><a href="javascript:;" v-for="num in pageRangeList" @click="fnChange(num)" :class="{active:page == num}">{{num}}</a><button @click="fnNext()">▶</button></div>

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
                flgAllChecked:false,
                keyWord:"",
                option:"all",

                pageRangeList:[],

                pageSize:5,
                page:1,
                pageRange:6,
                pageNum:0
                

               
            };
        },
        methods: {
            // 함수(메소드) - (key : function())

            
            fnList: function () {
                let self = this;
                let param = {
                    option:self.option,
                    keyWord:self.keyWord,
                    offset:(self.page-1)*self.pageSize,
                    fetchRows:self.pageSize,
                    

                };
                $.ajax({
                    url: "/bbs/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.bbsList=data.bbsList;
                        self.totalRows=data.totalRows;
                        self.pageNum=Math.ceil(self.totalRows/self.pageSize);
                        self.fnpageRange();
                    }
                });
            },

            fnInsert:function(){
                let self=this;
                // if(!self.sessionId){
                //     alert("로그인 후 사용해 주세요");
                //     // location.href="/member/login.do";
                //     return;
                // }
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

            

            fnpageRange:function(){
                let self=this;
                self.pageRangeList = [];  
                //***0-9floor出来的才是一个数，想要1-10在一个区间就在0-9floor出来的基础上+1即可   
                // 计算起始页
                let startPage = Math.floor((self.page - 1) / self.pageRange) * self.pageRange + 1;
                // 计算结束页
                let endPage = Math.min(startPage + self.pageRange - 1, self.pageNum);//min(num1,num2)的意思是在两个数里面取更小的
   
                for(let i = startPage; i <= endPage; i++){
                self.pageRangeList.push(i);
                }
            },

            fnChange:function(num){
                let self=this;
                self.page=num;
                self.fnList();
            },

            fnPre:function(){
                let self=this;
                if(self.page>1){
                    self.page--;
                }
                self.fnList();
            },

            fnNext:function(){
                let self=this;
                if(self.page<self.pageNum){
                    self.page++;
                }
                self.fnList();
                
            },


            


        }, // methods

       
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
            self.page
        }
    });

    app.mount('#app');
</script>


