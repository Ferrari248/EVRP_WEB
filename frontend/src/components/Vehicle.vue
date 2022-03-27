<template>
    <div id="lt">
        <el-table :data="vehicle.state.vehicleList" stripe border
                  style="width: 100%;"
                  height="330">
            <el-table-column prop="vid" label="标识符" width="150"/>
            <el-table-column prop="plate_number" label="车牌号" width="220"/>
            <el-table-column prop="driver" label="司机姓名" width="220"/>
            <el-table-column label="操作" width="200">
                <template #default="scope">

                    <el-button size="small" type="primary" @click="handleEdit(scope.row)">编辑</el-button>
                    &nbsp;&nbsp;&nbsp;
                    <el-button size="small" type="danger" @click="handleDelete(scope.row)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <!--<br/>-->
        <div style="height: 1%"></div>

        <img src="../assets/home/t5d_01.jpg"/>

        <div style="height: 3%"></div>

        <!--添加选项-->
        <div id="addv" style="width: 100%; display: inline">
            <el-form ref="add_one_vehicle" :model="add_one_vehicle" :rules="rules"
                     inline-message="true" label-width="35%">
                <el-form-item label="车牌号" prop="plate_number">
                    <el-input v-model="add_one_vehicle.plate_number" size="mini" style="width: 90%"/>
                </el-form-item>
                <el-form-item label="司机姓名" prop="driver">
                    <el-input v-model="add_one_vehicle.driver" size="mini" style="width: 90%"/>
                </el-form-item>
                <el-form-item>
                    <el-button type="success" size="small" @click="addSubmit(add_one_vehicle)">
                        添加车辆
                    </el-button>
                </el-form-item>
            </el-form>
        </div>

        <!--编辑选项-->
        <div id="editv" style="width: 100%; display: none">
            <el-form ref="edit_one_vehicle" :model="edit_one_vehicle" :rules="rules"
                     inline-message="true" label-width="35%">
                <el-form-item label="车牌号" prop="plate_number">
                    <el-input v-model="edit_one_vehicle.plate_number" size="mini" style="width: 90%"/>
                </el-form-item>
                <el-form-item label="司机姓名" prop="driver">
                    <el-input v-model="edit_one_vehicle.driver" size="mini" style="width: 90%"/>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" size="small" @click="editSubmit(edit_one_vehicle)">
                        提交编辑
                    </el-button>
                </el-form-item>
                <el-form-item>
                    <el-button type="success" size="small" @click="handleAdd">
                        返回添加
                    </el-button>
                </el-form-item>
            </el-form>
        </div>


    </div>

    <div id="rt">
        <div id="rt_top">
            <p>比亚迪T5D车型主要参数</p>
        </div>
        <div id="rt_bottom">
            <table id="bydinfo">
                <tr>
                    <td>公告型号</td>
                    <td>BYD5041XXYBEV1</td>
                </tr>
                <tr>
                    <td>类型</td>
                    <td>厢式载货车</td>
                </tr>
                <tr>
                    <td>车身高度</td>
                    <td>3.15m</td>
                </tr>
                <tr>
                    <td>车身宽度</td>
                    <td>2.13m/2.24m</td>
                </tr>
                <tr>
                    <td>车身长度</td>
                    <td>5.995m</td>
                </tr>
                <tr>
                    <td>轴距</td>
                    <td>3360mm</td>
                </tr>
                <tr>
                    <td>货箱形式</td>
                    <td>厢式</td>
                </tr>
                <tr>
                    <td>货箱长度/宽度/高度</td>
                    <td>4.03m/2.14m/2.05m</td>
                </tr>
                <tr>
                    <td>整车重量</td>
                    <td>3.05t</td>
                </tr>
                <tr>
                    <td>额定重量</td>
                    <td>1.315t</td>
                </tr>
                <!--<tr>-->
                <!--<td>电机品牌</td>-->
                <!--<td>合普动力</td>-->
                <!--</tr>-->
                <!--<tr>  <td>电机型号</td>-->
                <!--<td>TZ260XS55H</td>-->
                <!--</tr>-->
                <tr>
                    <td>最大马力</td>
                    <td>115hp</td>
                </tr>
                <tr>
                    <td>额定功率</td>
                    <td>85kW</td>
                </tr>
                <tr>
                    <td>电机形式</td>
                    <td>永磁同步电动机</td>
                </tr>
                <tr>
                    <td>电池类型</td>
                    <td>磷酸铁锂蓄电池</td>
                </tr>
                <tr>
                    <td>电池容量</td>
                    <td>85kWh</td>
                </tr>
                <tr>
                    <td>充电时间</td>
                    <td>直流/1.2h</td>
                </tr>
            </table>
        </div>
    </div>
</template>

<script>
    import axios from "axios";
    import vehicle from "../data/vehicle.js";

    export default {
        name: "Vehicle",
        provide: {
            vehicle
        },
        setup() {
            let reqUrl = "http://localhost:9090/vehicle/findall";
            axios.get(reqUrl).then((result) => {
                vehicle.setvehicleList(result.data);
            });
            return {
                vehicle
            };
        },
        data() {
            return {
                edit_one_vehicle: {
                    vid: "",
                    plate_number: "沪A-",
                    driver: "",
                },
                add_one_vehicle: {
                    vid: "",
                    plate_number: "沪A-",
                    driver: "",
                },
                rules: {
                    plate_number: [{required: true, message: "必填项", trigger: "blur"}],
                    driver: [{required: true, message: "必填项", trigger: "blur"}],
                }
            }
        },
        methods: {
            editSubmit(vehicle) {
                console.log(vehicle);
                this.$refs['edit_one_vehicle'].validate((valid) => {
                    if (valid) {
                        this.$confirm(
                            '确定提交编辑结果吗？',
                            '提示', {
                                confirmButtonText: '是，我要提交',
                                cancelButtonText: '取消，我要继续编辑',
                                type: 'warning',
                            }
                        ).then(() => {
                            axios.put("http://localhost:9090/vehicle/update?vid=" + vehicle.vid
                                + "&plate_number=" + vehicle.plate_number
                                + "&driver=" + vehicle.driver
                            )
                                .catch(function (error) {
                                    console.log(error)//失败
                                }).then(() => {
                                location.reload();
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
            addSubmit(vehicle) {
                this.$refs['add_one_vehicle'].validate((valid) => {
                    if (valid) {
                        this.$confirm(
                            '确定提交添加结果吗？',
                            '提示', {
                                confirmButtonText: '是，我要提交',
                                cancelButtonText: '取消，我要继续编辑',
                                type: 'warning',
                            }
                        ).then(() => {
                            axios.post("http://localhost:9090/vehicle/save?vid=" + vehicle.vid
                                + "&plate_number=" + vehicle.plate_number
                                + "&driver=" + vehicle.driver
                            )
                                .catch(function (error) {
                                    console.log(error)//失败
                                }).then(() => {
                                location.reload();
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
            handleEdit(row) {
                document.getElementById("addv").style.display = 'none';
                document.getElementById("editv").style.display = 'inline';
                // 读取这个记录的属性值
                this.edit_one_vehicle.vid = row.vid;
                this.edit_one_vehicle.plate_number = row.plate_number;
                this.edit_one_vehicle.driver = row.driver;
            },
            handleAdd() {
                document.getElementById("editv").style.display = 'none';
                document.getElementById("addv").style.display = 'inline';
            },
            handleDelete(row) {
                this.$confirm(
                    '你确定要删除车辆 ' + row.plate_number + ' 吗？',
                    '提示', {
                        confirmButtonText: '是，我要删除',
                        cancelButtonText: '取消，我点错了',
                        type: 'warning',
                    }
                ).then(() => {
                    axios.delete("http://localhost:9090/vehicle/deleteById?vid=" + row.vid)
                }).catch(function (error) {
                    console.log(error)//失败
                }).then(() => {
                    location.reload();
                });
            },
        }
    }
</script>

<style scoped>

    #lt {
        width: 60vw;
        height: 95vh;
        float: left;
        background-color: #becce1;
    }

    #rt {
        width: 40vw;
        height: 95vh;
        overflow: hidden;
        /*background-color: #becce1;*/
        background-image: url('../assets/home/boxes_unclear2.png');
        background-repeat: no-repeat;
        background-size: 200% 100%;
    }

    #rt_top {
        width: 100%;
        height: 6vh;
        font-weight: 600;
        font-size: 8px;
        /*margin-top: 0.5vh;*/
        /*overflow: hidden;*/
    }

    #lt img {
        width: 70%;
        height: 38%;
        float: right;
    }

    #rt_bottom {
        width: 100%;
        height: 90vh;
        /*overflow-y: scroll;*/
    }


    #bydinfo {
        font-family: Arial, Helvetica, sans-serif;
        border-collapse: collapse;
        width: 86%;
        height: 90%;
        margin-left: 7%;
        overflow-y: scroll;
        /*display:block;*/
    }

    #bydinfo ::-webkit-scrollbar {
        /*不显示滚动条*/
        width: 0 !important
    }

    #bydinfo td, #bydinfo th {
        border: 1px solid #ddd;
        /*padding: 8px;*/
        /*display:table;*/
    }

    #bydinfo tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    #bydinfo tr:hover {
        background-color: #ddd;
    }


</style>