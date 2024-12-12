package com.javaweb.service;

import java.util.List;

import com.javaweb.dto.GeocodingResultDTO;

public interface IGeocodingService {

	List<GeocodingResultDTO> getCoordinates(String address);

}
