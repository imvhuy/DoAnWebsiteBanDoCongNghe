package com.javaweb.service.impl;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import com.javaweb.entity.TransactionEntity;
import com.javaweb.repository.ITransactionRepository;
import com.javaweb.service.ITransactionService;
import org.springframework.data.domain.Pageable;

@Service
public class TransactionServiceImpl implements ITransactionService {

	 @Autowired
	    private ITransactionRepository transactionRepository;

	 @Override
	    public List<TransactionEntity> getTransactionsByUserId(Long userId) {
	        return transactionRepository.findByUserId(userId);
	    }
	 @Override
	 public Page<TransactionEntity> getTransactionsByUserId(Long userId, Pageable pageable) {
		    return transactionRepository.findByUserId(userId, pageable);
		}
	 @Override
	    public Page<TransactionEntity> getTransactionsByUserIdAndDateRange(Long userId, LocalDate startDate, LocalDate endDate, Pageable pageable) {
	        return transactionRepository.findByUserIdAndTransactionDateBetween(userId, startDate, endDate, pageable);
	    }
	 
	 	@Override
		public void save(TransactionEntity transaction) {
	 		transactionRepository.save(transaction);
	 	}
}
