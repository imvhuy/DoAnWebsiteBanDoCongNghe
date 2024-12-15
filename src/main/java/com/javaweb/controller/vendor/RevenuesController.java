package com.javaweb.controller.vendor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.javaweb.entity.*;
import com.javaweb.service.*;
import com.google.gson.Gson;
import com.javaweb.dto.*;

@Controller
@RequestMapping(value = "/vendor")
public class RevenuesController {
	@Autowired
	IOrderService orderService;
	@Autowired
	IStoreService storeService;
	@Autowired
	IUserService userService;
    @GetMapping("/manage-revenue")
    public ModelAndView load(@RequestParam(value = "year", required = false) Integer year) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
       // System.out.println("username : " + username);
        UserEntity owner = userService.findByUserNameEntity(username);
        //System.out.println("owner : " + owner.getId());
        StoreEntity store = storeService.findByOwner(owner);
        if (year == null)
        {
        	year = Year.now().getValue();
        }
        //Doanh thu theo tháng của store
    	List<MonthRevenuesDTO> monthRevenues = orderService.getMonthRevenuesByStoreId(store.getId(),year);
    	//
    	List<String> months = new ArrayList<>();
		List<Double> totalOfMonths = new ArrayList<>();
		for (MonthRevenuesDTO result : monthRevenues) {
		    String month = (String) getMonthName(result.getMonth()); // Cột tên tháng
		    Double revenue = (Double) result.getTotal();   // Cột doanh thu
		    
		    // Thêm movie và doanh thu vào danh sách
		    months.add(month);
		    totalOfMonths.add(revenue);
		}
		String jsonChartMonthlyData = new Gson().toJson(Map.of(
			    "monthList", months,
			    "revenueList", totalOfMonths
			));
		//Số lượng order theo tháng
    	List<Object[]> totalMonthlyOrders = orderService.getTotalMonthlyOrdersByStoreId(store.getId(),year);
    	//
    	List<String> orderMonths = new ArrayList<>();
		List<Long> totalOrders = new ArrayList<>();
		for (Object[] result : totalMonthlyOrders) {
		    String month = (String) getMonthName((Integer)result[0]); // Cột tên tháng
		    Long count = (Long) result[1];   // Cột doanh thu
		    
		    // Thêm movie và doanh thu vào danh sách
		    orderMonths.add(month);
		    totalOrders.add(count);
		}

		String jsonChartMonthlyOrderData = new Gson().toJson(Map.of(
			    "monthList", orderMonths,
			    "amountList", totalOrders
			));

		//tạo danh sách năm
		List<Integer> yearList = new ArrayList<>();
        int currentYear = Year.now().getValue(); // Lấy năm hiện tại
        for (int i = currentYear - 10; i <= currentYear + 10; i++) {
            yearList.add(i);
        }
    	ModelAndView mav = new ModelAndView("vendor/manage-revenue");
    	mav.addObject("jsonChartMonthlyData", jsonChartMonthlyData);
    	mav.addObject("jsonChartMonthlyOrderData", jsonChartMonthlyOrderData);
    	mav.addObject("yearList", yearList);
    	mav.addObject("selectedYear", year); // Truyền năm được chọn để hiển thị
    	 return mav;
    }
    
    public String getMonthName(int month) {
        switch (month) {
            case 1: return "Jan";
            case 2: return "Feb";
            case 3: return "Mar";
            case 4: return "Apr";
            case 5: return "May";
            case 6: return "June";
            case 7: return "July";
            case 8: return "Aug";
            case 9: return "Sep";
            case 10: return "Oct";
            case 11: return "Nov";
            case 12: return "Dec";
            default: throw new IllegalArgumentException("Invalid month: " + month);
        }
    }

}
