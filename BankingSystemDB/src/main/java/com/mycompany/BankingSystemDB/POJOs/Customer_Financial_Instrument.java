package com.mycompany.BankingSystemDB.POJOs;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Customer_Financial_Instrument")
@IdClass(CustomerFinancialInstrumentPK.class)
public class Customer_Financial_Instrument {

    @Id
    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @Id
    @ManyToOne
    @JoinColumn(name = "instrument_id")
    private FinancialInstrument instrument;

    @Column(name = "role", nullable = false, length = 50)
    private String role;

    @Column(name = "enrollment_date")
    @Temporal(TemporalType.DATE)
    private Date enrollmentDate;

    // Constructors
    public Customer_Financial_Instrument() {
    }

    // Getters and Setters
    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public FinancialInstrument getInstrument() {
        return instrument;
    }

    public void setInstrument(FinancialInstrument instrument) {
        this.instrument = instrument;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getEnrollmentDate() {
        return enrollmentDate;
    }

    public void setEnrollmentDate(Date enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }
}