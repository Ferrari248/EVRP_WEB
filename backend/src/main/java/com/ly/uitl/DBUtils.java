package com.ly.uitl;

import java.util.Random;

public class DBUtils {
    private static Random rd = new Random();
    private static String str = "1234567890abcdefghijklmnopqrstuvwxyz";

    public static String getOnePid(int ptype) {
        String prefix;
        if (ptype == 1) {
            prefix = "a";
        } else if (ptype == 2) {
            prefix = "c";
        } else if (ptype == 3) {
            prefix = "e";
        } else {
            prefix = "u";
        }
        return prefix + getRandString(4);
    }

    public static String getRandString(int len) {
        StringBuilder sbd = new StringBuilder();
        for (int i = 0; i < len; i++) {
            sbd.append(str.charAt(rd.nextInt(36)));
        }
        return sbd.toString();
    }
}
