package com.ly.controller;

import com.ly.entity.Place;
import com.ly.service.PlaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@CrossOrigin
@RequestMapping("/place")
public class PlaceController {

    @Autowired
    PlaceService placeService;

    @GetMapping("/{pid}")
    @ResponseBody
//    http://localhost:9090/place/ab123
    public Place findOnePlace(@PathVariable("pid") String pid) {
        Place place = placeService.findByPid(pid);
        if (place == null) {
            place = new Place();
        }
        return place;
    }

    @GetMapping("/findall")
    @ResponseBody
//    http://localhost:9090/place/findall
    public List<Place> findAllPlaces() {
        List<Place> places = placeService.findAll();
        return places;
    }


    /**
     * ptype:  1配送中心   2客户点   3额外充电站
     */
    //    http://localhost:9090/place/ptype/2
    @GetMapping("/ptype/{ptype}")
    @ResponseBody
    public List<Place> findPlacesByPtype(@PathVariable("ptype") Integer ptype) {
        List<Place> places = placeService.findByPtype(ptype);
        return places;
    }


}
