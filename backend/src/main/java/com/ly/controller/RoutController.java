package com.ly.controller;

import com.ly.entity.Rout;
import com.ly.service.RoutService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@CrossOrigin
@RequestMapping("/rout")
public class RoutController {

    @Autowired
    RoutService routService;

    @GetMapping("/")
    @ResponseBody
//    http://localhost:9090/rout/
    public Rout findLastRout() {
        Rout rout = routService.findLastRout();
        if (rout == null) {
            rout = new Rout();
        }
        return rout;
    }

}
