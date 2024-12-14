package com.javaweb.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.javaweb.entity.TransactionEntity;

public interface ITransactionService {

	// Phương thức trả về danh sách các giao dịch của người dùng
    List<TransactionEntity> getTransactionsByUserId(Long userId);
    Page<TransactionEntity> getTransactionsByUserId(Long userId, Pageable pageable);
    Page<TransactionEntity> getTransactionsByUserIdAndDateRange(Long userId, LocalDate startDate, LocalDate endDate, Pageable pageable);
	void save(TransactionEntity transaction);}
