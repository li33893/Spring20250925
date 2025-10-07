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

        .active {
            color : black;
            font-weight: bold;
        }
        

        a{
            padding-right:5px;
            text-decoration: none;
        }

        
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            <select v-model="si" @change="fnGuList">
                <option v-for="si in siList">{{si.si}}</option>
            </select>
            <select v-model="gu" @change="fnDongList">
                <option v-for="gu in guList">{{gu.gu}}</option>
            </select>
            <select v-model="dong">
                <option v-for="dong in dongList">{{dong.dong}}</option>
            </select>
            <button @click="fnAreaList">search</button>
        </div>

        <div>
            <table>
                <tr>
                    <th>도,특별시시</th>
                    <th>구</th>
                    <th>동</th>
                </tr>
                <tr v-for="area in areaList">
                    <td>{{area.si}}</td>
                    <td>{{area.gu}}</td>
                    <td>{{area.dong}}</td>
                </tr>
            </table>
        </div>
        <div><button @click="fnPre(num)">◀</button><a href="javascript:;" v-for="num in pageRangeList" @click="fnChange(num)" :class="{active:page == num}">{{num}}</a><button @click="fnNext(num)">▶</button></div>
		
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                areaList:[],
				keyWord:"",
                siList:[],
                guList:[],
                dongList:[],
                pageSize:20,
                page:1,
                pageNum:0,
                totalRows:0,
                pageRange:10,
                pageRangeList:[],
                si:"",
                gu:"",
                dong:""
				
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAreaList: function () {
                let self = this;
                let param = {
                    offset:(self.page-1)*self.pageSize,
                    fetchRows:self.pageSize,
                    si:self.si,
                    gu:self.gu,
                    dong:self.dong
	
				};
                $.ajax({
                    url: "/area-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						console.log(data);
                        self.areaList=data.list;
                        self.totalRows=data.rowNum;
                        self.pageNum=Math.ceil(self.totalRows/self.pageSize);
                        self.fnpageRange();
                        						
                    }
                });
            },

            fnSiList:function(){
                let self = this;
                let param = {
				};
                $.ajax({
                    url: "/si-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						console.log(data);
                        self.siList=data.list;
						
                    }
                });

            },

            fnGuList:function(){
                let self = this;
                //每次si改变的时候都要将后面的清空，否则会产生空值
                self.gu="";
                self.dong="";
                let param = {
                    si:self.si
				};
                $.ajax({
                    url: "/gu-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						console.log(data);
                        self.guList=data.list;
                        self.fnAreaList();
						
                    }
                });

            },

            fnDongList:function(){
                let self = this;
                //每次si不变gu变的时候要让dong清空，否则会产生空值
                self.dong="";
                let param = {
                    si:self.si,
                    gu:self.gu
				};
                $.ajax({
                    url: "/dong-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						console.log(data);
                        self.dongList=data.list;
                        self.fnAreaList();
						
                    }
                });

            },

            fnChange:function(num){
                let self=this;
                self.page=num;
                self.fnAreaList();
            },

            fnPre:function(){
                let self=this;
                if(self.page>1){
                    self.page--;
                }
                self.fnAreaList();
            },

            fnNext:function(){
                let self=this;
                if(self.page<self.pageNum){
                    self.page++;
                }
                self.fnAreaList();
                
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
            }

            
            // methods
        },
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnAreaList();
            self.fnSiList();
        }
    });

    app.mount('#app');

</script>
