package com.mycompany.BankingSystemDB.Services;

import com.mycompany.BankingSystemDB.POJOs.Customer;
import com.mycompany.BankingSystemDB.Repositories.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class CustomerService {

    private final CustomerRepository customerRepository;

    @Autowired
    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    // Get all customers
    public List<Customer> getAllCustomers() {
        return customerRepository.findAll();
    }

    // Get customer by ID
    public Optional<Customer> getCustomerById(Integer id) {
        return customerRepository.findById(id);
    }

    // Find customer by email
    public Customer findByEmail(String email) {
        return customerRepository.findByEmail(email);
    }

    // Find customers by last name
    public List<Customer> findByLastName(String lastName) {
        return customerRepository.findByLastNameContainingIgnoreCase(lastName);
    }

    // Find customers by branch ID
    public List<Customer> findByBranchId(Integer branchId) {
        return customerRepository.findByBranchBranchId(branchId);
    }

    // Find customers by type
    public List<Customer> findByCustomerType(String customerType) {
        return customerRepository.findByCustomerType(customerType);
    }

    // Find customers with active accounts
    public List<Customer> findCustomersWithActiveAccounts() {
        return customerRepository.findCustomersWithActiveAccounts();
    }

    // Create a new customer
    @Transactional
    public Customer saveCustomer(Customer customer) {
        return customerRepository.save(customer);
    }

    // Update an existing customer
    @Transactional
    public Customer updateCustomer(Customer customer) {
        return customerRepository.save(customer);
    }

    // Delete a customer
    @Transactional
    public void deleteCustomer(Integer id) {
        customerRepository.deleteById(id);
    }

    // Find customer by phone number
    public Customer findByPhoneNumber(String phoneNumber) {
        return customerRepository.findByPhoneNumber(phoneNumber);
    }
}