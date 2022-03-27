<template>
    <el-carousel height="100vh">
        <el-carousel-item arrow="always" interval="1000" autoplay="true"
                v-for="(mybutton,i) in mybuttons" :key="i">
            <h1 class="is-big"><br/><br/>{{mybutton.b_title}}</h1>

            <el-button v-bind:type="mybutton.b_type" >
                <a v-bind:href="mybutton.b_href" >{{mybutton.b_text}}&nbsp;&nbsp;</a>
                <el-icon v-show="mybutton.b_icon1"><map-location /></el-icon>
                <el-icon v-show="mybutton.b_icon2"><data-analysis /></el-icon>
                <el-icon v-show="mybutton.b_icon3"><avatar /></el-icon>
            </el-button>

        </el-carousel-item>
    </el-carousel>
</template>

<script>
    import { DataAnalysis, MapLocation, Avatar, Search } from '@element-plus/icons-vue';
    export default {
        name: "MyHome",
        components: {DataAnalysis, MapLocation, Avatar, Search},
        data() {
            return {
                mybuttons: [
                    {   b_title:"城市物流配送路径规划系统",
                        b_href:"http://localhost:3000/#/MapPlace",
                        b_text:"进入地图",
                        b_type:"success",
                        b_icon1: true,
                        b_icon2: false,
                        b_icon3: false,
                    },
                    {   b_title:"新能源，新时代",
                        b_href:"http://localhost:3000/#/Vehicle",
                        b_text:"车辆管理",
                        b_type:"warning",
                        b_icon1: false,
                        b_icon2: true,
                        b_icon3: false,
                    },
                    {   b_title:"智慧物流世界",
                        b_href:"http://localhost:3000/#/Place",
                        b_text:"节点管理",
                        b_type:"danger",
                        b_icon1: false,
                        b_icon2: false,
                        b_icon3: true,
                    },
                ]
            }
        }
    }
</script>

<style scoped>
    a {
        text-decoration: none;
        color: #fff7fb;
    }

    .el-carousel__item h1 {
        color: #ffffff;
        font-size: 54px;
        opacity: 0.95;
        line-height: 150px;
        margin: 0;
        text-align: center;
    }

    .el-carousel__item:nth-child(3n) {
        /*background-color: #99a9bf;*/
        background-image: url("../assets/home/tech.jpeg");
        background-repeat:no-repeat;
        background-size: 100% 100%;
    }

    .el-carousel__item:nth-child(3n + 1) {
        /*background-color: #e61c1b;*/
        background-image: url("../assets/home/t5d_01.jpg");
        background-repeat:no-repeat;
        background-size: 100% 100%;
    }

    .el-carousel__item:nth-child(3n + 2) {
        /*background-color: #1ae646;*/
        background-image: url("../assets/home/wl01.jpg");
        background-repeat:no-repeat;
        background-size: 100% 100%;
    }
</style>