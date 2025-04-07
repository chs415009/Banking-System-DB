<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Transactions</title>
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

    <h2>
        <c:choose>
            <c:when test="${not empty title}">
                ${title}
            </c:when>
            <c:when test="${not empty customerId}">
                Customer Transactions
            </c:when>
            <c:when test="${not empty instrumentId}">
                Instrument Transactions
            </c:when>
            <c:otherwise>
                Transaction List
            </c:otherwise>
        </c:choose>
    </h2>
    <!--<a href="${pageContext.request.contextPath}/transactions/create">Create New Transaction</a>-->
    
    <c:if test="${not empty successMessage}">
        <div style="color: green; margin: 10px 0;">
            ${successMessage}
        </div>
    </c:if>
    
    <c:if test="${not empty errorMessage}">
        <div style="color: red; margin: 10px 0;">
            ${errorMessage}
        </div>
    </c:if>
    
    <div>
        <h3>Filter Transactions</h3>
        <form action="${pageContext.request.contextPath}/transactions/filter" method="get">
            <select name="transactionType">
                <option value="">All Transaction Types</option>
                <option value="Deposit" ${transactionType == 'Deposit' ? 'selected' : ''}>Deposit</option>
                <option value="Withdrawal" ${transactionType == 'Withdrawal' ? 'selected' : ''}>Withdrawal</option>
                <option value="Payment" ${transactionType == 'Payment' ? 'selected' : ''}>Payment</option>
                <option value="Transfer" ${transactionType == 'Transfer' ? 'selected' : ''}>Transfer</option>
            </select>
            <button type="submit">Filter</button>
        </form>
    </div>
    
    <table border="1" style="width: 100%; border-collapse: collapse;">
        <thead>
            <tr>
                <th>Transaction ID</th>
                <th>Instrument ID</th>
                <th>Instrument Type</th>
                <th>Transaction Type</th>
                <th>Amount</th>
                <th>Date & Time</th>
                <th>Status</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${transactions}" var="transaction">
                <tr>
                    <td>${transaction.transactionId}</td>
                    <td>${transaction.instrument.instrumentId}</td>
                    <td>${transaction.instrumentType}</td>
                    <td>${transaction.transactionType}</td>
                    <td><fmt:formatNumber value="${transaction.amount}" type="currency"/></td>
                    <td><fmt:formatDate value="${transaction.dateTime}" pattern="MM/dd/yyyy HH:mm" /></td>
                    <td>${transaction.status}</td>
                    <td>${transaction.description}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/transactions/${transaction.transactionId}/${transaction.instrument.instrumentId}">View</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <c:if test="${empty transactions}">
        <p>No transactions found.</p>
    </c:if>
    
    <c:if test="${not empty customerId}">
        <div>
            <a href="${pageContext.request.contextPath}/customers/${customerId}">Back to Customer Details</a>
        </div>
    </c:if>
    
    <c:if test="${not empty instrumentId}">
        <div>
            <c:choose>
                <c:when test="${transactions[0].instrumentType == 'Account'}">
                    <a href="${pageContext.request.contextPath}/accounts/${instrumentId}">Back to Account Details</a>
                </c:when>
                <c:when test="${transactions[0].instrumentType == 'Loan'}">
                    <a href="${pageContext.request.contextPath}/loans/${instrumentId}">Back to Loan Details</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/">Back to Home</a>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>