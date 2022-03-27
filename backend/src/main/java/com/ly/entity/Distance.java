package com.ly.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Distance {
    /**
     * 这个类在java项目中没有用，仅作为备用。
     * 因为tbl_distance表仅给Python算法模块使用。
     */
    private String pfrom;
    private String pto;
    private Integer dist;
    private Double calc_type;
}
