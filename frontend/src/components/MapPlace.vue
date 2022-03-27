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
                                &nbsp;&nbsp;清空节点&nbsp;&nbsp;&nbsp;&nbsp;
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
            <div id="forms">
                <div id="rt1" style="width: 100%; display: inline">
                    <!--客户点-->
                    <!--添加选项-->
                    <div id="addc" style="width: 100%; display: inline">
                        <el-form ref="add_one_c" :model="add_one_c" :rules="c_rules"
                                 size="small" inline-message="true" label-width="40%">
                            <el-form-item label="经度" prop="lng">
                                <el-input v-model="add_one_c.lng" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="纬度" prop="lat">
                                <el-input v-model="add_one_c.lat" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="需求货物" prop="demand">
                                <el-input v-model="add_one_c.demand" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="期望时间" prop="atime">
                                <el-input v-model="add_one_c.atime" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="超时罚金系数" prop="pen">
                                <el-input v-model="add_one_c.pen" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="电话" prop="phone">
                                <el-input v-model="add_one_c.phone" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="地址" prop="location_zh">
                                <el-input v-model="add_one_c.location_zh" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="详细信息" prop="info_detail">
                                <el-input v-model="add_one_c.info_detail" size="small" style="width: 90%"/>
                            </el-form-item>

                            <el-form-item>
                                <el-button type="success" size="small" @click="cAddSubmit(add_one_c)">
                                    提交添加客户点
                                </el-button>
                            </el-form-item>
                        </el-form>
                    </div>

                    <!--编辑选项-->
                    <div id="eddc" style="width: 100%; display: none">
                        <el-form ref="edit_one_c" :model="edit_one_c" :rules="c_rules"
                                 size="small" inline-message="true" label-width="40%">
                            <el-form-item label="经度" prop="lng">
                                <el-input v-model="edit_one_c.lng" size="small" style="width: 90%" disabled/>
                            </el-form-item>
                            <el-form-item label="纬度" prop="lat">
                                <el-input v-model="edit_one_c.lat" size="small" style="width: 90%" disabled/>
                            </el-form-item>
                            <el-form-item label="需求货物" prop="demand">
                                <el-input v-model="edit_one_c.demand" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="期望时间" prop="atime">
                                <el-input v-model="edit_one_c.atime" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="超时罚金系数" prop="pen">
                                <el-input v-model="edit_one_c.pen" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="电话" prop="phone">
                                <el-input v-model="edit_one_c.phone" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="地址" prop="location_zh">
                                <el-input v-model="edit_one_c.location_zh" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="详细信息" prop="info_detail">
                                <el-input v-model="edit_one_c.info_detail" size="small" style="width: 90%"/>
                            </el-form-item>

                            <el-form-item>
                                <el-button type="primary" size="small" @click="cEditSubmit(edit_one_c)">
                                    提交编辑客户点
                                </el-button>
                            </el-form-item>
                        </el-form>
                    </div>
                </div>
                <div id="rt2">
                    <!--充电站-->
                    <!--添加选项-->
                    <div id="adde" style="width: 100%; display: none">
                        <el-form ref="add_one_e" :model="add_one_e" :rules="e_rules"
                                 size="small" inline-message="true" label-width="40%">
                            <el-form-item label="经度" prop="lng">
                                <el-input v-model="add_one_e.lng" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="纬度" prop="lat">
                                <el-input v-model="add_one_e.lat" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="地址" prop="location_zh">
                                <el-input v-model="add_one_e.location_zh" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="详细信息" prop="info_detail">
                                <el-input v-model="add_one_e.info_detail" size="small" style="width: 90%"/>
                            </el-form-item>

                            <el-form-item>
                                <el-button type="success" size="small" @click="eAddSubmit(add_one_e)">
                                    提交添加充电站
                                </el-button>
                            </el-form-item>
                        </el-form>
                    </div>

                    <!--编辑选项-->
                    <div id="edde" style="width: 100%; display: none">
                        <el-form ref="edit_one_e" :model="edit_one_e" :rules="e_rules"
                                 size="small" inline-message="true" label-width="40%">
                            <el-form-item label="经度" prop="lng">
                                <el-input v-model="edit_one_e.lng" size="small" style="width: 90%" disabled/>
                            </el-form-item>
                            <el-form-item label="纬度" prop="lat">
                                <el-input v-model="edit_one_e.lat" size="small" style="width: 90%" disabled/>
                            </el-form-item>
                            <el-form-item label="地址" prop="location_zh">
                                <el-input v-model="edit_one_e.location_zh" size="small" style="width: 90%"/>
                            </el-form-item>
                            <el-form-item label="详细信息" prop="info_detail">
                                <el-input v-model="edit_one_e.info_detail" size="small" style="width: 90%"/>
                            </el-form-item>

                            <el-form-item>
                                <el-button type="primary" size="small" @click="eEditSubmit(edit_one_e)">
                                    提交编辑充电站
                                </el-button>
                            </el-form-item>
                        </el-form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from "axios";
    import place from "../data/place.js";
    import {Sunny, Moon, CircleCheckFilled, CircleClose} from '@element-plus/icons-vue';

    export default {
        name: "MapPlace",
        components: {Sunny, Moon, CircleCheckFilled, CircleClose},
        data() {
            return {
                add_one_c: {
                    pid: "",
                    lng: 121.3333,
                    lat: 31.2222,
                    demand: 200,
                    atime: "9:20",
                    pen: "0.001",
                    phone: "",
                    location_zh: "",
                    info_detail: "",
                },
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
                c_rules: {
                    lng: [{required: true, message: "必填项", trigger: "blur"}],
                    lat: [{required: true, message: "必填项", trigger: "blur"}],
                    demand: [{required: true, message: "必填项", trigger: "blur"}],
                    atime: [{required: true, message: "必填项", trigger: "blur"}],
                    pen: [{required: true, message: "必填项", trigger: "blur"}],
                },
                add_one_e: {
                    pid: "",
                    lng: 121.4444,
                    lat: 31.3333,
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
                e_rules: {
                    lng: [{required: true, message: "必填项", trigger: "blur"}],
                    lat: [{required: true, message: "必填项", trigger: "blur"}],
                },
            }
        },
        provide: {
            place
        },
        setup() {
            axios.get("http://localhost:9090/place/findall").then((result) => {
                place.setplaceList(result.data);
            });
            return {
                place
            };
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

            let menu = new BMapGL.ContextMenu();

            let txtMenuItem = [
                {
                    text: '添加客户点',
                    callback: function (e) {
                        document.getElementById("adde").style.display = 'none';
                        document.getElementById("edde").style.display = 'none';
                        document.getElementById("eddc").style.display = 'none';
                        document.getElementById("addc").style.display = 'inline';
                        _this.add_one_c.lat = e.lat;
                        _this.add_one_c.lng = e.lng;
                    }
                },
                {
                    text: '添加充电站',
                    callback: function (e) {
                        document.getElementById("edde").style.display = 'none';
                        document.getElementById("addc").style.display = 'none';
                        document.getElementById("eddc").style.display = 'none';
                        document.getElementById("adde").style.display = 'inline';
                        _this.add_one_e.lat = e.lat;
                        _this.add_one_e.lng = e.lng;
                    }
                }
            ];
            for (var i = 0; i < txtMenuItem.length; i++) {
                menu.addItem(new BMapGL.MenuItem(
                    txtMenuItem[i].text,
                    txtMenuItem[i].callback,
                    100
                ));
            }
            map.addContextMenu(menu);

            window.mapAddPoints = function () {
                let pls = place.state.placeList;
                let mysize1 = 25;
                let mysize2 = 20;
                let hwFactor = 1.15;
                let icon1 = new BMapGL.Icon("../src/assets/bdmap/1.png", new BMapGL.Size(mysize1, mysize1));
                let icon2 = new BMapGL.Icon("../src/assets/bdmap/2.png", new BMapGL.Size(mysize2 * hwFactor, mysize2));
                let icon3 = new BMapGL.Icon("../src/assets/bdmap/3.png", new BMapGL.Size(mysize2 * hwFactor, mysize2));

                for (let i = 0; i < pls.length; i++) {
                    let pt = new BMapGL.Point(pls[i].lng, pls[i].lat);
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
                            document.getElementById("addc").style.display = 'none';
                            document.getElementById("eddc").style.display = 'none';
                            document.getElementById("adde").style.display = 'none';
                            document.getElementById("edde").style.display = 'inline';

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
                            document.getElementById("addc").style.display = 'none';
                            document.getElementById("edde").style.display = 'none';
                            document.getElementById("adde").style.display = 'none';
                            document.getElementById("eddc").style.display = 'inline';

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

            window.loadPlaces = function () {
                // 先把place置为空
                place.setplaceList([]);
                let reqUrl = "http://localhost:9090/place/findall";
                axios.get(reqUrl).then((result) => {
                    place.setplaceList(result.data);
                });

                // 在地图上加载点，要比向后台请求数据稍微慢一点。等拿到后台数据了再在地图上加载点。
                setTimeout(function () {
                    mapAddPoints();
                    console.log("加载点完成");
                }, 150);

            };

            window.clearPlaces = function () {
                map.clearOverlays();
                document.getElementById("adde").style.display = 'none';
                document.getElementById("edde").style.display = 'none';
                document.getElementById("addc").style.display = 'none';
                document.getElementById("eddc").style.display = 'none';
            };

            window.bright = function () {
                document.getElementById("show_detail").style.backgroundImage = 'none';
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

        },
        methods: {
            cAddSubmit(customer) {
                this.$refs['add_one_c'].validate((valid) => {
                    if (valid) {
                        this.$confirm(
                            '你确定要添加客户点吗？',
                            '提示', {
                                confirmButtonText: '是，我要添加',
                                cancelButtonText: '取消，我还要编辑',
                                type: 'warning',
                            }
                        ).then(() =>
                            axios.post("http://localhost:9090/customer/save?pid="
                                + customer.pid + "&lng=" + customer.lng + "&lat=" + customer.lat
                                + "&pen=" + customer.pen + "&demand=" + customer.demand
                                + "&atime=" + customer.atime + "&phone=" + customer.phone
                                + "&location_zh=" + customer.location_zh
                                + "&info_detail=" + customer.info_detail
                            ).catch(function (error) {
                                console.log(error)//失败
                            }).then(() => {
                                location.reload();
                            })
                        ).catch(function (error) {
                            console.log(error)//失败
                        });
                    } else {
                        console.log('表单填写错误！');
                        return false;
                    }
                });
            },
            cEditSubmit(customer) {
                this.$refs['edit_one_c'].validate((valid) => {
                    if (valid) {
                        this.$confirm(
                            '你确定要提交对客户点' + customer.pid + '的编辑吗？',
                            '提示', {
                                confirmButtonText: '是，我要提交',
                                cancelButtonText: '取消，我还要编辑',
                                type: 'warning',
                            }
                        ).then(() =>
                            axios.put("http://localhost:9090/customer/update?pid="
                                + customer.pid + "&lng=" + customer.lng + "&lat=" + customer.lat
                                + "&pen=" + customer.pen + "&demand=" + customer.demand
                                + "&atime=" + customer.atime + "&phone=" + customer.phone
                                + "&location_zh=" + customer.location_zh
                                + "&info_detail=" + customer.info_detail
                            ).catch(function (error) {
                                console.log(error)//失败
                            }).then(() => {
                                location.reload();
                            })
                        ).catch(function (error) {
                            console.log(error)//失败
                        });
                    } else {
                        console.log('表单填写错误！');
                        return false;
                    }
                });
            },
            eAddSubmit(cs) {
                this.$refs['add_one_e'].validate((valid) => {
                    if (valid) {
                        console.log(cs);
                        this.$confirm(
                            '你确定要添加充电站吗？',
                            '提示', {
                                confirmButtonText: '是，我要添加',
                                cancelButtonText: '取消，我还要编辑',
                                type: 'warning',
                            }
                        ).then(() =>
                            axios.post("http://localhost:9090/chargingstation/save?"
                                + "lng=" + cs.lng + "&lat=" + cs.lat
                                + "&location_zh=" + cs.location_zh
                                + "&info_detail=" + cs.info_detail
                            ).catch(function (error) {
                                console.log(error)//失败
                            }).then(() => {
                                location.reload();
                            }))
                            .catch(function (error) {
                                console.log(error)//失败
                            })
                    } else {
                        console.log('表单填写错误！');
                        return false;
                    }
                });
            },
            eEditSubmit(cs) {
                this.$refs['edit_one_e'].validate((valid) => {
                    if (valid) {
                        this.$confirm(
                            '你确定要提交对充电站' + cs.pid + '的编辑吗？',
                            '提示', {
                                confirmButtonText: '是，我要提交',
                                cancelButtonText: '取消，我还要编辑',
                                type: 'warning',
                            }
                        ).then(() =>
                            axios.put("http://localhost:9090/chargingstation/update?pid="
                                + cs.pid + "&lng=" + cs.lng + "&lat=" + cs.lat
                                + "&location_zh=" + cs.location_zh
                                + "&info_detail=" + cs.info_detail
                            ).catch(function (error) {
                                console.log(error)//失败
                            }).then(() => {
                                location.reload();
                            })
                        ).catch(function (error) {
                            console.log(error)//失败
                        })
                    } else {
                        console.log('表单填写错误！');
                        return false;
                    }
                });
            },
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
        overflow-y: scroll;
    }

    #show_detail::-webkit-scrollbar {
        /*不显示滚动条*/
        width: 0 !important
    }

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
        /*border: gray 2px solid;*/
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

    #forms {
        width: 100%;
    }

</style>