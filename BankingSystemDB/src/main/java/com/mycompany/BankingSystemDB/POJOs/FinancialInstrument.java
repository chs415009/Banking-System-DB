package com.mycompany.BankingSystemDB.POJOs;

import jakarta.persistence.*;
import java.util.Set;

@Entity
@Table(name = "Financial_Instrument")
@Inheritance(strategy = InheritanceType.JOINED)
public class FinancialInstrument {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "instrument_id")
    private Integer instrumentId;

    @Column(name = "instrument_type", nullable = false, length = 50)
    private String instrumentType;

    @Column(name = "status", nullable = false, length = 20)
    private String status;

    @OneToMany(mappedBy = "instrument")
    private Set<Customer_Financial_Instrument> customerRelationships;

    @OneToMany(mappedBy = "instrument")
    private Set<Transaction> transactions;

    // Constructors
    public FinancialInstrument() {
    }

    // Getters and Setters
    public Integer getInstrumentId() {
        return instrumentId;
    }

    public void setInstrumentId(Integer instrumentId) {
        this.instrumentId = instrumentId;
    }

    public String getInstrumentType() {
        return instrumentType;
    }

    public void setInstrumentType(String instrumentType) {
        this.instrumentType = instrumentType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Set<Customer_Financial_Instrument> getCustomerRelationships() {
        return customerRelationships;
    }

    public void setCustomerRelationships(Set<Customer_Financial_Instrument> customerRelationships) {
        this.customerRelationships = customerRelationships;
    }

    public Set<Transaction> getTransactions() {
        return transactions;
    }

    public void setTransactions(Set<Transaction> transactions) {
        this.transactions = transactions;
    }
}