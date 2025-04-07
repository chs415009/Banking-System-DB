package com.mycompany.BankingSystemDB.Repositories;

import com.mycompany.BankingSystemDB.POJOs.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer> {
    
    // Find customers by branch ID
    List<Customer> findByBranchBranchId(Integer branchId);
    
    // Find customers by email (for searching)
    Customer findByEmail(String email);
    
    // Find customers by last name (for searching)
    List<Customer> findByLastNameContainingIgnoreCase(String lastName);
    
    // Find customers by customer type
    List<Customer> findByCustomerType(String customerType);
    
    // Custom query to find customers with active accounts
    @Query("SELECT DISTINCT c FROM Customer c JOIN c.financialInstruments cfi JOIN cfi.instrument i WHERE i.instrumentType = 'Account' AND i.status = 'Active'")
    List<Customer> findCustomersWithActiveAccounts();
    
    // Custom query to find customers by phone number
    @Query("SELECT c FROM Customer c WHERE c.phoneNumber = :phoneNumber")
    Customer findByPhoneNumber(@Param("phoneNumber") String phoneNumber);
}