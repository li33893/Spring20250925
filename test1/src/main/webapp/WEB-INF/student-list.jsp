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
			<input placeholder="stuname" v-model="keyWord">
			<button @click="fnInfo">검색</button>
		</div>

        <div>
            <table>
                <tr>
                    <th><input type="checkbox" @click="fnSelectAll()"></th>
                    <th>학번</th>
                    <th>이름</th>
                    <th>학과</th>
                    <th>학년</th>
                    <th>성별</th>
                    <th>삭제</th>
                    <th>수정</th>
                </tr>
                <tr v-for="item in list">
                    <td>
                        <input type="checkbox" :value="item.stuNo" v-model="selectItem">
                    </td>
                    <td>{{item.stuNo}}</td>
                    <td><a href="javascript:;" @click="fnView(item.stuNo)">{{item.stuName}}</a></td>
                    <td>{{item.stuDept}}</td>
                    <td>{{item.stuGrade}}</td>
                    <td>{{item.stuGender}}</td>
                    <td><button @click="fnRemove(item.stuNo)">삭제</button></td>
                    <td><button @click="fnEdit(item.stuNo)">수정</button></td>
                </tr>
            </table>
        </div>

        <div><button @click="fnAllRemove">삭제</button></div>
		
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list:[],
                selectItem:[],
                flgAllCheck:false,
                keyWord:""
				
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnlist: function () {
                let self = this;
                let param = {
	
				};
                $.ajax({
                    url: "stu-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						console.log(data);
                        self.list=data.list;
						
                    }
                });
            },
            fnInfo: function () {
                let self = this;
                let param = {
					keyWord:self.keyWord,
	
				};
                $.ajax({
                    url: "stu-info.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						console.log(data);
						
                    }
                });
            },
            fnRemove: function (stuNo) {
                let self = this;
                let param = {
                    stuNo:stuNo   
				};
                $.ajax({
                    url: "stu-delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.fnlist();					
                    }
                });
            },

            fnAllRemove:function(){
                let self=this;
                
                let fList = JSON.stringify(self.selectItem);//把selectItem变成json形式
                let param = {selectItem : fList};

                $.ajax({
                    url: "/stu/deleteList.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제되었습니다");
                        self.fnlist();					
                    }
                });
            },

           
            //全部选中/全部选中取消
            fnSelectAll:function(){
                let self=this;
                //点击的瞬间变成true，然后依次交替
                self.flgAllCheck=!self.flgAllCheck;
                if(!self.flgAllCheck){
                    self.selectItem=[];
                }else{
                    //防止已经选中的时候list里面又重复加入原来已经有的选项
                    self.selectItem=[];
                    for(i=0;i<self.list.length;i++){
                    self.selectItem.push(self.list[i].stuNo);
                    }
                }
                

            },

            
            fnView:function(stuNo){
                pageChange("stu-view.do",{stuNo:stuNo});

            },

            fnEdit:function(stuNo){
                pageChange("stu-edit.do",{stuNo:stuNo});

            },

        

        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnlist();
        }
    });

    app.mount('#app');
</script>