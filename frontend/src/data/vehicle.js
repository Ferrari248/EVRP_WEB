import { reactive } from 'vue'

const vehicle = {
    state: reactive({
        vehicleList:[],
    }),
    setvehicleList(list) {
        this.state.vehicleList = list;
    },
};

export default vehicle;