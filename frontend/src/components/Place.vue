<template>

    <div id="lt">
        <!--<h3>-->
        <!--全部节点信息查看-->
        <!--</h3>-->

        <el-table :data="place.state.placeList" stripe border
                  style="width: 86%; margin-left: 7%; margin-top: 3%"
                  height="500">
            <el-table-column prop="pid" label="标识符" width="100"/>
            <el-table-column prop="ptypezh" label="类型" width="150"/>
            <el-table-column prop="lng" label="经度" width="180"/>
            <el-table-column prop="lat" label="纬度" width="180"/>
            <el-table-column label="操作" width="200">
                <template #default="scope">
                    <el-button size="small" type="primary" @click="pHandleEdit(scope.row)">编辑</el-button>
                    <el-button size="small" type="danger" @click="pHandleDelete(scope.row)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>

    <div id="rt">
        <br/>&nbsp;&nbsp;&nbsp;
        <el-tag class="ml-2" type="primary" @click="chrt1" size="large">
            <p style="cursor:pointer;">&nbsp;&nbsp;&nbsp;添加客户点&nbsp;&nbsp;&nbsp;</p></el-tag>
        &nbsp;&nbsp;&nbsp;
        <el-tag class="ml-2" type="success" @click="chrt2" size="large">
            <p style="cursor:pointer">&nbsp;&nbsp;&nbsp;添加充电站&nbsp;&nbsp;&nbsp;</p></el-tag>
        &nbsp;&nbsp;&nbsp;
        <el-tag class="ml-2" type="warning" @click="upd" size="large">
            <p style="cursor:pointer">&nbsp;&nbsp;&nbsp;更新距离表&nbsp;&nbsp;&nbsp;</p></el-tag>

        <div style="height: 3vh"></div>

        <div id="rt1" style="width: 100%; display: inline">
            <!--客户点-->
            <!--添加选项-->
            <div id="addc" style="width: 100%; display: inline">
                <el-form ref="add_one_c" :model="add_one_c" :rules="c_rules"
                         inline-message="true" label-width="35%">
                    <el-form-item label="经度" prop="lng">
                        <el-input v-model="add_one_c.lng" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="纬度" prop="lat">
                        <el-input v-model="add_one_c.lat" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="需求货物" prop="demand">
                        <el-input v-model="add_one_c.demand" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="期望时间" prop="atime">
                        <el-input v-model="add_one_c.atime" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="超时罚金系数" prop="pen">
                        <el-input v-model="add_one_c.pen" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="电话" prop="phone">
                        <el-input v-model="add_one_c.phone" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="地址" prop="location_zh">
                        <el-input v-model="add_one_c.location_zh" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="详细信息" prop="info_detail">
                        <el-input v-model="add_one_c.info_detail" size="mini" style="width: 90%"/>
                    </el-form-item>

                    <el-form-item>
                        <el-button type="success" size="mini" @click="cAddSubmit(add_one_c)">
                            提交添加客户点
                        </el-button>
                    </el-form-item>
                </el-form>
            </div>

            <!--编辑选项-->
            <div id="eddc" style="width: 100%; display: none">
                <el-form ref="edit_one_c" :model="edit_one_c" :rules="c_rules"
                         inline-message="true" label-width="35%">
                    <el-form-item label="经度" prop="lng">
                        <el-input v-model="edit_one_c.lng" size="mini" style="width: 90%" disabled/>
                    </el-form-item>
                    <el-form-item label="纬度" prop="lat">
                        <el-input v-model="edit_one_c.lat" size="mini" style="width: 90%" disabled/>
                    </el-form-item>
                    <el-form-item label="需求货物" prop="demand">
                        <el-input v-model="edit_one_c.demand" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="期望时间" prop="atime">
                        <el-input v-model="edit_one_c.atime" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="超时罚金系数" prop="pen">
                        <el-input v-model="edit_one_c.pen" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="电话" prop="phone">
                        <el-input v-model="edit_one_c.phone" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="地址" prop="location_zh">
                        <el-input v-model="edit_one_c.location_zh" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="详细信息" prop="info_detail">
                        <el-input v-model="edit_one_c.info_detail" size="mini" style="width: 90%"/>
                    </el-form-item>

                    <el-form-item>
                        <el-button type="primary" size="mini" @click="cEditSubmit(edit_one_c)">
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
                         inline-message="true" label-width="35%">
                    <el-form-item label="经度" prop="lng">
                        <el-input v-model="add_one_e.lng" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="纬度" prop="lat">
                        <el-input v-model="add_one_e.lat" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="地址" prop="location_zh">
                        <el-input v-model="add_one_e.location_zh" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="详细信息" prop="info_detail">
                        <el-input v-model="add_one_e.info_detail" size="mini" style="width: 90%"/>
                    </el-form-item>

                    <el-form-item>
                        <el-button type="success" size="mini" @click="eAddSubmit(add_one_e)">
                            提交添加充电站
                        </el-button>
                    </el-form-item>
                </el-form>
            </div>

            <!--编辑选项-->
            <div id="edde" style="width: 100%; display: none">
                <el-form ref="edit_one_e" :model="edit_one_e" :rules="e_rules"
                         inline-message="true" label-width="35%">
                    <el-form-item label="经度" prop="lng">
                        <el-input v-model="edit_one_e.lng" size="mini" style="width: 90%" disabled/>
                    </el-form-item>
                    <el-form-item label="纬度" prop="lat">
                        <el-input v-model="edit_one_e.lat" size="mini" style="width: 90%" disabled/>
                    </el-form-item>
                    <el-form-item label="地址" prop="location_zh">
                        <el-input v-model="edit_one_e.location_zh" size="mini" style="width: 90%"/>
                    </el-form-item>
                    <el-form-item label="详细信息" prop="info_detail">
                        <el-input v-model="edit_one_e.info_detail" size="mini" style="width: 90%"/>
                    </el-form-item>

                    <el-form-item>
                        <el-button type="primary" size="mini" @click="eEditSubmit(edit_one_e)">
                            提交编辑充电站
                        </el-button>
                    </el-form-item>
                </el-form>
            </div>

        </div>
    </div>

</template>

<script lang="ts">
    import axios from "axios";
    import place from "../data/place.js";

    export default {
        name: "Place",
        provide: {
            place
        },
        setup() {
            let reqUrl = "http://localhost:9090/place/findall";
            axios.get(reqUrl).then((result) => {
                place.setplaceList(result.data);
            });
            return {
                place
            };
        },
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
        methods: {
            chrt1() {
                document.getElementById("rt2").style.display = 'none';
                document.getElementById("rt1").style.display = 'inline';
                document.getElementById("addc").style.display = 'inline';
                document.getElementById("eddc").style.display = 'none';
            },
            chrt2() {
                document.getElementById("rt1").style.display = 'none';
                document.getElementById("rt2").style.display = 'inline';
                document.getElementById("adde").style.display = 'inline';
                document.getElementById("edde").style.display = 'none';
            },
            upd() {
                axios.get("http://localhost:5050/u");
            },
            pHandleDelete(row) {
                this.$confirm(
                    '你想要删除节点 ' + row.pid + ' 吗？',
                    '提示', {
                        confirmButtonText: '是，我要删除',
                        cancelButtonText: '取消，我点错了',
                        type: 'warning',
                    }
                ).then(() => {
                    if (row.ptype === 1 || row.ptype === 3) {
                        axios.delete("http://localhost:9090/chargingstation/deleteById?pid=" + row.pid)
                    } else if (row.ptype === 2) {
                        axios.delete("http://localhost:9090/customer/deleteById?pid=" + row.pid)
                    } else {
                        console.log("ptype不正确，无法删除");
                    }
                }).catch(function (error) {
                    console.log(error)//失败
                }).then(() => {
                    location.reload();
                });
            },
            pHandleEdit(row) {
                if (row.ptype === 1 || row.ptype === 3) {
                    this.chrt2();
                    document.getElementById("adde").style.display = 'none';
                    document.getElementById("edde").style.display = 'inline';
                    axios.get("http://localhost:9090/chargingstation/" + row.pid)
                        .then((resp) => {
                            this.edit_one_e = resp.data;
                        });
                } else if (row.ptype === 2) {
                    this.chrt1();
                    document.getElementById("addc").style.display = 'none';
                    document.getElementById("eddc").style.display = 'inline';
                    axios.get("http://localhost:9090/customer/" + row.pid)
                        .then((resp) => {
                            this.edit_one_c = resp.data;
                        });
                } else {
                    console.log("ptype:" + row.pytpe);
                    console.error("ptype不正确！");
                }
            },
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

    #lt {
        width: 70vw;
        height: 95vh;
        float: left;
        background-color: #becce1;
    }

    #rt {
        width: 30vw;
        height: 95vh;
        overflow: hidden;
        background-color: rgba(94, 30, 52, 0.4);
        /*background-image: url('../assets/home/boxes_unclear2.png');*/
        /*background-repeat: no-repeat;*/
        /*background-size: 200% 100%;*/
    }

</style>