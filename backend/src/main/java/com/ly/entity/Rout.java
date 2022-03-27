package com.ly.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Rout {
    private Integer rid;
    private Timestamp gtime;
    private Integer get_result;
    private Integer chrome_len;
    private String alg;
    private Double exec_time;
    private Integer hit_cache_time;
    private Double hit_cache_rate;
    private String best_objv;
    private Integer use_car_num;
    private String rent;
    private String electricity;
    private String time_pen;
    private String best_chrome;
    private String cir2_list;
    private String solution_list;
    private String show_info_text;

}
