package com.mycompany.BankingSystemDB.Services;

import com.mycompany.BankingSystemDB.POJOs.Transaction;
import com.mycompany.BankingSystemDB.POJOs.TransactionPK;
import com.mycompany.BankingSystemDB.Repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class TransactionService {

    private final TransactionRepository transactionRepository;

    @Autowired
    public TransactionService(TransactionRepository transactionRepository) {
        this.transactionRepository = transactionRepository;
    }

    // Get all transactions
    public List<Transaction> getAllTransactions() {
        return transactionRepository.findAll();
    }

    // Get transaction by ID
    public Optional<Transaction> getTransactionById(TransactionPK id) {
        return transactionRepository.findById(id);
    }

    // Find transactions by instrument ID
    public List<Transaction> findByInstrumentId(Integer instrumentId) {
        return transactionRepository.findByInstrumentInstrumentId(instrumentId);
    }

    // Find transactions by instrument type
    public List<Transaction> findByInstrumentType(String instrumentType) {
        return transactionRepository.findByInstrumentType(instrumentType);
    }

    // Find transactions by transaction type
    public List<Transaction> findByTransactionType(String transactionType) {
        return transactionRepository.findByTransactionType(transactionType);
    }

    // Find transactions by status
    public List<Transaction> findByStatus(String status) {
        return transactionRepository.findByStatus(status);
    }

    // Find transactions with amount greater than specified amount
    public List<Transaction> findByAmountGreaterThan(BigDecimal minAmount) {
        return transactionRepository.findByAmountGreaterThan(minAmount);
    }

    // Find transactions between date range
    public List<Transaction> findByDateTimeBetween(Date startDate, Date endDate) {
        return transactionRepository.findByDateTimeBetween(startDate, endDate);
    }

    // Find transactions by customer ID
    public List<Transaction> findTransactionsByCustomerId(Integer customerId) {
        return transactionRepository.findTransactionsByCustomerId(customerId);
    }

    // Find recent transactions (last 30 days)
    public List<Transaction> findRecentTransactions() {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -30);
        Date thirtyDaysAgo = cal.getTime();
        return transactionRepository.findRecentTransactions(thirtyDaysAgo);
    }

    // Create a new transaction
    @Transactional
    public Transaction saveTransaction(Transaction transaction) {
        return transactionRepository.save(transaction);
    }

    // Update an existing transaction
    @Transactional
    public Transaction updateTransaction(Transaction transaction) {
        return transactionRepository.save(transaction);
    }

    // Delete a transaction
    @Transactional
    public void deleteTransaction(TransactionPK id) {
        transactionRepository.deleteById(id);
    }
}