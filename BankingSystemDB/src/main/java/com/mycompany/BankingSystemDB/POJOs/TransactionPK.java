package com.mycompany.BankingSystemDB.POJOs;

import java.io.Serializable;
import java.util.Objects;

public class TransactionPK implements Serializable {
    
    private Integer transactionId;
    private Integer instrument; // This must match the name of the field in the Transaction class

    // Default constructor
    public TransactionPK() {
    }

    // Parameterized constructor
    public TransactionPK(Integer transactionId, Integer instrument) {
        this.transactionId = transactionId;
        this.instrument = instrument;
    }

    // Getters and setters
    public Integer getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(Integer transactionId) {
        this.transactionId = transactionId;
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
        TransactionPK that = (TransactionPK) o;
        return Objects.equals(transactionId, that.transactionId) &&
               Objects.equals(instrument, that.instrument);
    }

    @Override
    public int hashCode() {
        return Objects.hash(transactionId, instrument);
    }
}