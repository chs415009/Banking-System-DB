<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Transaction Details</title>
</head>
<body>
    <h1>Banking System</h1>
    <div>
        <a href="${pageContext.request.contextPath}/">Home</a> |
        <a href="${pageContext.request.contextPath}/customers">Customers</a> |
        <a href="${pageContext.request.contextPath}/accounts">Accounts</a> |
        <a href="${pageContext.request.contextPath}/loans">Loans</a> |
        <a href="${pageContext.request.contextPath}/transactions">Transactions</a>
    </div>

    <h2>Transaction Details</h2>
    <a href="${pageContext.request.contextPath}/transactions">Back to List</a>
    
    <c:if test="${not empty successMessage}">
        <div style="color: green; margin: 10px 0;">
            ${successMessage}
        </div>
    </c:if>
    
    <h3>Transaction Information</h3>
    <table border="1" style="width: 60%; border-collapse: collapse;">
        <tr>
            <td><strong>Transaction ID:</strong></td>
            <td>${transaction.transactionId}</td>
        </tr>
        <tr>
            <td><strong>Instrument ID:</strong></td>
            <td>${transaction.instrument.instrumentId}</td>
        </tr>
        <tr>
            <td><strong>Instrument Type:</strong></td>
            <td>${transaction.instrumentType}</td>
        </tr>
        <tr>
            <td><strong>Transaction Type:</strong></td>
            <td>${transaction.transactionType}</td>
        </tr>
        <tr>
            <td><strong>Amount:</strong></td>
            <td><fmt:formatNumber value="${transaction.amount}" type="currency"/></td>
        </tr>
        <tr>
            <td><strong>Date & Time:</strong></td>
            <td><fmt:formatDate value="${transaction.dateTime}" pattern="MM/dd/yyyy HH:mm:ss" /></td>
        </tr>
        <tr>
            <td><strong>Status:</strong></td>
            <td>${transaction.status}</td>
        </tr>
        <tr>
            <td><strong>Description:</strong></td>
            <td>${transaction.description}</td>
        </tr>
    </table>
    
    <h3>Related Instrument Details</h3>
    <c:choose>
        <c:when test="${transaction.instrumentType == 'Account'}">
            <p>
                <strong>Account Number:</strong> ${transaction.instrument.accountNumber}<br>
                <strong>Account Type:</strong> ${transaction.instrument.accountType}<br>
                <strong>Current Balance:</strong> <fmt:formatNumber value="${transaction.instrument.balance}" type="currency"/><br>
                <a href="${pageContext.request.contextPath}/accounts/${transaction.instrument.instrumentId}">View Account Details</a>
            </p>
        </c:when>
        <c:when test="${transaction.instrumentType == 'Loan'}">
            <p>
                <strong>Loan Type:</strong> ${transaction.instrument.loanType}<br>
                <strong>Loan Amount:</strong> <fmt:formatNumber value="${transaction.instrument.loanAmount}" type="currency"/><br>
                <strong>Loan Status:</strong> ${transaction.instrument.loanStatus}<br>
                <a href="${pageContext.request.contextPath}/loans/${transaction.instrument.instrumentId}">View Loan Details</a>
            </p>
        </c:when>
        <c:otherwise>
            <p>Other instrument type: ${transaction.instrumentType}</p>
        </c:otherwise>
    </c:choose>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>