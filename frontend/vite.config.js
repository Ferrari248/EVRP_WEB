import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  // devServer: {
  //   proxy: {
  //     '/api': {
  //       // 此处的写法，目的是为了 将 /api 替换成 http://pv.sohu.com/cityjson
  //       target: 'https://www.baidu.com',
  //       // target: 'http://pv.sohu.com/cityjson/',
  //       // 允许跨域
  //       changeOrigin: true,
  //       ws: true,
  //       pathRewrite: {
  //         '^/api': ''
  //       }
  //     }
  //   }
  // }
})
