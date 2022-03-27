<template>

    <el-menu id="menuRt"
             :default-active="activeIndex2"
             class="el-menu-demo"
             mode="horizontal"
             background-color="#00244f"
             text-color="#fff"
             active-text-color="#ffd04b"
             @select="handleSelect"
             ellipsis="false"
    >
        <el-sub-menu index="1">
            <template #title>
                <el-icon><Link /></el-icon>友情链接
            </template>
            <el-menu-item index="1-1">
                <a href="http://www.360che.com/" target="_blank" style="width: 100%;text-align: left">卡车之家</a>
            </el-menu-item>
            <el-menu-item index="1-2">
                <a href="http://www.cn156.com/" target="_blank" style="width: 100%;text-align: left">第一物流网</a>
            </el-menu-item>
            <el-menu-item index="1-3">
                <a href="https://lbsyun.baidu.com/" target="_blank" style="width: 100%;text-align: left">百度地图开放平台</a>
            </el-menu-item>
            <el-menu-item index="1-4">
                <a href="https://v3.cn.vuejs.org/" target="_blank" style="width: 100%;text-align: left">Vue3</a>
            </el-menu-item>
            <el-menu-item index="1-5">
                <a href="https://element-plus.gitee.io/zh-CN/" target="_blank" style="width: 100%;text-align: left">Element Plus</a>
            </el-menu-item>
            <el-menu-item index="1-6">
                <a href="https://spring.io/projects/spring-boot" target="_blank" style="width: 100%;text-align: left">Spring Boot</a>
            </el-menu-item>
        </el-sub-menu>
        <el-sub-menu index="2">
            <template #title>
                {{weather.state.wdata.city}}
                <img v-bind:src="['src/assets/weathericon/'+weather.state.wdata.wea_img+'.png']"
                     style="height: 30px; width: 30px"/>
                {{weather.state.wdata.tem}}℃&nbsp;&nbsp;{{weather.state.wdata.wea}}
            </template>

            <el-menu-item index="2-1">
                今日气温：&nbsp;{{weather.state.wdata.tem_night}}℃
                ~&nbsp;&nbsp;{{weather.state.wdata.tem_day}}℃
            </el-menu-item>
            <el-menu-item index="2-2">
                风向风力：&nbsp;{{weather.state.wdata.win}}
                &nbsp;
                <!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
                {{weather.state.wdata.win_speed}}
                ({{weather.state.wdata.win_meter}})
            </el-menu-item>
            <el-menu-item index="2-3">空气质量：&nbsp;{{weather.state.wdata.air}}</el-menu-item>
            <el-menu-item index="2-4">更新时间：&nbsp;{{weather.state.wdata.update_time}}</el-menu-item>

        </el-sub-menu>

    </el-menu>
</template>

<script lang="ts">

    // import {ref} from 'vue'
    import axios from "axios";
    import weather from "../data/weather.js";
    import {Link} from '@element-plus/icons-vue';


    // const activeIndex2 = ref('1');

    export default {
        name: "MyMenuRight",
        components: {Link},
        provide: {
            weather
        },
        setup() {
            var myCity = new BMapGL.LocalCity();
            myCity.get(getCityByIP);
            function getCityByIP(rs) {
                var cityName = rs.name;
                weather.setCity(cityName.substring(0, cityName.length - 1));
                console.log(weather.state.city);
                // alert("根据IP定位您所在的城市为:" + cityName);
            }

            let reqUrl = "https://www.tianqiapi.com/free/day?appid=ABCDEFG&appsecret=ABCDEFG&city="
                + weather.state.city;
            axios.get(reqUrl).then((result) => {
                weather.setWeather(result.data);
            });
            return {
                weather
            };
        },
    }
</script>

<style scoped>
    #menuRt {
        float: right;
        width: 25vw;
        border: 0;
    }
</style>