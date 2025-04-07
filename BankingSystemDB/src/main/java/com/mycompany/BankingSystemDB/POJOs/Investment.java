package com.mycompany.BankingSystemDB.POJOs;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "Investment")
public class Investment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "investment_id")
    private Integer investmentId;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private Customer customer;

    @Column(name = "investment_type", length = 255)
    private String investmentType;

    @Column(name = "investment_amount", precision = 10, scale = 2)
    private BigDecimal investmentAmount;

    @Column(name = "risk_profile", length = 255)
    private String riskProfile;

    @Column(name = "maturity_date")
    @Temporal(TemporalType.DATE)
    private Date maturityDate;

    // Constructors
    public Investment() {
    }

    // Getters and Setters
    public Integer getInvestmentId() {
        return investmentId;
    }

    public void setInvestmentId(Integer investmentId) {
        this.investmentId = investmentId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getInvestmentType() {
        return investmentType;
    }

    public void setInvestmentType(String investmentType) {
        this.investmentType = investmentType;
    }

    public BigDecimal getInvestmentAmount() {
        return investmentAmount;
    }

    public void setInvestmentAmount(BigDecimal investmentAmount) {
        this.investmentAmount = investmentAmount;
    }

    public String getRiskProfile() {
        return riskProfile;
    }

    public void setRiskProfile(String riskProfile) {
        this.riskProfile = riskProfile;
    }

    public Date getMaturityDate() {
        return maturityDate;
    }

    public void setMaturityDate(Date maturityDate) {
        this.maturityDate = maturityDate;
    }
}