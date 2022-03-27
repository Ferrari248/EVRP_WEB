import { reactive } from 'vue'

const store = {
    state: reactive({
        placeList:[],
    }),
    setPlaceList(list) {
        this.state.placeList = list;
    },
};

export default store;