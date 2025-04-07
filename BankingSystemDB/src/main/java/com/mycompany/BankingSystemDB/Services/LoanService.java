package com.mycompany.BankingSystemDB.Services;

import com.mycompany.BankingSystemDB.POJOs.Loan;
import com.mycompany.BankingSystemDB.Repositories.LoanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class LoanService {

    private final LoanRepository loanRepository;

    @Autowired
    public LoanService(LoanRepository loanRepository) {
        this.loanRepository = loanRepository;
    }

    // Get all loans
    public List<Loan> getAllLoans() {
        return loanRepository.findAll();
    }

    // Get loan by ID
    public Optional<Loan> getLoanById(Integer id) {
        return loanRepository.findById(id);
    }

    // Find loans by loan type
    public List<Loan> findByLoanType(String loanType) {
        return loanRepository.findByLoanType(loanType);
    }

    // Find loans by status
    public List<Loan> findByLoanStatus(String status) {
        return loanRepository.findByLoanStatus(status);
    }

    // Find loans by processed employee ID
    public List<Loan> findByProcessedByEmployeeId(Integer employeeId) {
        return loanRepository.findByProcessedByEmployeeEmployeeId(employeeId);
    }

    // Find loans with amount greater than specified amount
    public List<Loan> findByLoanAmountGreaterThan(BigDecimal minAmount) {
        return loanRepository.findByLoanAmountGreaterThan(minAmount);
    }

    // Find loans with end date after specified date
    public List<Loan> findByEndDateAfter(Date date) {
        return loanRepository.findByEndDateAfter(date);
    }

    // Find loans by customer ID
    public List<Loan> findLoansByCustomerId(Integer customerId) {
        return loanRepository.findLoansByCustomerId(customerId);
    }

    // Create a new loan
    @Transactional
    public Loan saveLoan(Loan loan) {
        return loanRepository.save(loan);
    }

    // Update an existing loan
    @Transactional
    public Loan updateLoan(Loan loan) {
        return loanRepository.save(loan);
    }

    // Delete a loan
    @Transactional
    public void deleteLoan(Integer id) {
        loanRepository.deleteById(id);
    }

    // Find active loans with high interest rates
    public List<Loan> findActiveLoansWithHighInterestRate(BigDecimal rate) {
        return loanRepository.findActiveLoansWithHighInterestRate(rate);
    }
}