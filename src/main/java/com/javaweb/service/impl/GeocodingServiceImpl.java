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
	public List<GeocodingResultDTO> getCoordinates(String address) {
//        RestTemplate restTemplate = new RestTemplate();
//
//        // Xây dựng URL với tham số
//        String url = UriComponentsBuilder.fromHttpUrl(NOMINATIM_URL)
//                .queryParam("q", address) // Địa chỉ cần geocode
//                .queryParam("format", "json") // Định dạng JSON
//                .queryParam("addressdetails", "1") // Chi tiết địa chỉ
//                .toUriString();
//        System.out.println("API URL: " + url);
//
//        // Gửi yêu cầu HTTP GET và nhận phản hồi
//        GeocodingResultDTO[] response = restTemplate.getForObject(url, GeocodingResultDTO[].class);
//     // Log phản hồi
//        System.out.println("API Response: " + Arrays.toString(response));
//        // Trả về danh sách kết quả (nếu có)
//        return Arrays.asList(response);
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

            return Arrays.asList(results);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }
}
