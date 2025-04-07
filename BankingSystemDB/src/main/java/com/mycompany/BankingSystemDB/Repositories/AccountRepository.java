package com.mycompany.BankingSystemDB.Repositories;

import com.mycompany.BankingSystemDB.POJOs.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {
    
    // Find account by account number
    Account findByAccountNumber(Long accountNumber);
    
    // Find accounts by branch ID
    List<Account> findByBranchBranchId(Integer branchId);
    
    // Find accounts by account type
    List<Account> findByAccountType(String accountType);
    
    // Find accounts with balance greater than specified amount
    List<Account> findByBalanceGreaterThan(BigDecimal minBalance);
    
    // Find accounts with balance less than specified amount
    List<Account> findByBalanceLessThan(BigDecimal maxBalance);
    
    // Custom query to find accounts for a specific customer
    @Query("SELECT a FROM Account a JOIN a.customerRelationships cfi WHERE cfi.customer.customerId = :customerId")
    List<Account> findAccountsByCustomerId(@Param("customerId") Integer customerId);
    
    // Custom query to get active accounts with interest rate greater than specified rate
    @Query("SELECT a FROM Account a WHERE a.status = 'Active' AND a.interestRate > :rate")
    List<Account> findActiveAccountsWithHighInterestRate(@Param("rate") BigDecimal rate);
}