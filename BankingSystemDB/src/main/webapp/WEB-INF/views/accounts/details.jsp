<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Account Details</title>
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

    <h2>Account Details</h2>
    <a href="${pageContext.request.contextPath}/accounts">Back to List</a> |
    <a href="${pageContext.request.contextPath}/accounts/${account.instrumentId}/edit">Edit Account</a>
    
    <c:if test="${not empty successMessage}">
        <div style="color: green; margin: 10px 0;">
            ${successMessage}
        </div>
    </c:if>
    
    <h3>Account Information</h3>
    <table border="1" style="width: 60%; border-collapse: collapse;">
        <tr>
            <td><strong>Account ID:</strong></td>
            <td>${account.instrumentId}</td>
        </tr>
        <tr>
            <td><strong>Account Number:</strong></td>
            <td>${account.accountNumber}</td>
        </tr>
        <tr>
            <td><strong>Account Type:</strong></td>
            <td>${account.accountType}</td>
        </tr>
        <tr>
            <td><strong>Balance:</strong></td>
            <td><fmt:formatNumber value="${account.balance}" type="currency"/></td>
        </tr>
        <tr>
            <td><strong>Interest Rate:</strong></td>
            <td><fmt:formatNumber value="${account.interestRate}" type="percent" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td><strong>Opening Date:</strong></td>
            <td><fmt:formatDate value="${account.openingDate}" pattern="MM/dd/yyyy" /></td>
        </tr>
        <tr>
            <td><strong>Branch:</strong></td>
            <td>${account.branch.branchName}</td>
        </tr>
        <tr>
            <td><strong>Status:</strong></td>
            <td>${account.status}</td>
        </tr>
    </table>
    
    <h3>Account Owners</h3>
    <c:if test="${not empty account.customerRelationships}">
        <table border="1" style="width: 100%; border-collapse: collapse;">
            <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Name</th>
                    <th>Role</th>
                    <th>Enrollment Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${account.customerRelationships}" var="cfi">
                    <tr>
                        <td>${cfi.customer.customerId}</td>
                        <td>${cfi.customer.firstName} ${cfi.customer.lastName}</td>
                        <td>${cfi.role}</td>
                        <td><fmt:formatDate value="${cfi.enrollmentDate}" pattern="MM/dd/yyyy" /></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/customers/${cfi.customer.customerId}">View Customer</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty account.customerRelationships}">
        <p>No owners found for this account.</p>
    </c:if>
    
    <h3>Recent Transactions</h3>
    <a href="${pageContext.request.contextPath}/transactions/instrument/${account.instrumentId}">View All Transactions</a>
    <c:if test="${not empty account.transactions}">
        <table border="1" style="width: 100%; border-collapse: collapse;">
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${account.transactions}" var="transaction" end="4">
                    <tr>
                        <td>${transaction.transactionId}</td>
                        <td>${transaction.transactionType}</td>
                        <td><fmt:formatNumber value="${transaction.amount}" type="currency"/></td>
                        <td><fmt:formatDate value="${transaction.dateTime}" pattern="MM/dd/yyyy HH:mm" /></td>
                        <td>${transaction.status}</td>
                        <td>${transaction.description}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty account.transactions}">
        <p>No transactions found for this account.</p>
    </c:if>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>