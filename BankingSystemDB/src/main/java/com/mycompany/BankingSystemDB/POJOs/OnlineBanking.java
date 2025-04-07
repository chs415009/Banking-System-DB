package com.mycompany.BankingSystemDB.POJOs;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Online_Banking")
public class OnlineBanking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "online_banking_id")
    private Integer onlineBankingId;

    @OneToOne
    @JoinColumn(name = "customer_id", nullable = false, unique = true)
    private Customer customer;

    @Column(name = "username", length = 50)
    private String username;

    @Column(name = "password_hash", length = 255)
    private String passwordHash;

    @Column(name = "last_login_timestamp")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastLoginTimestamp;

    @Column(name = "two_factor_authentication_status")
    private Boolean twoFactorAuthenticationStatus;

    // Constructors
    public OnlineBanking() {
    }

    // Getters and Setters
    public Integer getOnlineBankingId() {
        return onlineBankingId;
    }

    public void setOnlineBankingId(Integer onlineBankingId) {
        this.onlineBankingId = onlineBankingId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public Date getLastLoginTimestamp() {
        return lastLoginTimestamp;
    }

    public void setLastLoginTimestamp(Date lastLoginTimestamp) {
        this.lastLoginTimestamp = lastLoginTimestamp;
    }

    public Boolean getTwoFactorAuthenticationStatus() {
        return twoFactorAuthenticationStatus;
    }

    public void setTwoFactorAuthenticationStatus(Boolean twoFactorAuthenticationStatus) {
        this.twoFactorAuthenticationStatus = twoFactorAuthenticationStatus;
    }
}