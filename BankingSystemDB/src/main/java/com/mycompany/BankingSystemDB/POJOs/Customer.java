package com.mycompany.BankingSystemDB.POJOs;

import jakarta.persistence.*;

import java.util.Date;
import java.util.Set;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Customer")
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "customer_id")
    private Integer customerId;

    @ManyToOne
    @JoinColumn(name = "branch_id", nullable = false)
    private Branch branch;

    @Column(name = "first_name", nullable = false, length = 100)
    private String firstName;

    @Column(name = "last_name", nullable = false, length = 100)
    private String lastName;

    @Column(name = "date_of_birth", nullable = false)
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateOfBirth;

    @Column(name = "address_line_1", length = 255)
    private String addressLine1;

    @Column(name = "address_line_2", length = 255)
    private String addressLine2;

    @Column(name = "email", length = 255)
    private String email;

    @Column(name = "zip_code", length = 10)
    private String zipCode;

    @Column(name = "phone_number", length = 15)
    private String phoneNumber;

    @Column(name = "ssn", length = 11)
    private String ssn;

    @Column(name = "customer_type", length = 50)
    private String customerType;

    @OneToMany(mappedBy = "customer")
    private Set<Beneficiary> beneficiaries;

    @OneToOne(mappedBy = "customer")
    private OnlineBanking onlineBanking;

    @OneToMany(mappedBy = "customer")
    private Set<Investment> investments;

    @OneToMany(mappedBy = "customer")
    private Set<Customer_Financial_Instrument> financialInstruments;

    // Constructors
    public Customer() {
    }

    // Getters and Setters
    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getAddressLine1() {
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    public String getAddressLine2() {
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public String getCustomerType() {
        return customerType;
    }

    public void setCustomerType(String customerType) {
        this.customerType = customerType;
    }

    public Set<Beneficiary> getBeneficiaries() {
        return beneficiaries;
    }

    public void setBeneficiaries(Set<Beneficiary> beneficiaries) {
        this.beneficiaries = beneficiaries;
    }

    public OnlineBanking getOnlineBanking() {
        return onlineBanking;
    }

    public void setOnlineBanking(OnlineBanking onlineBanking) {
        this.onlineBanking = onlineBanking;
    }

    public Set<Investment> getInvestments() {
        return investments;
    }

    public void setInvestments(Set<Investment> investments) {
        this.investments = investments;
    }

    public Set<Customer_Financial_Instrument> getFinancialInstruments() {
        return financialInstruments;
    }

    public void setFinancialInstruments(Set<Customer_Financial_Instrument> financialInstruments) {
        this.financialInstruments = financialInstruments;
    }

    // Full name utility method
    public String getFullName() {
        return firstName + " " + lastName;
    }
}