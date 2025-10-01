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
            도/특별시
            <select v-model="si" @change="fnList">
                <option value="">전체</option>
                <option :value="item.si" v-for="item in siList">{{item.si}}</option>
            </select>
        </div>

        <div>
            <table>
                <tr>
                    <th>시</th>
                    <th>구</th>
                    <th>동</th>
                    <th>x</th>
                    <th>y</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.si}}</td>
                    <td>{{item.gu}}</td>
                    <td>{{item.dong}}</td>
                    <td>{{item.nx}}</td>
                    <td>{{item.ny}}</td>
                </tr>
            </table>
        </div>

         <div>
                <!--在 Vue 3（和 Vue 2）里，v-for 不仅可以迭代数组，也可以迭代一个数字，并且从1开始-->
                
                <a href="javascript:;" @click="fnMove(-1)" v-if="page!=1" >👈</a>
                    <a href="javascript:;" @click="page=num;fnlist()" v-for="num in index"> 
                    <span :class="{active:page==num}">{{num}}</span>
                </a>
                <a href="javascript:;" @click="fnMove(+1)" v-if="page!=index" >👉</a>
                
            </div>
                
    </div>

</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                pageSize:"20",//한페이지에 출력할 개수
                page:1,//现在所在页面
                index:0,//최대 페이지 값
                list:[],
                pageLowerRange:0,
                pageRangeList:[],
                pageRange:10,
                siList:[],
                si:""//선택한 시 값

            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    offset:(self.page-1)*self.pageSize,
                    pageSize:self.pageSize,
                    si:self.si
                    
                };
                $.ajax({
                    url: "/area/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.list=data.list;
                        self.index=Math.ceil(data.cnt/self.pageSize);
                    }
                });
            },

            fnSiList: function () {
                let self = this;
                let param = {
                    
                    
                };
                $.ajax({
                    url: "/area/si.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.siList=data.list;
                    }
                });
            },
            //现在的页数/10~现在的页数/10+10
            //page/10
            fnPageRange:function(){
                let self=this;
                self.pageRangeList=[];

                self.pageLowerRange=floor(self.page/10);
                for(i=1;i<=self.pageRange;i++){
                    self.pageRangeList[i]=self.pageLowerRange+i;
                }
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
            self.fnSiList();
        }
    });

    app.mount('#app');
</script>