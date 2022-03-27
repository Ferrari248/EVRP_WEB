import {createRouter, createWebHashHistory} from 'vue-router';

import MapPlace from "../components/MapPlace.vue";
import MapRout from "../components/MapRout.vue";
import MyNotFound from "../components/MyNotFound.vue";
import AboutMe from "../components/AboutMe.vue";
import MyHome from "../components/MyHome.vue";
import MyIntroduce from "../components/MyIntroduce.vue";
import Place from "../components/Place.vue";
import Vehicle from "../components/Vehicle.vue";

// 1. 定义路由组件.
// 也可以从其他文件导入

// 2. 定义一些路由
// 每个路由都需要映射到一个组件。
// 我们后面再讨论嵌套路由。
const routes = [
    { path: '/', component: MyHome },
    { path: '/MapPlace', component: MapPlace },
    { path: '/MapRout', component: MapRout },
    { path: '/MyIntroduce', component: MyIntroduce },
    { path: '/AboutMe', component: AboutMe },
    { path: '/Vehicle', component: Vehicle },
    { path: '/Place', component: Place },
    { path: '/:path(.*)', component: MyNotFound },
];

// 3. 创建路由实例并传递 `routes` 配置
// 你可以在这里输入更多的配置，但我们在这里
// 暂时保持简单
const router = createRouter({
    // 4. 内部提供了 history 模式的实现。为了简单起见，我们在这里使用 hash 模式。
    history: createWebHashHistory(),
    routes, // `routes: routes` 的缩写
});

export default router;

