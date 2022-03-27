<template>

    <el-menu id="menuLt"
             :default-active="activeIndex2"
             class="el-menu-demo"
             mode="horizontal"
             background-color="#00244f"
             text-color="#fff"
             active-text-color="#ffd04b"
             @select="handleSelect"
             style="overflow: hidden; width: 75vw"
    >
        <el-menu-item index="1">
            <a href="http://localhost:3000/#/" style="width: 100%;text-align: left">
                <el-icon><HomeFilled/></el-icon>首页
            </a>
        </el-menu-item>
        <el-menu-item index="2">
            <a href="http://localhost:3000/#/MyIntroduce" style="width: 100%;text-align: left">
                <el-icon><InfoFilled/></el-icon>系统简介
            </a>
        </el-menu-item>
        <el-sub-menu index="3">
            <template #title>
                <el-icon><MapLocation/></el-icon>查看地图
            </template>
            <el-menu-item index="3-1">
                <a href="http://localhost:3000/#/MapPlace" style="width: 100%;text-align: left">
                    节点地图
                </a>
            </el-menu-item>
            <el-menu-item index="3-2">
                <a href="http://localhost:3000/#/MapRout" style="width: 100%;text-align: left">
                    路径地图
                </a>
            </el-menu-item>
        </el-sub-menu>

        <el-sub-menu index="5">
            <template #title>
                <el-icon><DataAnalysis/></el-icon>后台管理
            </template>
            <el-menu-item index="5-1">
                <a href="http://localhost:3000/#/Place" style="width: 100%;text-align: left">
                    节点管理
                </a>
            </el-menu-item>
            <el-menu-item index="5-2">
                <a href="http://localhost:3000/#/Vehicle" style="width: 100%;text-align: left">
                    车辆管理
                </a>
            </el-menu-item>
        </el-sub-menu>
        <el-menu-item index="6">
            <a href="http://localhost:3000/#/AboutMe" style="width: 100%;text-align: left">
                <el-icon><Avatar/></el-icon>关于作者
            </a>
        </el-menu-item>

    </el-menu>
</template>

<script lang="ts">
    import {HomeFilled, InfoFilled, Avatar, MapLocation, DataAnalysis} from '@element-plus/icons-vue';
    // import { ref } from 'vue'
    //
    // const activeIndex = ref('1');
    // const activeIndex2 = ref('1');
    // const handleSelect = (key: string, keyPath: string[]) => {
    //     console.log(key, keyPath);
    // };

    export default {
        name: "MyMenuLeft",
        components: {HomeFilled, InfoFilled, Avatar, MapLocation, DataAnalysis},
    }
</script>

<style scoped>
    #menuLt {
        overflow: hidden;
        width: 75vw;
        border: 0;
    }
</style>