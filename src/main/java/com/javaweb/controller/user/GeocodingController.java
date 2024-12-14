package com.javaweb.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.javaweb.service.*;
import com.javaweb.dto.*;
import java.util.List;
@RestController
@RequestMapping("")
public class GeocodingController {
	 @Autowired
	    private IGeocodingService geocodingService;

	    // API để chuyển địa chỉ text thành tọa độ
	    @GetMapping("/geocode")
	    public GeocodingResultDTO getCoordinates(@RequestParam String address) {
	    	System.out.println(address);
	    	System.out.println( "Address : " + geocodingService.getCoordinates(address));
	        return geocodingService.getCoordinates(address);
	    }
}
