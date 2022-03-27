<template>
    <div id="app">
        <div id="menubar">
            <MyMenuRight />
            <MyMenuLeft />
        </div>
        <router-view id="showOut"></router-view>
    </div>
</template>

<script>
    import MyMenuLeft from "./components/MyMenuLeft.vue";
    import MyMenuRight from "./components/MyMenuRight.vue";

    export default {
        name: 'app',
        components: {MyMenuLeft, MyMenuRight}
    }
</script>

<style>
    a {
        color: #ffffff;
        text-decoration: none;
    }

    #menubar {
        width: 100%;
        float: top;
    }

    #showOut {
        /*background-color: rgba(255, 218, 72, 0.73);*/
        width: 100%;
        overflow: hidden;
        border: 0;
    }

</style>