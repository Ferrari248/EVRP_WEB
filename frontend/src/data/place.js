import { reactive } from 'vue'

const place = {
    state: reactive({
        placeList:[],
        cList:[],
        eList:[],
    }),
    setplaceList(list) {
        for (let i = 0; i < list.length; i++) {
            if (list[i].ptype === 1) {
                list[i].ptypezh = "配送中心";
            } else if (list[i].ptype === 2) {
                list[i].ptypezh = "客户点";
            } else if (list[i].ptype === 3) {
                list[i].ptypezh = "充电站";
            } else {
                list[i].ptypezh = "未知点";
            }
        }
        this.state.placeList = list;
    },

    setCList(list) {
        for (let i = 0; i < list.length; i++) {
            list[i].ptypezh = "客户点";
        }
        this.state.cList = list;
    },
    setEList(list) {
        for (let i = 0; i < list.length; i++) {
            if (list[i].pid.substring(0,1) == 'a') {
                list[i].ptypezh = "配送中心";
            } else if (list[i].pid.substring(0,1) == 'e') {
                list[i].ptypezh = "充电站";
            }
        }
        this.state.eList = list;
    },
};

export default place;