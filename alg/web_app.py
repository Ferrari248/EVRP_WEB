import json
from flask import Flask, request as freq
from flask_cors import *

import web_utils

app = Flask(__name__)
# 允许跨域请求
CORS(app, supports_credentials=True)
print("已引入flask模块~~")
web_executor = web_utils.WebExecutor()


@app.route("/", methods=["GET"])
def test01():
    print("测试1：flask被调用一次get接口")
    web_executor.counter_test01 += 1
    return "测试1：flask接口get正常, 本次服务器启动后，test01累计被调用次数：" + str(web_executor.counter_test01)


@app.route("/t2", methods=["POST"])
def test02():
    print("测试2：flask被调用一次post接口")
    web_executor.counter_test02 += 1
    params_dict = freq.args.to_dict()
    print("params_dict:\n", params_dict)
    return "测试2：flask接口post正常, 本次服务器启动后，test02累计被调用次数：" + str(web_executor.counter_test02)


@app.route("/u", methods=["GET"])
def updateDist():
    print("执行updateDist函数...")
    web_executor.counter_updateDist += 1
    print("本次服务器启动后，updateDist累计被调用次数：" + str(web_executor.counter_updateDist))

    status = web_utils.update_distance()
    res = {"status": status}
    # status  1: 无需更新  2:s1仅被删除了一些（s3为空）   3:s1仅被添加了一些（s4为空）   4: s1增删都有   5:操作失败
    print("status: %d" % status)
    return json.dumps(res)


@app.route("/e", methods=["POST"])
def executeAlgorithm():
    print("执行executeAlgorithm函数...")
    web_executor.counter_executeAlgorithm += 1
    print("本次服务器启动后，counter_executeAlgorithm累计被调用次数：" + str(web_executor.counter_executeAlgorithm))

    alg_result_dict = {}
    try:
        # 把参数放进字典，传进算法模块
        post_params_dict = freq.args.to_dict()
        print("params_dict:\n", post_params_dict)
        alg_result_dict = web_utils.execute_alg(post_params_dict)
        print("alg_result_dict:", alg_result_dict)
        # 把字典信息写入数据库的tbl_rout表
        web_utils.save_rout_2_db(alg_result_dict, float(post_params_dict.get("speed")) / 3.6)
    except:
        alg_result_dict["use_car_num"] = -2

    # 把字典返回给POST请求
    print(alg_result_dict)
    use_car_num = alg_result_dict.get("use_car_num", -2)
    if use_car_num == -2:
        # 操作失败
        status = 3
    elif use_car_num == -1:
        # 未找到可行解
        status = 2
    else:
        # 正常完成
        status = 1
    res = {"status": status}
    # status=0表示求解成功，1表示失败
    print("status: %d" % status)
    return json.dumps(res)


if __name__ == '__main__':
    app.run(host="localhost",
            port=5050,
            debug=False,
            use_reloader=False)
