<template>

    <div>
        <div id="pic">
            <br/><br/><br/><br/><br/><br/>
            <br/><br/><br/><br/><br/><br/>
            <br/><br/><br/><br/><br/><br/>
            <br/><br/><br/>
            <p>
                Author：&nbsp;Liu Yang&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </p>
            <p>
                Github：&nbsp;
                <a href="https://github.com/Ferrari248/EVRP_WEB" target="_blank">
                    https://github.com/Ferrari248/EVRP_WEB
                </a>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </p>
        </div>
    </div>


</template>

<script>
    export default {
        name: "AboutMe"
    }
</script>

<style scoped>
    a {
        color: rgba(76, 255, 135, 0.64);
        text-decoration: blink;
    }
    p {
        color: rgba(255, 255, 255, 0.97);
        font-weight: 600;
    }
    #pic {
        background-image: url("../assets/home/ecnu.jpg");
        background-repeat:no-repeat;
        background-size: 100% 94%;
        width: 100%;
        height: 100vh;
        float: top;
    }
</style>