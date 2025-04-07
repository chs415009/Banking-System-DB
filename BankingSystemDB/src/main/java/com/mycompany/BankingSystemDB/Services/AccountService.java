package com.mycompany.BankingSystemDB.Services;

import com.mycompany.BankingSystemDB.POJOs.Account;
import com.mycompany.BankingSystemDB.Repositories.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class AccountService {

    private final AccountRepository accountRepository;

    @Autowired
    public AccountService(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    // Get all accounts
    public List<Account> getAllAccounts() {
        return accountRepository.findAll();
    }

    // Get account by ID
    public Optional<Account> getAccountById(Integer id) {
        return accountRepository.findById(id);
    }

    // Find account by account number
    public Account findByAccountNumber(Long accountNumber) {
        return accountRepository.findByAccountNumber(accountNumber);
    }

    // Find accounts by branch ID
    public List<Account> findByBranchId(Integer branchId) {
        return accountRepository.findByBranchBranchId(branchId);
    }

    // Find accounts by account type
    public List<Account> findByAccountType(String accountType) {
        return accountRepository.findByAccountType(accountType);
    }

    // Find accounts with balance greater than specified amount
    public List<Account> findByBalanceGreaterThan(BigDecimal minBalance) {
        return accountRepository.findByBalanceGreaterThan(minBalance);
    }

    // Find accounts with balance less than specified amount
    public List<Account> findByBalanceLessThan(BigDecimal maxBalance) {
        return accountRepository.findByBalanceLessThan(maxBalance);
    }

    // Find accounts by customer ID
    public List<Account> findAccountsByCustomerId(Integer customerId) {
        return accountRepository.findAccountsByCustomerId(customerId);
    }

    // Create a new account
    @Transactional
    public Account saveAccount(Account account) {
        return accountRepository.save(account);
    }

    // Update an existing account
    @Transactional
    public Account updateAccount(Account account) {
        return accountRepository.save(account);
    }

    // Delete an account
    @Transactional
    public void deleteAccount(Integer id) {
        accountRepository.deleteById(id);
    }

    // Find active accounts with high interest rates
    public List<Account> findActiveAccountsWithHighInterestRate(BigDecimal rate) {
        return accountRepository.findActiveAccountsWithHighInterestRate(rate);
    }
}