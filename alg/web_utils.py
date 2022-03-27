import json
import requests as rq
import time
import math
import random as rd
import pymysql
import numpy as np
import time
import geatpy as ea

EARTH_RADIUS = 6378.137
pi = math.pi
H = 'abcdefghijklmnopqrstuvwxyz0123456789'


def rad(d):
    """仅被calc_dist_with_factor调用"""
    return d * pi / 180.0


def calc_dist_with_factor(lat1, lng1, lat2, lng2, factor):
    """
    根据经纬度计算两点间的距离。
    :param lng2:
    :param lat2:
    :param lng1:
    :param lat1:
    :param factor: 距离系数。设定一个大于1的数。
    :return:  距离。int型。单位：米
    """
    radLat1 = rad(lat1)
    radLat2 = rad(lat2)
    a = radLat1 - radLat2
    b = rad(lng1) - rad(lng2)
    s = 2 * math.asin(
        math.sqrt(math.pow(math.sin(a / 2), 2) + math.cos(radLat1) * math.cos(radLat2) * math.pow(math.sin(b / 2), 2)))
    return round(s * EARTH_RADIUS * factor * 1000)


def latlng_2str(lat, lng):
    return str(lat) + "," + str(lng)


def get_rand_str(length):
    """生成指定长度为length的随机字符串"""
    string = ''
    for j in range(length):
        string += rd.choice(H)
    return string


def update_distance():
    """
    在执行主算法前，对tbl_distance表进行更新。
    被webapp调用。

    具体步骤：
    1.查询tbl_place表，得到其中所有的pid集合s1。
    2.查询tbl_distance表，得到其中所有的pid集合s2。
    3.取差集：s3 = s1 - s2 、s4 = s2 - s1。取交集：s5 = s1 & s2
    4.删除tbl_distance表中pid属于s4的数据。
    5.计算s3与s5配对的距离。（百度批量算路api、备选的方案是calc_dist_with_factor函数）
    6.把步骤5的结果写入tbl_distance表。

    :return:  状态码  1: 无需更新  2:s1仅被删除了一些（s3为空）   3:s1仅被添加了一些（s4为空）   4: s1增删都有   5:操作失败
    """
    # 创建数据库连接
    db = pymysql.connect(host='localhost',
                         user='ABCDEFG',
                         password='ABCDEFG',
                         database='evrp')
    cursor = db.cursor()

    # step1
    s1 = set()
    try:
        cursor.execute("select pid from tbl_place")
        results = cursor.fetchall()
        for row in results:
            s1.add(row[0])
    except:
        print("查询tbl_place表失败")
        db.close()
        return 5

    # step2
    s2 = set()
    try:
        cursor.execute("select pfrom from tbl_distance group by pfrom")
        results = cursor.fetchall()
        for row in results:
            s2.add(row[0])
    except:
        print("查询tbl_distance表失败")
        db.close()
        return 5

    # step3
    if s1 == s2:
        print("s1 == s2。无需更新！")
        db.close()
        return 1
    s3 = s1 - s2
    s4 = s2 - s1
    s5 = s1 & s2
    DELETE = False
    INSERT = False

    # step4
    if s4:
        sql_str = ""
        for pids4 in s4:
            sql_str += "delete from tbl_distance where pfrom='" + pids4 + "' or " + "pto='" + pids4 + "';"
        try:
            print(sql_str)
            cursor.execute(sql_str)
            db.commit()
            DELETE = True
        except:
            print("删除tbl_distance表的数据失败")
            db.rollback()
            db.close()
            return 5

    # step5
    if s3:
        dist_res_li_1 = get_dist_from_2sets(s3, s5, cursor)
        dist_res_li_2 = get_dist_from_2sets(s5, s3, cursor)
        dist_res_li_3 = get_dist_from_2sets(s3, s3, cursor)
        dist_res_li = dist_res_li_1 + dist_res_li_2 + dist_res_li_3

        # step6:
        try:
            # 限制单条语句insert的记录数，最多100条记录。
            for i in range(0, len(dist_res_li), 100):
                insert_sql_str = "insert into tbl_distance values " + str(dist_res_li[i:i + 100])[1:-1]
                print(insert_sql_str)
                cursor.execute(insert_sql_str)
            db.commit()
            INSERT = True
        except:
            print("结果插入tbl_distance表失败")
            db.rollback()
            db.close()
            return 5
    db.close()
    if DELETE and INSERT:
        return 4
    elif DELETE:
        return 2
    else:
        return 3


def get_dist_from_2sets(sa, sb, cursor):
    """
    给两个pid集合。计算它们两两之间的距离。（sa是起点集合。sb是终点集合） 也可以sa=sb。
    首选方案是百度api，备选方案是calc_dist_with_factor函数。
    :param sa: 集合。{pida_1, pida_2, pida_3}
    :param sb: 集合。{pidb_1, pidb_2, pidb_3}
    :param cursor: 数据库游标
    :return:  元组列表。 [(pida_1, pidb_1, dist1, calc_type), (pida_1, pidb_2, dist1, calc_type),
     ......, (pidb_2, pida_2, dist1, calc_type)....]
    """
    # sa和sb都不能是空
    if not (sa and sb):
        return []
    sql_str_a = "select pid, lng, lat from tbl_place where pid in (" + str(sa)[1:-1] + ");"
    sql_str_b = "select pid, lng, lat from tbl_place where pid in (" + str(sb)[1:-1] + ");"
    try:
        cursor.execute(sql_str_a)
        sa_with_loc = cursor.fetchall()
        cursor.execute(sql_str_b)
        sb_with_loc = cursor.fetchall()
    except:
        print("查询tbl_distance表失败")
        return 5
    # sa_with_loc
    # (('ab123', 121.229424, 31.203304), ('e0001', 121.550189, 31.336811))
    # sb_with_loc
    # (('c0001', 121.205416, 31.055989), ('c0002', 121.463261, 31.262059), ('c0003', 121.551715, 31.212369))

    # 考虑一次百度api请求最多50个。7*7=49.因此把sa_with_loc和sb_with_loc都  分成最多7个一组。
    sa_whole_list = []
    sb_whole_list = []
    duan_a = (len(sa_with_loc) - 1) // 7 + 1
    duan_b = (len(sb_with_loc) - 1) // 7 + 1
    for i in range(duan_a):
        sa_whole_list.append(sa_with_loc[i * 7: (i + 1) * 7])
    for i in range(duan_b):
        sb_whole_list.append(sb_with_loc[i * 7: (i + 1) * 7])

    res_list = []
    for one_sa_list in sa_whole_list:
        for one_sb_list in sb_whole_list:
            res_list.extend(get_dist_from_baidu_route_matrix(one_sa_list, one_sb_list))
    return res_list


def get_dist_from_baidu_route_matrix(one_sa_list, one_sb_list):
    """
    :param one_sa_list = [('ab123', 121.229424, 31.203304), ('e0001', 121.550189, 31.336811), ...]  最长为7
    :param one_sb_list 同理
    :return:  元组列表。 [(pida_1, pidb_1, dist1, calc_type), (pida_1, pidb_2, dist1, calc_type),  .....]
    """
    url = "https://api.map.baidu.com/routematrix/v2/driving"
    ak = "m2IpGFAAGfxmOtcQoPsOzajdKfVOvGa1"
    time_sleep = 0.5
    retry_time = 3
    time_out = 2
    factor = 1.3
    ori_list = [str(tp[2]) + "," + str(tp[1]) for tp in one_sa_list]
    des_list = [str(tp[2]) + "," + str(tp[1]) for tp in one_sb_list]
    origins = "|".join(ori_list)
    destinations = "|".join(des_list)

    # https://api.map.baidu.com/routematrix/v2/driving?origins=39.915,116.404|39.915,116.414&destinations=39.885,116.404|39.885,116.414&ak=m2IpGFAAGfxmOtcQoPsOzajdKfVOvGa1
    req_params = {
        'ak': ak,
        'origins': origins,
        'destinations': destinations,
    }
    value_list = [0] * len(one_sa_list) * len(one_sb_list)
    for i in range(retry_time):
        if i > 0:
            print("retry...")
        try:
            data_str = rq.get(url, params=req_params, timeout=time_out).text
            time.sleep(time_sleep)
            data_jsn = json.loads(data_str)
            if data_jsn["status"] == 0:
                data_list = data_jsn["result"]
                for j in range(len(data_list)):
                    value = data_list[j]["distance"]["value"]
                    value_list[j] = value
                break
            else:
                print("message:", data_jsn["message"])
                print("status:", data_jsn["status"])
        except Exception:
            print("time out error...")

    res_list = []
    count = 0
    for sa in one_sa_list:
        for sb in one_sb_list:
            # 起点终点不能相同
            if sa[0] == sb[0]:
                count += 1
                continue
            # value如果是0，需要使用备选方案计算
            if value_list[count] == 0:
                value_list[count] = calc_dist_with_factor(sa[2], sa[1], sb[2], sb[1], factor)
                res_list.append((sa[0], sb[0], value_list[count], factor))
            else:
                res_list.append((sa[0], sb[0], value_list[count], -1))
            count += 1
    return res_list


def get_places_info_from_db():
    """
    查询数据库，得到距离矩阵。
    :return: 结果字典
    如果查询数据库失败，则返回空字典，
    否则字典的信息包括：所有节点的id列表（按“配、客、充”的次序）、客户点数量、额外充电站数量、距离矩阵、客户点具体信息
    """
    db = pymysql.connect(host='localhost',
                         user='ABCDEFG',
                         password='ABCDEFG',
                         database='evrp')
    cursor = db.cursor()
    try:
        cursor.execute("select pid,ptype from tbl_place order by ptype,pid;")
        place_results = cursor.fetchall()
        cursor.execute("select pfrom,pto,dist from tbl_distance;")
        dist_results = cursor.fetchall()
        cursor.execute("select pid,demand,atime,pen from tbl_customer;")
        customer_results = cursor.fetchall()
    except:
        print("全表查询tbl_distance失败！")
        db.close()
        return {}

    db.close()
    place_list = [item[0] for item in place_results]
    place_num = len(place_list)
    ptype_list = [item[1] for item in place_results]
    customer_num = ptype_list.count(2)
    charging_num = ptype_list.count(3)
    dist_matrix = np.zeros([place_num, place_num], dtype=int)
    for res in dist_results:
        # res = ('e0005', 'e0004', 12888)
        index_pfrom = place_list.index(res[0])
        index_pto = place_list.index(res[1])
        dist_matrix[index_pfrom][index_pto] = res[2]

    customer_info_list = [[]] * customer_num
    for cust in customer_results:
        # cust = ('c0005', 173, "11:53", 0.001)
        idx = place_list.index(cust[0])
        customer_info_list[idx - 1] = list(cust)
    # customer_info_list = [['c0001', 173, '11:53', 0.001],['c0002', 95, '10:45', 0.001], .....]

    res_dict = {}
    res_dict["place_list"] = place_list
    res_dict["customer_num"] = customer_num
    res_dict["charging_num"] = charging_num
    res_dict["dist_matrix"] = dist_matrix
    res_dict["customer_info_list"] = customer_info_list
    return res_dict


def get_nearest_cs_list(nn, mm, dist_matrix):
    """
    找各个点最近的充电站
    :param nn: 客户点数量
    :param mm: 充电站数量（不包括配送中心）
    :param dist_matrix: 距离矩阵
    :return: np一维数组   near_list
    near_list[i] 表示与i最近的充电站编号。
    若i=j，自己到自己一定不需要插入，结果不考虑。
    """
    place_num = nn + mm + 1
    res = np.zeros([place_num], dtype=int)
    for i in range(place_num):
        minv = 999_999_999
        minIdx = 0
        for j in range(place_num):
            # 注意：还要排除自身
            if 1 <= j <= nn or j == i:
                continue
            if dist_matrix[i][j] < minv:
                minv = dist_matrix[i][j]
                minIdx = j
        res[i] = minIdx
    return res


def get_insert_matrix(nn, mm, dist_matrix):
    """
    弧段间最佳的充电站插入方案
    :param nn: 客户点数量
    :param mm: 充电站数量（不包括配送中心）
    :param dist_matrix: 电动车距离矩阵
    :return: 同等大小的矩阵   arc_cs_matrix[i][j]
    arc_cs_matrix[i][j] 表示 i 和 j 的插入充电站编号。编号从nn+1到nn+mm，再加上0。
    若i=j，自己到自己一定不需要插入，为-1。
    """
    place_num = nn + mm + 1
    res = np.zeros([place_num, place_num], dtype=int)
    for i in range(place_num):
        for j in range(place_num):
            if i == j:
                res[i][j] = -1
            else:
                # 计算方式： 列出： i到各个充电站、各个充电站到i的距离，对求和结果进行   排列比较
                minsum = 999_999_999
                minsumIdx = 0
                for k in range(place_num):
                    # 非充电站则不计算。另外注意：还要排除自身
                    if 1 <= k <= nn or k == i or k == j:
                        continue
                    sum = dist_matrix[i][k] + dist_matrix[k][j]
                    if sum < minsum:
                        minsum = sum
                        minsumIdx = k
                res[i][j] = minsumIdx
    return res


def time_2_int(thisTime, baseTime):
    """
    计算某一个'h:mm'的时间，与基准时间相差的秒数。
    如：9:20  与  8:00    相差： 1*3600 + 20*60 秒
    :param thisTime:  要计算的时间点
    :param baseTime:  实际使用默认是8:00
    :return: 单位：秒
    """
    li1 = thisTime.split(":")
    li2 = baseTime.split(":")
    return (int(li1[0]) - int(li2[0])) * 3600 + (int(li1[1]) - int(li2[1])) * 60


def show_time_str(scd_time):
    """
    输出字符串。
    :param scd_time: int 单位秒
    :return:  转换为x小时y分
    """
    hour = scd_time // 3600
    minute = (scd_time % 3600) // 60
    return "%d小时%d分" % (hour, minute)


def calc_sum_dis_from_cir(dist_matrix, cir):
    """
    用于测试时，计算累计路程
    :param cir: [0,1,2,6,3,0]
    :return:  int
    """
    arcnum = len(cir) - 1
    sum_dist = 0
    for i in range(arcnum):
        sum_dist += dist_matrix[cir[i]][cir[i + 1]]
    return sum_dist


def execute_alg(post_params_dict):
    """
    :param post_params_dict: 从flask接收的post请求的各参数，封装成一个字典传进来
    :return: 结果字典。例如：
        # {'chrome_len': 6,
        #  'alg_id': 36,
        #  'exec_time': 0.157,
        #  'feasible_count': 720,
        #  'hit_cache_time': 875,
        #  'hit_cache_rate': 72.92,
        #  'best_objv': 386.77,
        #  'best_chrome': [5, 2, 4, 3, 1, 6],
        #  'cir2_list': [[0, 5, 2, 4, 3, 1, 0]],
        #  'solution_list':[['ab123', 'c0005', 'c0002', 'c0004', 'c0003', 'c0001', 'ab123']]
        #  'use_car_num': 1,
        #  'whole_time': 20838,
        #  'rent': 300,
        #  'electricity': 58.74,
        #  'time_pen': 28.03}
    """
    # post_params_dict = {
    #     "total_num": "2",
    #     "max_cap": "1315",
    #     "speed": "30",
    #     "max_dist": "150",
    #     "e_per_dist": "0.6",
    #     "v_charging": "1.2",
    #     "load_time": "60",
    #     "unload_time": "10",
    #     "rent": "300",
    #     "price_per_e": "0.825",
    #     "start_time": "8:00",
    #     "NIND": "500",
    #     "MAXGEN": "100",
    #     "Pm": "0.1",
    # }

    places_info_dict = get_places_info_from_db()
    ev = EV(post_params_dict)
    general = General(post_params_dict)
    places = Places(places_info_dict, post_params_dict)

    # 创建CAI算法的problem问题对象
    problem = CaiWithCache(ev, general, places)
    # 结果保存在一个字典中
    result_dict = {}
    # 若染色体长度较小，则使用枚举法；否则使用遗传算法
    # 遗传是32，枚举是36
    result_dict["chrome_len"] = problem.chrome_len
    if problem.chrome_len <= 6:
        alg_id = 36
        result_dict["alg_id"] = alg_id
    else:
        alg_id = 32
        result_dict["alg_id"] = alg_id

    # 使用遗传算法的情况
    if alg_id == 32:
        """==================================种群设置=============================="""
        # 编码方式，采用排列编码
        Encoding = 'P'
        # 种群规模
        NIND = int(post_params_dict.get('NIND'))
        # 创建区域描述器
        Field = ea.crtfld(Encoding, problem.varTypes, problem.ranges, problem.borders)
        # 实例化种群对象（此时种群还没被初始化，仅仅是完成种群对象的实例化）
        population = ea.Population(Encoding, Field, NIND)

        """================================算法参数设置============================="""
        # 实例化一个算法模板对象
        # SGA：普通    EGA：精英保留    SEGA：增强精英保留（需要交叉变异概率较大）
        myAlgorithm = ea.soea_SEGA_templet(problem, population)
        # 最大进化代数
        myAlgorithm.MAXGEN = int(post_params_dict.get('MAXGEN'))
        # 变异概率
        myAlgorithm.mutOper.Pm = float(post_params_dict.get('Pm'))
        # 设置每隔多少代记录日志，若设置成0则表示不记录日志
        myAlgorithm.logTras = 0
        # 设置是否打印输出日志信息
        myAlgorithm.verbose = False
        # 设置绘图方式（0：不绘图；1：绘制结果图；2：绘制目标空间过程动画；3：绘制决策空间过程动画）
        myAlgorithm.drawing = 0

        """===========================调用算法模板进行种群进化========================"""
        # 执行算法模板，得到最优个体以及最后一代种群
        [BestIndi, population] = myAlgorithm.run()

        # 算法执行耗时（秒）
        result_dict["exec_time"] = round(myAlgorithm.passTime, 3)
        result_dict["feasible_count"] = -1

        # 缓存命中次数
        result_dict["hit_cache_time"] = problem.hit_count
        # 缓存命中率
        result_dict["hit_cache_rate"] = round((100 * problem.hit_count / (problem.hit_count + problem.not_hit_count)),
                                              2)

        # 找到了可行解
        if BestIndi.sizes != 0:
            result_dict["best_objv"] = round(BestIndi.ObjV[0][0], 2)
            # 最优解染色体
            best_journey = BestIndi.Phen[0, :]
            result_dict["best_chrome"] = best_journey
            components_dict = problem.get_objv_components(best_journey)
            result_dict["cir2_list"] = components_dict["cir2_list"]
            result_dict["use_car_num"] = components_dict["use_car_num"]
            result_dict["whole_time"] = components_dict["whole_time"]
            result_dict["rent"] = components_dict["rent"]
            result_dict["electricity"] = components_dict["electricity"]
            result_dict["time_pen"] = components_dict["time_pen"]

        # 未找到可行解
        else:
            result_dict["best_chrome"] = []
            result_dict["cir2_list"] = []
            result_dict["best_objv"] = 9999_9999
            result_dict["use_car_num"] = -1
            result_dict["whole_time"] = 9999_9999
            result_dict["rent"] = 9999_9999
            result_dict["electricity"] = 9999_9999
            result_dict["time_pen"] = 9999_9999

    # 使用全排列的情况
    else:
        t1 = time.time()
        # 最优解目标值、最优解染色体
        minobjv, best_journey, feasible_count = problem.permute_solve(verbose=False)
        t2 = time.time()
        # 执行时间（秒） % (t2 - t1))
        result_dict["exec_time"] = round(t2 - t1, 3)
        # 有多少条可行解
        result_dict["feasible_count"] = feasible_count

        # 缓存命中次数
        result_dict["hit_cache_time"] = problem.hit_count
        # 缓存命中率
        result_dict["hit_cache_rate"] = round((100 * problem.hit_count / (problem.hit_count + problem.not_hit_count)),
                                              2)

        # 未找到可行解
        if minobjv == 9999_9999:
            result_dict["best_chrome"] = []
            result_dict["cir2_list"] = []
            result_dict["best_objv"] = 9999_9999
            result_dict["use_car_num"] = -1
            result_dict["whole_time"] = 9999_9999
            result_dict["rent"] = 9999_9999
            result_dict["electricity"] = 9999_9999
            result_dict["time_pen"] = 9999_9999
        # 找到可行解
        else:
            result_dict["best_objv"] = round(minobjv, 2)
            # 最优解染色体
            components_dict = problem.get_objv_components(best_journey)
            result_dict["best_chrome"] = best_journey
            result_dict["cir2_list"] = components_dict["cir2_list"]
            result_dict["use_car_num"] = components_dict["use_car_num"]
            result_dict["whole_time"] = components_dict["whole_time"]
            result_dict["rent"] = components_dict["rent"]
            result_dict["electricity"] = components_dict["electricity"]
            result_dict["time_pen"] = components_dict["time_pen"]

    # 解码二级回路为pid的编号。
    solu_list = []
    if result_dict["cir2_list"]:
        cir2_list = result_dict["cir2_list"]
        for cir2 in cir2_list:
            solu = []
            for idx in cir2:
                solu.append(places_info_dict["place_list"][idx])
            solu_list.append(solu)
    result_dict["solution_list"] = solu_list
    # 返回结果
    return result_dict


def save_rout_2_db(alg_result_dict, speed):
    """
    把rout结果写入tbl_rout表
    :param alg_result_dict: 字典
    :param speed: 车速：float 米/秒
    :return: none
    """
    db = pymysql.connect(host='localhost',
                         user='ABCDEFG',
                         password='ABCDEFG',
                         database='evrp')
    cursor = db.cursor()

    # 如果没有得到可行解
    ucn = alg_result_dict.get("use_car_num", -1)
    if ucn == -1:
        print("没有得到可行解")
        try:
            # 重置自增主键：alter table tbl_rout auto_increment=1
            cursor.execute("insert into tbl_rout (gtime, get_result) values (now(), 0);")
            db.commit()
        except:
            print("写入tbl_rout失败！")
            db.close()
            return
    # 如果得到了可行解
    else:
        # 例如：
        # {'chrome_len': 6,
        #  'alg_id': 36,
        #  'exec_time': 0.157,
        #  'feasible_count': 720,
        #  'hit_cache_time': 875,
        #  'hit_cache_rate': 72.92,
        #  'best_objv': 386.77,
        #  'best_chrome': [5, 2, 4, 3, 1, 6],
        #  'cir2_list': [[0, 5, 2, 4, 3, 1, 0]],
        #  'solution_list':[['ab123', 'c0005', 'c0002', 'c0004', 'c0003', 'c0001', 'ab123']]
        #  'use_car_num': 1,
        #  'whole_time': 20838,
        #  'rent': 300,
        #  'electricity': 58.74,
        #  'time_pen': 28.03}
        sql_str = "insert into tbl_rout " \
                  "(gtime, get_result, chrome_len, alg, exec_time," \
                  "hit_cache_time, hit_cache_rate, best_objv, use_car_num," \
                  "rent, electricity, time_pen, best_chrome, cir2_list," \
                  "solution_list, show_info_text) " \
                  "values (now(), 1"
        sql_str += ", " + str(alg_result_dict.get("chrome_len"))
        alg_id = alg_result_dict.get("alg_id")
        if alg_id == 36:
            sql_str += ", " + "'枚举算法'"
        else:
            sql_str += ", " + "'遗传算法'"
        sql_str += ", " + str(alg_result_dict.get("exec_time"))
        sql_str += ", " + str(alg_result_dict.get("hit_cache_time"))
        sql_str += ", " + str(alg_result_dict.get("hit_cache_rate"))
        sql_str += ", '" + str(alg_result_dict.get("best_objv")) + "'"
        sql_str += ", " + str(alg_result_dict.get("use_car_num"))
        sql_str += ", '" + str(alg_result_dict.get("rent")) + "'"
        sql_str += ", '" + str(alg_result_dict.get("electricity")) + "'"
        sql_str += ", '" + str(alg_result_dict.get("time_pen")) + "'"

        sql_str += ", '" + str(list(alg_result_dict.get("best_chrome"))) + "'"
        sql_str += ", '" + str(alg_result_dict.get("cir2_list")) + "'"
        sql_str += ", '" + str(alg_result_dict.get("solution_list")).replace("'", "\\'") + "'"

        # 车辆路径信息
        # 1.查询得到pid与location_zh和info_detail的对应哈希表
        pidmap = {}
        try:
            cursor.execute("select pid, location_zh, info_detail from tbl_customer")
            res1 = cursor.fetchall()
            for res in res1:
                pidmap[res[0]] = res[1:]
            cursor.execute("select pid, location_zh, info_detail from tbl_charging_station")
            res2 = cursor.fetchall()
            for res in res2:
                pidmap[res[0]] = res[1:]
        except:
            print("查询数据库tbl_customer和tbl_charging_station出错")

        # 2.查询距离信息
        solution_list = alg_result_dict.get("solution_list")
        info_list = []
        for solution in solution_list:
            cir_len = len(solution) - 1
            info_list_01 = []
            for i in range(cir_len):
                info_list_i = [solution[i], solution[i+1]]
                # info_list_i = [add_type(solution[i]), add_type(solution[i+1])]
                dist_sql = "select dist from tbl_distance where pfrom='"\
                           + solution[i] + "' and pto='" + solution[i+1] + "';"
                try:
                    cursor.execute(dist_sql)
                    res = cursor.fetchone()
                    info_list_i.append(str(res[0]))
                    info_list_i.append(str(round(res[0] / speed / 60)))
                except:
                    info_list_i.append("/")
                    info_list_i.append("/")
                info_list_01.append(info_list_i)
            info_list.append(info_list_01)
        info_str = ""
        for i in range(len(info_list)):
            info_list_01 = info_list[i]
            info_str += "***车辆" + str(i+1) + "："
            for j in range(len(info_list_01)):
                info_list_j = info_list_01[j]
                pfrom_tuple = pidmap.get(info_list_j[0], tuple(["", ""]))
                pfrom_str = pfrom_tuple[1] + "（" + pfrom_tuple[0] + "）"
                pto_tuple = pidmap.get(info_list_j[1], ("", ""))
                pto_str = pto_tuple[1] + "（" + pto_tuple[0] + "）"

                info_str += "$$${}) 从{}出发，行驶{}米，到{}，历时{}分钟。" \
                            .format(j+1, pfrom_str, info_list_j[2], pto_str, info_list_j[3])

        sql_str += ", '" + info_str + "');"
        try:
            print("将路径结果写入数据库SQL：")
            print(sql_str)
            cursor.execute(sql_str)
            db.commit()
        except:
            print("写入tbl_rout失败！")
            db.close()


def add_type(pid):
    if pid[0] == "a":
        return "配送中心" + pid
    elif pid[0] == "c":
        return "客户点" + pid
    elif pid[0] == "e":
        return "充电站" + pid
    else:
        return pid

# ======================类=========================

class General:
    """
    全局参数
    """

    def __init__(self, post_params_dict):
        self.price_per_e = float(post_params_dict.get('price_per_e'))  # 工业电费（元/千瓦时）
        self.start_time = post_params_dict.get('start_time')  # 配送中心出发时间


class EV:
    """
    电动车相关的参数
    """

    def __init__(self, post_params_dict):
        self.total_num = int(post_params_dict.get('total_num'))  # 电动车数量
        self.max_cap = int(post_params_dict.get('max_cap'))  # 最大载重（千克）
        self.speed = int(post_params_dict.get('speed')) / 3.6  # 平均行车速度（米/秒）                   float
        self.max_dist = int(float(post_params_dict.get('max_dist'))) * 1000  # 最大行驶里程（米）
        self.e_per_dist = float(post_params_dict.get('e_per_dist')) / 1000  # 单位里程耗电量（千瓦时/米）    float
        self.v_charging = float(post_params_dict.get('v_charging')) / 60  # 充电速度（千瓦时/秒）       float
        self.load_time = int(post_params_dict.get('load_time')) * 60  # 装货时间（秒）
        self.unload_time = int(post_params_dict.get('unload_time')) * 60  # 卸货时间（秒）
        self.rent = int(post_params_dict.get('rent'))  # 日租费用（元）

        self.e_total = self.e_per_dist * self.max_dist  # 电池容量（千瓦时） 由前面数据计算可得（实际中不建议使用）


class Places:
    """
    地点类
    功能：加载各种点的数据，并计算距离矩阵
    """

    def __init__(self, places_info_dict, post_params_dict):
        # 客户点有consumer_num个
        self.customer_num = places_info_dict.get("customer_num")
        customer_info_list = places_info_dict.get("customer_info_list")
        # customer_info_list = [['c0001', 173, '11:53', 0.001],['c0002', 95, '10:45', 0.001], .....]
        self.customer_demand = np.array([item[1] for item in customer_info_list]).astype(np.int64)
        self.customer_time = np.array(
            [time_2_int(item[2], post_params_dict.get("start_time")) for item in customer_info_list]
        ).astype(np.int64)
        self.customer_pen = np.array([item[3] / 60 for item in customer_info_list]).astype(np.float64)

        # 充电站有charging_station_num个（除配送中心外）
        self.charging_station_num = places_info_dict.get("charging_num")

        # 距离矩阵
        self.dist_matrix = places_info_dict.get("dist_matrix")

        nn = self.customer_num
        mm = self.charging_station_num

        # 最近邻列表
        self.nearest_cs_list = get_nearest_cs_list(nn, mm, self.dist_matrix)
        # 插入弧段矩阵
        # arc_cs_matrix[i][j] 表示 i 和 j 的插入充电站编号。编号从nn+1到nn+mm，再加上0
        self.arc_cs_matrix = get_insert_matrix(nn, mm, self.dist_matrix)


class CaiWithCache(ea.Problem):
    # 在web项目中，一定开启缓存。故不需要使用use_cache参数
    def __init__(self, ev, general, places):
        self.ev = ev
        self.general = general
        self.places = places
        self.cache = {}
        self.hit_count = 0
        self.not_hit_count = 0

        # 最关键的几个变量
        self.nn = self.places.customer_num
        self.mm = self.places.charging_station_num
        self.kk = self.ev.total_num

        # 为方便计算，先定义几个bound值：
        self.bound1 = self.nn
        self.bound2 = self.bound1 + self.kk - 1
        self.chrome_len = self.bound2

        # 算法名称
        name = 'EVRP_alg03'
        # 初始化M（目标维数）
        M = 1
        # 初始化maxormins  （目标最小最大化标记列表，1：最小化该目标；-1：最大化该目标）
        maxormins = [1]
        # 初始化Dim        （决策变量维数）
        Dim = self.chrome_len
        # 初始化varTypes   （决策变量的类型，元素为0表示对应的变量是连续的；1表示是离散的）
        varTypes = [1] * Dim

        # 上下边界及是否包含
        lb = [1] * Dim  # 决策变量下界
        ub = [Dim] * Dim  # 决策变量上界
        lbin = [1] * Dim  # 决策变量下边界（0表示不包含该变量的下边界，1表示包含）
        ubin = [1] * Dim  # 决策变量上边界（0表示不包含该变量的上边界，1表示包含）

        # 调用父类构造方法完成实例化
        ea.Problem.__init__(self, name, M, maxormins, Dim, varTypes, lb, ub, lbin, ubin)

    def aimFunc(self, pop):
        """
        目标函数
        """

        # 得到决策变量矩阵
        x = pop.Phen
        # 种群规模（染色体数量）
        nind = x.shape[0]
        # 把求得的目标函数值赋值给种群pop的ObjV，这里先初始化，下一步填值
        pop.ObjV = np.zeros((nind, 1))
        # 计算每一个染色体的目标值
        for i in range(nind):
            pop.ObjV[i][0] = self.get_objv_from_single_chrome(x[i])

        # 把求得的违反约束程度矩阵赋值给种群pop的CV
        pop.CV = np.where(pop.ObjV == 9999_9999, 1, 0)

        # 统计缓存使用情况
        # print("缓存键值对数量：%d 个" % self.cache.__len__())
        print("缓存命中率 %.2f %%" % (100 * self.hit_count / (self.hit_count + self.not_hit_count)), end="\t")

        print("本次迭代违反规则的个体数量：%d" % len(np.where(pop.CV == 1)[0]))

    def get_objv_from_single_chrome(self, arr):
        """
        根据单条染色体的决策变量，计算目标函数值。
        :param arr:   例如 np.array([6, 1, 2, 5, 3, 4])
        :return:  目标函数值sumobjv。若为不可行解，返回9999_9999
        """

        # 把染色体分解为回路列表
        cir1_list = self.get_cir1_list_from_single_chrome(arr)

        # 目标函数（总成本）
        sumobjv = 0

        # 遍历各条回路，累加objv值
        for cir1 in cir1_list:
            # 使用缓存的情况：
            objv = self.cache.get(tuple(cir1))
            # 命中缓存
            if objv:
                self.hit_count += 1
            # 未命中缓存
            else:
                self.not_hit_count += 1
                objv = self.get_cir1_objv(cir1, put2cache=True)
            if objv == -1:
                return 9999_9999
            else:
                sumobjv += objv

        return round(sumobjv, 2)

    def get_cir1_list_from_single_chrome(self, arr):
        """
        根据bound值分割为各个cir1，分别放在cir1_list列表里
        并且筛除空回路
        :param arr:
        :return:
        """
        cir1_list = []
        # 使用指针
        pt = -1
        pt_edge = self.bound2 - 1

        while pt < pt_edge:
            # 排除空路径
            while pt < pt_edge and arr[pt + 1] > self.bound1:
                pt += 1

            # 空列表，用来放路径
            cir1 = []
            while pt < pt_edge and arr[pt + 1] <= self.bound1:
                nextPlace = arr[pt + 1]
                cir1.append(nextPlace)
                pt += 1
            if len(cir1) != 0:
                cir1.append(0)
                cir1.insert(0, 0)
                cir1_list.append(cir1)

        return cir1_list

    def get_cir1_objv(self, cir1, put2cache, save_best_cir_group=False):
        """
        输入1级回路，返回objv，可放入缓存。
        :param cir1:
        :param put2cache: 是否放入缓存（若要放入缓存的话，则肯定不需要再保存回路了）
        :param save_best_cir_group:  是否返回最终的插入方案列表（默认为否）
        :return:
        """
        # 得到2级回路组
        cir2_list = self.get_cir2_list_from_cir1(cir1)

        # 需要放入缓存
        if put2cache:
            key = tuple(cir1)
            if not cir2_list:
                self.cache[key] = -1
                return -1
            else:
                minobjv = 9999_9999
                for cir2 in cir2_list:
                    objv = self.get_cir2_objv(cir2)
                    if objv != -1 and objv < minobjv:
                        minobjv = objv
                if minobjv == 9999_9999:
                    self.cache[key] = -1
                    return -1
                else:
                    self.cache[key] = minobjv
                    return minobjv

        # 不需要放入缓存
        else:
            # 保存回路
            if save_best_cir_group:
                if not cir2_list:
                    return -1, []
                else:
                    minobjv = 9999_9999
                    best_cir_group = []
                    for cir2 in cir2_list:
                        objv = self.get_cir2_objv(cir2)
                        if objv != -1 and objv < minobjv:
                            minobjv = objv
                            best_cir_group = cir2
                    if minobjv == 9999_9999:
                        return -1, []
                    else:
                        return minobjv, best_cir_group
            # 不保存回路
            else:
                if not cir2_list:
                    return -1
                else:
                    minobjv = 9999_9999
                    for cir2 in cir2_list:
                        objv = self.get_cir2_objv(cir2)
                        if objv != -1 and objv < minobjv:
                            minobjv = objv
                    if minobjv == 9999_9999:
                        return -1
                    else:
                        return minobjv

    def get_cir2_list_from_cir1(self, cir1):
        """
        输入一个 1级回路，返回一个 2级回路组（嵌套型列表）
        # 如果没有可行的，就是空列表[]
        # 如果本身就可行，就是单元素列表[cir1]
        # 如果本身不可行，就是各种情况了cir2_list = [pos_cir2_01, pos_cir2_02, pos_cir2_03, ...]
        :param cir1:
        :return: cir2_list = [[...], [...], ...]
        """
        ori_arcnum = len(cir1) - 1
        # 计算累计货物量
        sum_cap = 0
        for i in range(1, ori_arcnum):
            sum_cap += self.places.customer_demand[cir1[i] - 1]
            # 已经超过最大载重量，则必为不可行解
            if sum_cap > self.ev.max_cap:
                return []

        # 判断是否需要加入充电站
        # 回路总距离
        cir1_dist = calc_sum_dis_from_cir(self.places.dist_matrix, cir1)
        # 不需要充电：
        if self.ev.max_dist >= cir1_dist:
            # 则2级回路组为单元素列表[cir1]
            return [cir1]
        # 需要充电：
        else:
            cir2_list = []
            cir2_tmp = cir1.copy()
            dist_lt = 0
            dist_rt = cir1_dist

            for i in range(0, ori_arcnum):
                # 当前点
                pfrom = cir1[i]
                # 下一个点
                pto = cir1[i + 1]
                # 两点间的距离
                dist_pp = self.places.dist_matrix[pfrom][pto]

                dist_rt -= dist_pp
                nearest_cs_pfrom = self.places.nearest_cs_list[pfrom]
                nearest_cs_pto = self.places.nearest_cs_list[pto]
                arc_cs = self.places.arc_cs_matrix[pfrom][pto]

                # 有三种情况。最近的两种、弧段和最小
                insert_cs_set = set()
                # 1.离pfrom最近的
                if dist_lt + self.places.dist_matrix[pfrom][nearest_cs_pfrom] <= self.ev.max_dist \
                        and dist_rt + self.places.dist_matrix[nearest_cs_pfrom][pto] <= self.ev.max_dist:
                    insert_cs_set.add(nearest_cs_pfrom)
                # 2.离pto最近的
                if dist_lt + self.places.dist_matrix[pfrom][nearest_cs_pto] <= self.ev.max_dist \
                        and dist_rt + self.places.dist_matrix[nearest_cs_pto][pto] <= self.ev.max_dist:
                    insert_cs_set.add(nearest_cs_pto)
                # 3.弧段最短的
                if dist_lt + self.places.dist_matrix[pfrom][arc_cs] <= self.ev.max_dist \
                        and dist_rt + self.places.dist_matrix[arc_cs][pto] <= self.ev.max_dist:
                    insert_cs_set.add(arc_cs)

                for insert_cs in insert_cs_set:
                    cir2_tmp.insert(i + 1, insert_cs)
                    cir2_list.append(cir2_tmp.copy())
                    cir2_tmp.pop(i + 1)

                dist_lt += dist_pp

            return cir2_list

    def get_cir2_objv(self, cir2, verbose=False, return_components=False):
        """
        输入一个2级回路，计算它的objv值。
        ！这里是方案3。但与方案2的同名函数代码是相同的。

        :param    verbose: 显示详细成本（最后输出求解结果时用）
        :param    cir2:  list类型  例如[0, 1, 2, 5, 0]   此时的cir2已经是插入充电站的了
        :return:   若是不可行解，则返回-1，否则返回这条路径的成本值
        """

        # 若cir2是空列表，则是不可行解。（或不可达，或是货物量约束不符合条件）
        if not cir2:
            if return_components:
                return -1, -1, -1, -1
            return -1

        # 累计耗电里程
        accum_e_dist = 0
        # 电费
        accum_e_money = 0
        # 累计罚金
        accum_time_pen_money = 0
        # 上一个点的离开时刻
        last_departure_time = self.ev.load_time

        # 回路的弧段数
        arcnum = len(cir2) - 1
        for i in range(arcnum):
            pfrom = cir2[i]
            pto = cir2[i + 1]
            dist = self.places.dist_matrix[pfrom][pto]
            # 累计耗电里程
            accum_e_dist += dist
            # 行驶时间（取整）
            last_departure_time += round(dist / self.ev.speed)

            # 若pto为客户点（编号为0的也是充电站）
            if 0 < pto <= self.bound1:
                # pto的需求重量（注意这里索引号需要减1，因为需求列表是从0开始的）
                pto_cap = self.places.customer_demand[pto - 1]
                # 卸货时间
                last_departure_time += self.ev.unload_time
                # 惩罚时间成本（保留两位小数）
                overtime = last_departure_time - self.places.customer_time[pto - 1]
                if overtime > 0:
                    accum_time_pen_money += round(overtime * self.places.customer_pen[pto - 1] * pto_cap, 2)

            # 若为充电站（终点也可视为充电站，因为最后一定要充满电）
            else:
                # 需要充的电量（千瓦时）
                e_to_charge = accum_e_dist * self.ev.e_per_dist
                # 电费
                accum_e_money += round(e_to_charge * self.general.price_per_e, 2)
                # 补足电量
                accum_e_dist = 0
                # 最后到达不需要再加时间了。其它情况需要加上充电时间，取整。
                if i != arcnum - 1:
                    last_departure_time += round(e_to_charge / self.ev.v_charging)

        # 费用三部分：日租金+时间惩罚成本+电费
        # 显示三项成本的详细信息：
        if verbose:
            print("2级回路：", cir2)
            print("租金： %.2f" % self.ev.rent)
            print("电费： %.2f" % accum_e_money)
            print("超时罚金： %.2f" % accum_time_pen_money)
            print("从开始装货到回到配送站用时： %d秒" % last_departure_time)
            print("即" + show_time_str(last_departure_time))
        if return_components:
            return last_departure_time, self.ev.rent, accum_e_money, accum_time_pen_money
        return round(self.ev.rent + accum_time_pen_money + accum_e_money, 2)

    def show_final_ans(self, arr):
        """
        最终结果输出：把结果染色体（一条）解算成答案。
        :param arr:
        :return:
        """

        cir1_list = self.get_cir1_list_from_single_chrome(arr)
        cir2_list = []

        sumobjv = 0
        car_i = 0
        print("染色体：\n", arr)
        for cir1 in cir1_list:
            # 打印详细信息
            print("===================================================")
            car_i += 1
            print("车辆%d：" % car_i)
            print(cir1)

            # 得到目标值和对应的最佳充电方案
            objv, best_cir2 = self.get_cir1_objv(cir1, put2cache=False, save_best_cir_group=True)
            # 若是不可行解
            if objv == -1:
                raise Exception("不可行解：回路不可达")

            cir2_list.append(best_cir2)
            # 展示详细信息
            self.get_cir2_objv(best_cir2, verbose=True)
            sumobjv += objv

        print("<<<<<<<<<<<<<<<<<<<              >>>>>>>>>>>>>>>>>>>>")
        sumobjv = round(sumobjv, 2)
        print("全局总成本：%.2f" % sumobjv)

    def get_objv_components(self, arr):
        """
        通过染色体，求得结果成本的细节数据（使用车辆数、总用时、租金、电费、罚时费用）
        代码思路参考show_final_ans函数
        :param arr:
        :return: res_dict {"use_car_num"   "whole_time"   "rent"   "electricity"   "time_pen"}
        """
        res_dict = {"use_car_num": -1,
                    "whole_time": 9999_9999,
                    "rent": 9999_9999,
                    "electricity": 9999_9999,
                    "time_pen": 9999_9999,
                    "cir2_list": []}

        cir1_list = self.get_cir1_list_from_single_chrome(arr)
        cir2_list = []

        max_cir_time = 0
        sumrent = 0
        sume = 0
        sumpen = 0

        for cir1 in cir1_list:
            objv, best_cir2 = self.get_cir1_objv(cir1, put2cache=False, save_best_cir_group=True)
            if objv == -1:
                return res_dict
            cir2_list.append(best_cir2)
            cir2_time, cir2_rent, cir2_e, cir2_pen = self.get_cir2_objv(best_cir2, return_components=True)
            sumrent += cir2_rent
            sume += cir2_e
            sumpen += cir2_pen
            max_cir_time = max(max_cir_time, cir2_time)

        res_dict["use_car_num"] = len(cir1_list)
        res_dict["whole_time"] = max_cir_time
        res_dict["rent"] = sumrent
        res_dict["electricity"] = round(sume, 2)
        res_dict["time_pen"] = round(sumpen, 2)
        res_dict["cir2_list"] = cir2_list
        return res_dict

    def permute_solve(self, verbose=True):
        """
        使用枚举法求解。全排列遍历。
        :return: resList, minobjv   最优解染色体列表, 最小值
        """
        permuter = Permuter(self, verbose)
        permuter.doPerm()
        return permuter.minobjv, permuter.best_journey, permuter.counter_feasible


class Permuter:
    """
    枚举所有情况（全排列）的类
    """

    def __init__(self, problem, verbose):
        # 默认打开verbose，每隔10万次枚举则打印一次日志。
        self.verbose = verbose
        self.problem = problem
        self.length = problem.chrome_len
        self.perm_tmp_list = list(range(1, self.length + 1))
        self.best_journey = self.perm_tmp_list
        self.minobjv = 9999_9999
        self.counter = 0
        self.counter_feasible = 0

    def doPerm(self):
        """
        执行全排列操作。
        """
        while True:
            self.calc_compare()
            i = self.length - 2
            while i >= 0 and self.perm_tmp_list[i] > self.perm_tmp_list[i + 1]:
                i -= 1
            if i < 0:
                print("共枚举了 %d 条染色体" % self.counter)
                break
            j = self.length - 1
            while self.perm_tmp_list[i] > self.perm_tmp_list[j]:
                j -= 1
            # 交换i与j的位置
            self.perm_tmp_list[i], self.perm_tmp_list[j] = self.perm_tmp_list[j], self.perm_tmp_list[i]
            # 将i之后（不包括i）的子序列倒序
            lt = i + 1
            rt = self.length - 1
            while lt < rt:
                self.perm_tmp_list[lt], self.perm_tmp_list[rt] = self.perm_tmp_list[rt], self.perm_tmp_list[lt]
                lt += 1
                rt -= 1

    def calc_compare(self):
        """
        计算objv值，并比较，是否是当前最优解，如果是，则更新。
        """
        self.counter += 1
        if self.verbose and self.counter % 10_0000 == 0:
            print("已枚举了 %d 个染色体" % self.counter)
        objv = self.problem.get_objv_from_single_chrome(self.perm_tmp_list)
        if objv != 9999_9999:
            self.counter_feasible += 1
            if objv < self.minobjv:
                self.minobjv = objv
                self.best_journey = self.perm_tmp_list.copy()


class WebExecutor:
    def __init__(self):
        self.counter_test01 = 0
        self.counter_test02 = 0
        self.counter_updateDist = 0
        self.counter_executeAlgorithm = 0
