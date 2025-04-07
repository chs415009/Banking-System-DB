<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Loan Details</title>
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

    <h2>Loan Details</h2>
    <a href="${pageContext.request.contextPath}/loans">Back to List</a> |
    <a href="${pageContext.request.contextPath}/loans/${loan.instrumentId}/edit">Edit Loan</a>
    
    <c:if test="${not empty successMessage}">
        <div style="color: green; margin: 10px 0;">
            ${successMessage}
        </div>
    </c:if>
    
    <h3>Loan Information</h3>
    <table border="1" style="width: 60%; border-collapse: collapse;">
        <tr>
            <td><strong>Loan ID:</strong></td>
            <td>${loan.instrumentId}</td>
        </tr>
        <tr>
            <td><strong>Loan Type:</strong></td>
            <td>${loan.loanType}</td>
        </tr>
        <tr>
            <td><strong>Loan Amount:</strong></td>
            <td><fmt:formatNumber value="${loan.loanAmount}" type="currency"/></td>
        </tr>
        <tr>
            <td><strong>Interest Rate:</strong></td>
            <td><fmt:formatNumber value="${loan.interestRate}" type="percent" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td><strong>Term (Months):</strong></td>
            <td>${loan.term}</td>
        </tr>
        <tr>
            <td><strong>Start Date:</strong></td>
            <td><fmt:formatDate value="${loan.startDate}" pattern="MM/dd/yyyy" /></td>
        </tr>
        <tr>
            <td><strong>End Date:</strong></td>
            <td><fmt:formatDate value="${loan.endDate}" pattern="MM/dd/yyyy" /></td>
        </tr>
        <tr>
            <td><strong>Status:</strong></td>
            <td>${loan.loanStatus}</td>
        </tr>
        <tr>
            <td><strong>Processed By:</strong></td>
            <td>${loan.processedByEmployee.firstName} ${loan.processedByEmployee.lastName}</td>
        </tr>
    </table>
    
    <h3>Loan Owners</h3>
    <c:if test="${not empty loan.customerRelationships}">
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
                <c:forEach items="${loan.customerRelationships}" var="cfi">
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
    <c:if test="${empty loan.customerRelationships}">
        <p>No owners found for this loan.</p>
    </c:if>
    
    <h3>Recent Transactions</h3>
    <a href="${pageContext.request.contextPath}/transactions/instrument/${loan.instrumentId}">View All Transactions</a>
    <c:if test="${not empty loan.transactions}">
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
                <c:forEach items="${loan.transactions}" var="transaction" end="4">
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
    <c:if test="${empty loan.transactions}">
        <p>No transactions found for this loan.</p>
    </c:if>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>