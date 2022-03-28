<template>
    <div>
        <div id="container"></div>
        <div id="show_detail">
            <div style="float: left; width: 35%">
                <table id="bts">
                    <tr>
                        <td>
                            <el-button id="bt1" color="#fff6c8" style="color: black" onclick='bright();' size="small">
                                <el-icon>
                                    <Sunny/>
                                </el-icon>
                                &nbsp;&nbsp;亮色主题&nbsp;&nbsp;&nbsp;&nbsp;
                            </el-button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <el-button color="#003585" style="color: white" onclick='dark();' size="small">
                                <el-icon>
                                    <Moon/>
                                </el-icon>
                                &nbsp;&nbsp;暗色主题&nbsp;&nbsp;&nbsp;&nbsp;
                            </el-button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <el-button type="success" onclick='loadPlaces();' size="small">
                                <el-icon>
                                    <CircleCheckFilled/>
                                </el-icon>
                                &nbsp;&nbsp;加载节点&nbsp;&nbsp;&nbsp;&nbsp;
                            </el-button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <el-button type="warning" onclick='clearPlaces();' size="small">
                                <el-icon>
                                    <CircleClose/>
                                </el-icon>
                                &nbsp;&nbsp;清空覆盖物
                            </el-button>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="overflow: hidden">
                <table id="legend">
                    <tr>
                        <td><img src="../assets/bdmap/1.png"></td>
                        <td class="lgtxt">配送中心</td>
                    </tr>
                    <tr>
                        <td><img src="../assets/bdmap/2.png"></td>
                        <td class="lgtxt">客户点</td>
                    </tr>
                    <tr>
                        <td><img src="../assets/bdmap/3.png"></td>
                        <td class="lgtxt">充电站</td>
                    </tr>
                </table>
            </div>

            <hr/>

            <el-button type="warning" color="#3f71c7" onclick='postForm();' size="small">
                设置参数&nbsp;&nbsp;<el-icon>
                <Setting/>
            </el-icon>
            </el-button>
            <el-button type="success" color="#3f71c7" onclick='loadRout();' size="small">
                查看结果&nbsp;&nbsp;<el-icon>
                <View/>
            </el-icon>
            </el-button>


            <div id="myform">
                <br/>
                <el-form ref="alg" :model="alg" :rules="rules" size="small"
                         inline-message="true" label-width="55%">
                    <el-form-item label="可用车辆数" prop="total_num">
                        <el-input v-model="alg.total_num" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="最大载重(kg)" prop="max_cap">
                        <el-input v-model="alg.max_cap" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="平均行驶速度(km/h)" prop="speed">
                        <el-input v-model="alg.speed" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="续航里程(km)" prop="max_dist">
                        <el-input v-model="alg.max_dist" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="每公里耗电(kW/km)" prop="e_per_dist">
                        <el-input v-model="alg.e_per_dist" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="充电速度(kW)" prop="v_charging">
                        <el-input v-model="alg.v_charging" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="装货时间(min)" prop="load_time">
                        <el-input v-model="alg.load_time" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="卸货时间(min)" prop="unload_time">
                        <el-input v-model="alg.unload_time" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="日租金(元)" prop="rent">
                        <el-input v-model="alg.rent" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="电价(元/kWh)" prop="price_per_e">
                        <el-input v-model="alg.price_per_e" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="配送中心上班时间" prop="start_time">
                        <el-input v-model="alg.start_time" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="遗传算法种群规模" prop="NIND">
                        <el-input v-model="alg.NIND" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="遗传算法代数" prop="MAXGEN">
                        <el-input v-model="alg.MAXGEN" size="small" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="遗传算法变异概率" prop="Pm">
                        <el-input v-model="alg.Pm" size="small" style="width: 80%"/>
                    </el-form-item>

                    <el-form-item>
                        <el-button type="primary" @click="onsubmit(alg)" size="small">执行算法</el-button>
                    </el-form-item>
                    <!--{{res_stat}}-->
                    <p id="res_stat" style="color: gray; font-size: 75%;"></p>
                </el-form>
            </div>

            <div id="myrest">
                <ul id="routvfor">
                    <li style="list-style-type: square"
                            v-for="(vrout,index) in myrout.info_list">
                        {{vrout.title.substring(0, vrout.title.length-1)}}
                        {{vehicle.state.vehicleList[index].plate_number}}
                        <span id="routcolor" v-bind:style="{color: mycolors[index % mycolors.length]}">
                            &nbsp;&nbsp;—————
                        </span>
                        <ol style="padding: 5%">
                            <li style="list-style-image:url('../assets/bdmap/3.png');"
                                    v-for="rout in vrout.rout">
                                {{rout.substring(3)}}
                            </li>
                        </ol>
                    </li>
                </ul>

            </div>

        </div>
    </div>
</template>

<script>
    import axios from "axios";
    import place from "../data/place.js";
    import vehicle from "../data/vehicle.js";
    import {Sunny, Moon, CircleCheckFilled, CircleClose, Setting, View} from '@element-plus/icons-vue';


    export default {
        name: "MapRout",
        components: {Sunny, Moon, CircleCheckFilled, CircleClose, Setting, View},
        data() {
            return {
                mycolors: [ "fuchsia", "red", "lime", "yellow", "aqua",],
                edit_one_c: {
                    pid: "",
                    lng: "",
                    lat: "",
                    demand: "",
                    atime: "",
                    pen: "",
                    phone: "",
                    location_zh: "",
                    info_detail: "",
                },
                edit_one_e: {
                    pid: "",
                    lng: "",
                    lat: "",
                    location_zh: "",
                    info_detail: "",
                },
                myrout: {
                    'exec_time': '',
                    'best_objv': '',
                    'gtime': '',
                    'cir2_list': '',
                    'use_car_num': '',
                    'rent': '',
                    'electricity': '',
                    'time_pen': '',
                    'show_info_text': '',
                    'show_info_html': '',
                    'info_list': [],
                },
                alg: {
                    total_num: "2",
                    max_cap: "1315",
                    speed: "30",
                    max_dist: "150",
                    e_per_dist: "0.6",
                    v_charging: "1.2",
                    load_time: "60",
                    unload_time: "10",
                    rent: "300",
                    price_per_e: "0.825",
                    start_time: "8:00",
                    NIND: "200",
                    MAXGEN: "100",
                    Pm: "0.5",
                },
                rules: {
                    total_num: [{required: true, message: "非空整数", trigger: "blur"}],
                    max_cap: [{required: true, message: "非空整数", trigger: "blur"}],
                    speed: [{required: true, message: "非空整数", trigger: "blur"}],
                    max_dist: [{required: true, message: "非空整数", trigger: "blur"}],
                    e_per_dist: [{required: true, message: "非空小数", trigger: "blur"}],
                    v_charging: [{required: true, message: "非空小数", trigger: "blur"}],
                    load_time: [{required: true, message: "非空整数", trigger: "blur"}],
                    unload_time: [{required: true, message: "非空整数", trigger: "blur"}],
                    rent: [{required: true, message: "非空整数", trigger: "blur"}],
                    price_per_e: [{required: true, message: "非空小数", trigger: "blur"}],
                    start_time: [{required: true, message: "非空", trigger: "blur"}],
                    NIND: [{required: true, message: "非空整数", trigger: "blur"}],
                    MAXGEN: [{required: true, message: "非空整数", trigger: "blur"}],
                    Pm: [{required: true, message: "非空小数", trigger: "blur"}],
                },
            }
        },
        provide: {
            place,
            vehicle,
        },
        setup() {
            axios.get("http://localhost:9090/place/findall").then((result) => {
                place.setplaceList(result.data);
            });
            axios.get("http://localhost:9090/vehicle/findall").then((result) => {
                vehicle.setvehicleList(result.data);
            });
            return {
                place,
                vehicle,
            };
        },
        methods: {
            onsubmit(alg) {
                console.log(alg);   // 此时，alg和this.alg等价
                // console.log("this.res_stat:");
                // console.log(this.res_stat);   // 此时，alg和this.alg等价
                this.$refs['alg'].validate((valid) => {
                    if (valid) {
                        console.log('准备提交！');
                        this.$confirm(
                            '确定提交表单执行算法吗？',
                            '提示', {
                                confirmButtonText: '是，我要提交',
                                cancelButtonText: '取消，我要继续编辑',
                                type: 'warning',
                            }
                        ).then(() => {
                            document.getElementById("res_stat").innerHTML = "正在执行...";
                            axios.post("http://localhost:5050/e?"
                                + "total_num=" + alg.total_num + "&max_cap=" + alg.max_cap
                                + "&speed=" + alg.speed + "&max_dist=" + alg.max_dist
                                + "&e_per_dist=" + alg.e_per_dist + "&v_charging=" + alg.v_charging
                                + "&load_time=" + alg.load_time + "&unload_time=" + alg.unload_time
                                + "&rent=" + alg.rent + "&price_per_e=" + alg.price_per_e
                                + "&start_time=" + alg.start_time + "&NIND=" + alg.NIND
                                + "&MAXGEN=" + alg.MAXGEN + "&Pm=" + alg.Pm
                            )
                                .then((res) => {
                                    let r = res.data.status;
                                    console.log(r);
                                    if (r === 1) {
                                        document.getElementById("res_stat").innerHTML = "求解成功！";
                                    } else if (r === 2) {
                                        document.getElementById("res_stat").innerHTML = "未找到可行解！";
                                    } else {
                                        document.getElementById("res_stat").innerHTML = "求解出错";
                                    }
                                })
                                .catch(function (error) {
                                    console.log(error)//失败
                                }).then(() => {
                                console.log('提交post方法...');
                                // location.reload();
                            });
                        }).catch(function (error) {
                            console.log(error)//失败
                        });

                    } else {
                        console.log('表单填写错误！');
                        return false;
                    }
                });
            },

        },
        mounted() {
            var _this = this;
            var map = new BMapGL.Map("container");
            map.centerAndZoom('上海市', 12);
            map.setMapStyleV2({
                styleId: "12cc649b1e60e91cca56a5c618537d9d",  // 黑色
                // styleId: "603781a9fae3321c9777f59bf794693c",  // 白色
            });
            map.setHeading(-10);
            map.setTilt(60);
            map.enableScrollWheelZoom(true);
            map.addControl(new BMapGL.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT}));
            map.addControl(new BMapGL.ZoomControl({anchor: BMAP_ANCHOR_TOP_RIGHT}));
            let navigationOpts = {
                anchor: BMAP_ANCHOR_TOP_RIGHT,//位置
                type: BMAP_NAVIGATION_CONTROL_SMALL//类型
            };
            map.addControl(new BMapGL.NavigationControl3D(navigationOpts));

            // var pls = place.state.placeList;
            var pts = Array();

            window.myOpenWindow = function (place, bdpt) {
                let htmlContent = "";
                htmlContent += place.location_zh + "<br/>";
                htmlContent += place.info_detail;
                if (place.pid[0] === 'c') {
                    htmlContent += "<br/>需求货物量：" + place.demand + "kg<br/>";
                    htmlContent += "期望收货时间：" + place.atime + "<br/>";
                    htmlContent += "超时罚金系数：" + place.pen + "元/(kg·min)";
                }
                let windowOpts = {
                    title: place.ptypezh  // 信息窗口标题
                };
                let infoWindow = new BMapGL.InfoWindow(htmlContent, windowOpts);  // 创建信息窗口对象
                map.openInfoWindow(infoWindow, bdpt);        // 打开信息窗口
            };

            window.showPoints = function () {
                let pls = place.state.placeList;
                let mysize1 = 25;
                let mysize2 = 20;
                let hwFactor = 1.15;
                let icon1 = new BMapGL.Icon("../src/assets/bdmap/1.png", new BMapGL.Size(mysize1, mysize1));
                let icon2 = new BMapGL.Icon("../src/assets/bdmap/2.png", new BMapGL.Size(mysize2 * hwFactor, mysize2));
                let icon3 = new BMapGL.Icon("../src/assets/bdmap/3.png", new BMapGL.Size(mysize2 * hwFactor, mysize2));

                for (let i = 0; i < pls.length; i++) {
                    let pt = new BMapGL.Point(pls[i].lng, pls[i].lat);
                    pts[i] = pt;
                    let mk = new BMapGL.Marker(pt);
                    if (pls[i].ptype === 1) {
                        mk.setIcon(icon1);
                    } else if (pls[i].ptype === 2) {
                        mk.setIcon(icon2);
                    } else {
                        mk.setIcon(icon3);
                    }
                    // mk.setShadow(mk.getIcon());
                    map.addOverlay(mk);

                    //点击marker标注---打开信息窗口
                    mk.addEventListener('click', function () {
                        if (pls[i].ptype === 1 || pls[i].ptype === 3) {
                            console.log("充电站");
                            axios.get("http://localhost:9090/chargingstation/" + pls[i].pid)
                                .then((resp) => {
                                    _this.edit_one_e = resp.data;
                                    _this.edit_one_e.ptypezh = (pls[i].ptype === 1 ? "配送中心" : "充电站");
                                });

                            setTimeout(function () {
                                myOpenWindow(_this.edit_one_e, pt);
                                console.log("打开窗口完成");
                            }, 150);

                        } else if (pls[i].ptype === 2) {
                            console.log("客户点");
                            axios.get("http://localhost:9090/customer/" + pls[i].pid)
                                .then((resp) => {
                                    _this.edit_one_c = resp.data;
                                    _this.edit_one_c.ptypezh = "客户点";
                                });

                            setTimeout(function () {
                                myOpenWindow(_this.edit_one_c, pt);
                                console.log("打开窗口完成");
                            }, 150);
                        } else {
                            console.log("???");
                            console.log(pls[i]);
                        }
                    });
                }
            };

            window.loadPlaces = function () {
                // 先把place置为空
                place.setplaceList([]);
                let reqUrl = "http://localhost:9090/place/findall";
                axios.get(reqUrl).then((result) => {
                    place.setplaceList(result.data);
                });

                // 在地图上加载点，要比向后台请求数据稍微慢一点。等拿到后台数据了再在地图上加载点。
                setTimeout(function () {
                    showPoints();
                    console.log("加载点完成");
                }, 150);
            };

            window.showRout = function () {
                let clist = eval(_this.myrout.cir2_list);
                for (let i = 0; i < clist.length; i++) {
                    console.log("车辆" + (i+1));
                    let ri = clist[i];
                    let driving = new BMapGL.DrivingRoute(map);
                    for (let j = 0; j < ri.length - 1; j++) {
                        driving.search(pts[ri[j]], pts[ri[j + 1]]);
                        // 加label
                        if (j !== 0) {
                            let lab = new BMapGL.Label(
                                "车辆" + (i+1) + "-途径点" + j,
                            {
                                position: pts[ri[j]],
                                offset: new BMapGL.Size(10, -10)
                            });
                            lab.setStyle({
                                color: 'gray',
                                borderRadius: '5px',
                                borderColor: '#ccc',
                                backgroundColor: 'silver',
                                padding: '2px',
                                fontSize: '50%',
                                height: '15px',
                                // lineHeight: '30px',
                            });
                            map.addOverlay(lab);
                        }
                    }
                    driving.setSearchCompleteCallback(function () {
                        var rpts = driving.getResults().getPlan(0).getRoute(0).getPath();    //通过驾车实例，获得一系列点的数组

                        var polyline = new BMapGL.Polyline(rpts);
                        polyline.setStrokeColor(_this.mycolors[i % _this.mycolors.length]);
                        // polyline.setStrokeStyle("dashed");
                        polyline.setStrokeStyle("solid");
                        polyline.setStrokeWeight(2);
                        map.addOverlay(polyline);

                        // setTimeout(function () {
                        //     map.setViewport(pts);          //调整到最佳视野
                        // }, 200);
                    });
                }
            };

            window.txt2html = function (txt)  {
                let res = "";
                let arr1 = txt.split("***");
                for (let i = 0; i < arr1.length; i++) {
                    let arr1i = arr1[i];
                    if (!arr1i) {
                        continue;
                    }
                    let arr2 = arr1i.split("$$$");
                    for (let j = 0; j < arr2.length; j++) {
                        res += arr2[j] + "<br/>";
                    }
                    res += "<br/>";
                }
                return res.substr(0, res.length - 10);
            };

            window.txt2list = function (txt)  {
                let res = Array();
                let arr1 = txt.split("***");
                for (let i = 1; i < arr1.length; i++) {
                    let arr1i = arr1[i];

                    let arr2 = arr1i.split("$$$");
                    res[i-1] = Object();
                    res[i-1].title = arr2[0];
                    res[i-1].rout = Array();
                    for (let j = 1; j < arr2.length; j++) {
                        res[i-1].rout[j-1] = arr2[j];
                    }
                }
                return res;
            };

            window.loadRout = function () {
                _this.myrout = {
                    'exec_time': '',
                    'best_objv': '',
                    'gtime': '',
                    'cir2_list': '',
                    'use_car_num': '',
                    'rent': '',
                    'electricity': '',
                    'time_pen': '',
                    'show_info_text': '',
                    'show_info_html': '',
                    'info_list': [],
                };
                document.getElementById("myform").style.display = 'none';
                document.getElementById("myrest").style.display = 'inline';
                axios.get("http://localhost:9090/rout/")
                    .then((resp) => {
                        console.log(resp.data);
                        _this.myrout.exec_time = String(resp.data.exec_time);
                        _this.myrout.cir2_list = resp.data.cir2_list;
                        _this.myrout.use_car_num = String(resp.data.use_car_num);
                        _this.myrout.gtime = String(resp.data.gtime);
                        _this.myrout.best_objv = resp.data.best_objv;
                        _this.myrout.rent = resp.data.rent;
                        _this.myrout.electricity = resp.data.electricity;
                        _this.myrout.time_pen = resp.data.time_pen;
                        _this.myrout.show_info_text = String(resp.data.show_info_text);
                        _this.myrout.show_info_html = txt2html(_this.myrout.show_info_text);
                        _this.myrout.info_list = txt2list(_this.myrout.show_info_text);

                        console.log(_this.myrout.info_list);
                        console.log("查看路径规划结果！");
                    });
                // 在地图上加载路径，要比向后台请求数据稍微慢一点。等拿到后台数据了再在地图上加载路径。
                setTimeout(function () {
                    showRout();
                    console.log("加载路径完成");
                }, 150);
            };

            window.clearPlaces = function () {
                map.clearOverlays();
            };

            window.postForm = function () {
                document.getElementById("res_stat").innerHTML = "";
                document.getElementById("myrest").style.display = 'none';
                document.getElementById("myform").style.display = 'inline';
            };

            window.bright = function () {
                document.getElementById("show_detail").style.backgroundImage = 'none';
                document.getElementById("routvfor").style.color = '#000000';
                let lgtxts = document.getElementsByClassName("lgtxt");
                for (let i = 0; i < lgtxts.length; i++) {
                    lgtxts[i].style.color = '#000000';
                }
                // document.getElementById("bt1").style.color = "#fff6c8";
                map.setMapStyleV2({
                    // styleId: "12cc649b1e60e91cca56a5c618537d9d",  // 黑色
                    styleId: "603781a9fae3321c9777f59bf794693c",  // 白色
                });
                // map.setHeading(-10);
                // map.setTilt(60);

            };

            window.dark = function () {
                document.getElementById("show_detail").style.backgroundImage = 'url("src/assets/bdmap/side.webp")';
                document.getElementById("show_detail").style.backgroundRepeat = 'no-repeat';
                document.getElementById("show_detail").style.backgroundSize = '100% 100%';
                document.getElementById("routvfor").style.color = '#ffffff';
                let lgtxts = document.getElementsByClassName("lgtxt");
                for (let i = 0; i < lgtxts.length; i++) {
                    lgtxts[i].style.color = '#ffffff';
                }
                map.setMapStyleV2({
                    styleId: "12cc649b1e60e91cca56a5c618537d9d",  // 黑色
                    // styleId: "603781a9fae3321c9777f59bf794693c",  // 白色
                });
                // map.setHeading(-10);
                // map.setTilt(60);
            };
        }
    }
</script>

<style scoped>
    #container {
        width: 80vw;
        height: 90.5vh;
        float: left;
        overflow: hidden;
    }

    #show_detail {
        height: 90.5vh;
        overflow: hidden;
        background-image: url("../assets/bdmap/side.webp");
        background-repeat: no-repeat;
        background-size: 100% 100%;
        /*滚动条*/
        /*overflow-y: scroll;*/
    }

    /*#show_detail::-webkit-scrollbar {*/
        /*!*不显示滚动条*!*/
        /*width: 0 !important*/
    /*}*/

    #bts {
        width: 100%;
        margin-top: 1.5vh;
        margin-left: 2vw;
        float: left;
    }

    #legend {
        font-family: Arial, Helvetica, sans-serif;
        width: 50%;
        margin-top: 1.5vh;
        margin-left: 5vw;
        overflow: hidden;
    }

    #legend img {
        width: 2.5vh;
        height: 2.5vh;
    }

    #legend td {
        padding: 8px 1px;
        color: white;
        font-size: 70%;
        font-weight: 200;
        text-align: center;
    }

    hr {
        height: 1px;
        border: none;
        border-top: 2px solid #555555;
    }

    #myform {
        display: inline;
        margin-left: 30%;
    }
    form {
        height: 55vh;
        /*滚动条*/
        overflow-y: scroll;
    }
    form::-webkit-scrollbar {
        /*不显示滚动条*/
        width: 0 !important
    }

    #myrest {
        display: none;
        color: gray;
    }

    #routvfor {
        margin-left: 0%;
        color: white;
        text-align: left;
        font-size: 80%;
        font-weight: 200;

        height: 59vh;
        /*滚动条*/
        overflow-y: scroll;
    }
    #routvfor::-webkit-scrollbar {
        /*不显示滚动条*/
        width: 0 !important
    }

    #routcolor {
        font-size: 100%;
        font-weight: 900;
    }


</style>