<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Accounts</title>
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
            <c:when test="${not empty customerId}">
                Customer Accounts
            </c:when>
            <c:otherwise>
                Account List
            </c:otherwise>
        </c:choose>
    </h2>
    <a href="${pageContext.request.contextPath}/accounts/create">Add New Account</a>
    
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
        <h3>Filter Accounts</h3>
        <form action="${pageContext.request.contextPath}/accounts/filter" method="get">
            <select name="accountType">
                <option value="">All Account Types</option>
                <option value="Savings" ${accountType == 'Savings' ? 'selected' : ''}>Savings</option>
                <option value="Checking" ${accountType == 'Checking' ? 'selected' : ''}>Checking</option>
                <option value="Money Market" ${accountType == 'Money Market' ? 'selected' : ''}>Money Market</option>
            </select>
            <button type="submit">Filter</button>
        </form>
    </div>
    
    <table border="1" style="width: 100%; border-collapse: collapse;">
        <thead>
            <tr>
                <th>Account ID</th>
                <th>Account Number</th>
                <th>Account Type</th>
                <th>Balance</th>
                <th>Interest Rate</th>
                <th>Branch</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${accounts}" var="account">
                <tr>
                    <td>${account.instrumentId}</td>
                    <td>${account.accountNumber}</td>
                    <td>${account.accountType}</td>
                    <td><fmt:formatNumber value="${account.balance}" type="currency"/></td>
                    <td><fmt:formatNumber value="${account.interestRate}" type="percent" minFractionDigits="2"/></td>
                    <td>${account.branch.branchName}</td>
                    <td>${account.status}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/accounts/${account.instrumentId}">View</a> |
                        <a href="${pageContext.request.contextPath}/accounts/${account.instrumentId}/edit">Edit</a> |
                        <a href="${pageContext.request.contextPath}/accounts/${account.instrumentId}/delete" onclick="return confirm('Are you sure you want to delete this account?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <c:if test="${empty accounts}">
        <p>No accounts found.</p>
    </c:if>
    
    <c:if test="${not empty customerId}">
        <div>
            <a href="${pageContext.request.contextPath}/customers/${customerId}">Back to Customer Details</a>
        </div>
    </c:if>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>