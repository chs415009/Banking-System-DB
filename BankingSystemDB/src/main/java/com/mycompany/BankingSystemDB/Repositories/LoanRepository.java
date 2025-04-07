package com.mycompany.BankingSystemDB.Repositories;

import com.mycompany.BankingSystemDB.POJOs.Loan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Repository
public interface LoanRepository extends JpaRepository<Loan, Integer> {
    
    // Find loans by loan type
    List<Loan> findByLoanType(String loanType);
    
    // Find loans by status
    List<Loan> findByLoanStatus(String status);
    
    // Find loans by processed employee ID
    List<Loan> findByProcessedByEmployeeEmployeeId(Integer employeeId);
    
    // Find loans with amount greater than specified amount
    List<Loan> findByLoanAmountGreaterThan(BigDecimal minAmount);
    
    // Find loans with end date after specified date
    List<Loan> findByEndDateAfter(Date date);
    
    // Custom query to find loans for a specific customer
    @Query("SELECT l FROM Loan l JOIN l.customerRelationships cfi WHERE cfi.customer.customerId = :customerId")
    List<Loan> findLoansByCustomerId(@Param("customerId") Integer customerId);
    
    // Custom query to find active loans with high interest rates
    @Query("SELECT l FROM Loan l WHERE l.status = 'Active' AND l.interestRate > :rate")
    List<Loan> findActiveLoansWithHighInterestRate(@Param("rate") BigDecimal rate);
}