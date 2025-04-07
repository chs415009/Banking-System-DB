package com.mycompany.BankingSystemDB.Repositories;

import com.mycompany.BankingSystemDB.POJOs.Transaction;
import com.mycompany.BankingSystemDB.POJOs.TransactionPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, TransactionPK> {
    
    // Find transactions by instrument ID
    List<Transaction> findByInstrumentInstrumentId(Integer instrumentId);
    
    // Find transactions by instrument type
    List<Transaction> findByInstrumentType(String instrumentType);
    
    // Find transactions by transaction type
    List<Transaction> findByTransactionType(String transactionType);
    
    // Find transactions by status
    List<Transaction> findByStatus(String status);
    
    // Find transactions with amount greater than specified amount
    List<Transaction> findByAmountGreaterThan(BigDecimal minAmount);
    
    // Find transactions between date range
    List<Transaction> findByDateTimeBetween(Date startDate, Date endDate);
    
    // Custom query to find transactions for a specific customer
    @Query("SELECT t FROM Transaction t JOIN t.instrument i JOIN i.customerRelationships cfi WHERE cfi.customer.customerId = :customerId")
    List<Transaction> findTransactionsByCustomerId(@Param("customerId") Integer customerId);
    
    // Custom query to find recent transactions (last 30 days)
    @Query("SELECT t FROM Transaction t WHERE t.dateTime >= :thirtyDaysAgo ORDER BY t.dateTime DESC")
    List<Transaction> findRecentTransactions(@Param("thirtyDaysAgo") Date thirtyDaysAgo);
}