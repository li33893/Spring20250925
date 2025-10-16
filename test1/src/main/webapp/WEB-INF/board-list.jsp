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
            <select v-model="searchOption">
                <option value="all">::전체::</option>
                <option value="title">::제목::</option>
                <option value="userId">::작성자::</option>
            </select>
            검색어:
            <input v-model="keyWord">
            <button @click="fnlist()">검색</button>
         </div>

         <select v-model="pageSize" @change="fnlist">
            <option value="5">5개씩</option>
            <option value="10">10개식</option>
            <option value="15">15개씩</option>
         </select>
		
        <div>
            <select v-model="kind" @change="fnlist">
                <option value="">전체</option>
                <option value="1">공지사항</option>
                <option value="2">자유게시판</option>
                <option value="3">문의게시판</option>
            </select>
            <select v-model="option" @change="fnlist">
                <option value="time">시간순</option>
                <option value="boardNo">번호순</option>
                <option value="title">제목순</option>
                <option value="cnt">조회순</option>
            </select>
        </div>
        <div>
            <table>
                <tr>
                    <th v-if="status=='A'"><input type="checkbox" @click="fnSelectAll"></th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>삭제</th>
                    <th>수정</th>
                </tr>
                <tr v-for="item in list">
                    <td v-if="status=='A'"><input type="checkbox" :value="item.boardNo" v-model="selectItem" ></td>
                    <td>{{item.boardNo}}</td>
                    <td>
                        <!--有很多是后v-if更方便一些，其实也不用v-if，只要在某种条件下显示非转换的情况就用v-if就行-->
                        <a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a>
                        <span style="color:red" v-if="item.commentCnt!=0">[{{item.commentCnt}}]</span>
                    </td>
                    <td>{{item.userId}}</td>
                    <td>{{item.cnt}}</td>
                    <td>{{item.cdate}}</td>
                    <td>
                        <button @click="fnRemove(item.boardNo)" id="Del" v-if="sessionId==item.userId||status=='A'">삭제</button>
                    </td>
                    <td><button @click="fnEdit(item.boardNo)">수정</button></td>
                </tr>
            </table>
            <div>
                <!--在 Vue 3（和 Vue 2）里，v-for 不仅可以迭代数组，也可以迭代一个数字，并且从1开始-->
                
                <a href="javascript:;" @click="fnMove(-1)" v-if="page!=1" >👈</a>
                    <a href="javascript:;" v-for="num in index" @click="page=num;fnlist()" > 
                    <span :class="{active:page==num}">{{num}}</span>
                </a>
                <a href="javascript:;" @click="fnMove(+1)" v-if="page!=index" >👉</a>
                
            </div>
            <div><button @click="fnAdd()">글쓰기</button></div>
            <div v-if="status=='A'"><button @click="fnRemoveAll">선택 삭제</button></div>
        </div>
		
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
				userId:"",
                boardNo:"",
                title:"",
                cnt:0,
                list:[],
                kind:"",
                option:"time",
                content:"",
                sessionId:"${sessionId}",
                status:"${sessionStatus}",
                searchOption:"all",
                keyWord:"",
                pageSize:"5",//한페이지에 출력할 개수
                page:1,//现在所在页面
                index:0,//최대 페이지 값
                selectItem:[],
                flgAllChecked:false
				
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnlist: function () {
                let self = this;
                let param = {
                    boarNo:self.boardNo,
                    kind:self.kind,
                    option:self.option,
                    keyWord:self.keyWord,
                    searchOption:self.searchOption,
                    offset:(self.page-1)*self.pageSize,
                    pageSize:self.pageSize,
                    
				};
                console.log(self.status);
                $.ajax({
                    url: "board-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						console.log(data);
                        self.list=data.list;
                        self.index=Math.ceil(data.cnt/self.pageSize);
						
                    }
                });
            },

            fnRemove:function(boardNo){
                let self = this;

                let param = {
                    boardNo:boardNo//这里只是变量，并不是声明的东西不能带self	
				};
                $.ajax({
                    url: "board-delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						alert("삭제되었습니다");
                        self.fnlist();
						
                    }
                });
            },

            fnRemoveAll:function(){

                let fList = JSON.stringify(self.selectItem);//把selectItem变成json形式
                let param = {selectItem : fList};

                $.ajax({
                    url: "board/delete-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						alert("삭제되었습니다");
                        self.fnlist();
						
                    }
                });
            },


            fnAdd:function(){
                let self=this;
                if(!self.sessionId){
                    alert("로그인 후 사용해 주세요");
                    location.href="/member/login.do";
                    return;
                }
                location.href="board-add.do";
            },

            fnView:function(boardNo){
                pageChange("board-view.do",{boardNo:boardNo});

            },
            
            fnMove:function(num){
                let self=this;
                self.page+=num;
                self.fnlist();
            },

            fnSelectAll:function(){
                let self=this;
                self.flgAllChecked=!self.flgAllChecked;
                if(self.flgAllChecked){
                    self.selectItem=[];
                    for(i=0;i<self.list.length;i++){
                        self.selectItem.push(self.list[i].boardNo);
                    }
                }else{
                    self.selectItem=[];
                }
                  

            }

        

            

    

            

            
            

          
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnlist();
        }
    });

    app.mount('#app');
</script>