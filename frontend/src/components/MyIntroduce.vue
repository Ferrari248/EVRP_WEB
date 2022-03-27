<template>
    <div>
        <div id="myIntroduce">
            <h1>
                物流配送路径规划系统简介
            </h1>
            <p id="phead">
                <br/><br/>
                本系统采用了典型的前后端分离架构，即前端系统与后端系统独立运行，高度解耦。前端系统使用Vue.js实现，后端系统使用Spring
                Boot实现，两者间通过http协议进行交互，同时后端程序也能访问和操作MySQL数据库。此外，系统中还有算法模块，脱离于Spring Boot程序而单独运行。
            </p><br/><br/>
            <p>
                系统具备如下特点：
            </p>
            <p>
                (1)对象信息化。物流系统中的各角色被充分数字化，用户能够实时准确地查看、增加、删除和修改系统中的数据信息，以实现方便的管理。这些信息包括：物流企业的车辆信息、配送中心信息、客户点信息和充电站信息等。
            </p>
            <p>
                (2)过程智能化。该系统能够自动求解CEVRPTW问题，并且不依赖于专业的软件、不需要繁琐的软件操作，以降低用户的操作技术门槛。
            </p>
            <p>
                (3)结果可视化。系统能够自动将求解结果直观地显示出来，使用户清晰地了解系统给出的具体路径规划方案。
            </p>
            <p>
                (4)运维简单化。系统的部署、版本迭代和后期维护都较为简单，以减少相关的人力和物力成本。
            </p>
        </div>
    </div>
</template>

<script>
    export default {
        name: "MyIntroduce"
    }
</script>

<style scoped>
    #myIntroduce {
        width: 100%;
        /*height: 100%;*/
        float: top;
        overflow: hidden;
        height: 100vh;
        background-image: url("../assets/home/universe.jpg");
        background-repeat:no-repeat;
        background-size: 150% 100%;
    }

    p {
        margin-left: 200px;
        margin-right: 200px;
        color: rgba(255, 255, 255, 0.76);
        opacity: 100%;
        text-align: justify;
        font-size: 100%;
        font-weight: 500;
    }
    h1 {
        color: #7a8db1;
    }
    #phead {
        font-weight: 600;
    }
</style>