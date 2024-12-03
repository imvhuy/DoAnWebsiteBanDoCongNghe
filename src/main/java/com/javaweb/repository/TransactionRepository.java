package com.javaweb.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.TransactionEntity;
@Repository
public interface TransactionRepository extends JpaRepository<TransactionEntity, Long> {

    @Query("SELECT t FROM TransactionEntity t WHERE t.payment.user.id = :userId")
    List<TransactionEntity> findByUserId(Long userId);
    
    @Query("SELECT t FROM TransactionEntity t WHERE t.payment.user.id = :userId")
    Page<TransactionEntity> findByUserId(Long userId, Pageable pageable);

    @Query("SELECT t FROM TransactionEntity t " +
    	       "WHERE t.payment.user.id = :userId " +
    	       "AND FUNCTION('DATE', t.createdDate) >= :startDate " +
    	       "AND FUNCTION('DATE', t.createdDate) <= :endDate")
    	Page<TransactionEntity> findByUserIdAndTransactionDateBetween(Long userId, LocalDate startDate, LocalDate endDate, Pageable pageable);

}
