package com.ly.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Customer {
    private String pid;
    private Double lng;
    private Double lat;
    private Integer demand;
    private String atime;
    private Double pen;
    private String phone;
    private String location_zh;
    private String info_detail;
}
