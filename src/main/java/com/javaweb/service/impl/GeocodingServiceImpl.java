package com.javaweb.service.impl;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.javaweb.dto.*;
import com.javaweb.service.IGeocodingService;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
@Service
public class GeocodingServiceImpl implements IGeocodingService{
	private final String NOMINATIM_URL = "https://nominatim.openstreetmap.org/search";

    @Override
	public GeocodingResultDTO getCoordinates(String address) {
    	try {
            String url = "https://nominatim.openstreetmap.org/search?q=" +
                         URLEncoder.encode(address, StandardCharsets.UTF_8) +
                         "&format=json&addressdetails=1";

            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("User-Agent", "MyGeocodingApp")
                    .GET()
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            System.out.println("HTTP Status: " + response.statusCode());
            System.out.println("Raw Response: " + response.body());

            ObjectMapper mapper = new ObjectMapper();
            GeocodingResultDTO[] results = mapper.readValue(response.body(), GeocodingResultDTO[].class);

            return results[0];
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    private static final double EARTH_RADIUS = 6371; // Đơn vị: km
    //tính toán khoảng cách giữa 2 địa chỉ khi đã có tọa độ của chúng
    @Override
	public  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        // Chuyển đổi độ sang radians
        double lat1Rad = Math.toRadians(lat1);
        double lon1Rad = Math.toRadians(lon1);
        double lat2Rad = Math.toRadians(lat2);
        double lon2Rad = Math.toRadians(lon2);

        // Công thức Haversine
        double dlat = lat2Rad - lat1Rad;
        double dlon = lon2Rad - lon1Rad;

        double a = Math.sin(dlat / 2) * Math.sin(dlat / 2) +
                   Math.cos(lat1Rad) * Math.cos(lat2Rad) *
                   Math.sin(dlon / 2) * Math.sin(dlon / 2);

        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return EARTH_RADIUS * c; // Khoảng cách km
    }
}
