import { reactive } from 'vue'

const weather = {
    state: reactive({
        city:"",
        wdata:{
            // 默认值
            wea_img: 'yun',
        },
    }),
    setWeather(data) {
        this.state.wdata = data;
    },
    setCity(data) {
        this.state.city = data;
    },
};

export default weather;