package com.javaweb.service;

import com.javaweb.dto.GeocodingResultDTO;

public interface IGeocodingService {

	GeocodingResultDTO getCoordinates(String address);

	double calculateDistance(double lat1, double lon1, double lat2, double lon2);

}
