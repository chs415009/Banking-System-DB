package com.mycompany.BankingSystemDB.POJOs;

import java.io.Serializable;
import java.util.Objects;

public class CustomerFinancialInstrumentPK implements Serializable {
    
    private Integer customer; // This must match the name of the field in the Customer_Financial_Instrument class
    private Integer instrument; // This must match the name of the field in the Customer_Financial_Instrument class

    // Default constructor
    public CustomerFinancialInstrumentPK() {
    }

    // Parameterized constructor
    public CustomerFinancialInstrumentPK(Integer customer, Integer instrument) {
        this.customer = customer;
        this.instrument = instrument;
    }

    // Getters and setters
    public Integer getCustomer() {
        return customer;
    }

    public void setCustomer(Integer customer) {
        this.customer = customer;
    }

    public Integer getInstrument() {
        return instrument;
    }

    public void setInstrument(Integer instrument) {
        this.instrument = instrument;
    }

    // Equals and hashCode methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CustomerFinancialInstrumentPK that = (CustomerFinancialInstrumentPK) o;
        return Objects.equals(customer, that.customer) &&
               Objects.equals(instrument, that.instrument);
    }

    @Override
    public int hashCode() {
        return Objects.hash(customer, instrument);
    }
}