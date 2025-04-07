package com.mycompany.BankingSystemDB.POJOs;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Loan")
@PrimaryKeyJoinColumn(name = "loan_id")
public class Loan extends FinancialInstrument {

    @ManyToOne
    @JoinColumn(name = "processed_by_employee_id", nullable = false)
    private Employee processedByEmployee;

    @Column(name = "loan_type", nullable = false, length = 50)
    private String loanType;

    @Column(name = "loan_amount", precision = 10, scale = 2)
    private BigDecimal loanAmount;

    @Column(name = "interest_rate", precision = 5, scale = 2)
    private BigDecimal interestRate;

    @Column(name = "term")
    private Integer term;

    @Column(name = "start_date")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;

    @Column(name = "end_date")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    @Column(name = "status", length = 20)
    private String loanStatus;

    // Constructors
    public Loan() {
        super();
        this.setInstrumentType("Loan");
    }

    // Getters and Setters
    public Employee getProcessedByEmployee() {
        return processedByEmployee;
    }

    public void setProcessedByEmployee(Employee processedByEmployee) {
        this.processedByEmployee = processedByEmployee;
    }

    public String getLoanType() {
        return loanType;
    }

    public void setLoanType(String loanType) {
        this.loanType = loanType;
    }

    public BigDecimal getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(BigDecimal loanAmount) {
        this.loanAmount = loanAmount;
    }

    public BigDecimal getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(BigDecimal interestRate) {
        this.interestRate = interestRate;
    }

    public Integer getTerm() {
        return term;
    }

    public void setTerm(Integer term) {
        this.term = term;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getLoanStatus() {
        return loanStatus;
    }

    public void setLoanStatus(String loanStatus) {
        this.loanStatus = loanStatus;
    }
}