<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Customer Details</title>
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

    <h2>Customer Details</h2>
    <a href="${pageContext.request.contextPath}/customers">Back to List</a> |
    <a href="${pageContext.request.contextPath}/customers/${customer.customerId}/edit">Edit Customer</a>
    
    <c:if test="${not empty successMessage}">
        <div style="color: green; margin: 10px 0;">
            ${successMessage}
        </div>
    </c:if>
    
    <h3>Personal Information</h3>
    <table border="1" style="width: 60%; border-collapse: collapse;">
        <tr>
            <td><strong>Customer ID:</strong></td>
            <td>${customer.customerId}</td>
        </tr>
        <tr>
            <td><strong>Full Name:</strong></td>
            <td>${customer.firstName} ${customer.lastName}</td>
        </tr>
        <tr>
            <td><strong>Date of Birth:</strong></td>
            <td><fmt:formatDate value="${customer.dateOfBirth}" pattern="MM/dd/yyyy" /></td>
        </tr>
        <tr>
            <td><strong>Email:</strong></td>
            <td>${customer.email}</td>
        </tr>
        <tr>
            <td><strong>Phone:</strong></td>
            <td>${customer.phoneNumber}</td>
        </tr>
        <tr>
            <td><strong>SSN:</strong></td>
            <td>${customer.ssn}</td>
        </tr>
        <tr>
            <td><strong>Customer Type:</strong></td>
            <td>${customer.customerType}</td>
        </tr>
        <tr>
            <td><strong>Address:</strong></td>
            <td>${customer.addressLine1} ${customer.addressLine2}, ${customer.zipCode}</td>
        </tr>
        <tr>
            <td><strong>Branch:</strong></td>
            <td>${customer.branch.branchName} (ID: ${customer.branch.branchId})</td>
        </tr>
    </table>
    
    <h3>Accounts</h3>
    <a href="${pageContext.request.contextPath}/accounts/customer/${customer.customerId}">View All Accounts</a>
    
    <c:if test="${not empty customer.financialInstruments}">
        <table border="1" style="width: 100%; border-collapse: collapse;">
            <thead>
                <tr>
                    <th>Account Type</th>
                    <th>Account Number</th>
                    <th>Balance</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${customer.financialInstruments}" var="cfi">
                    <c:if test="${cfi.instrument.instrumentType == 'Account'}">
                        <tr>
                            <td>${cfi.instrument.accountType}</td>
                            <td>${cfi.instrument.accountNumber}</td>
                            <td>${cfi.instrument.balance}</td>
                            <td>${cfi.instrument.status}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/accounts/${cfi.instrument.instrumentId}">View</a>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty customer.financialInstruments}">
        <p>No accounts found for this customer.</p>
    </c:if>
    
    <h3>Loans</h3>
    <a href="${pageContext.request.contextPath}/loans/customer/${customer.customerId}">View All Loans</a>
    
    <h3>Recent Transactions</h3>
    <a href="${pageContext.request.contextPath}/transactions/customer/${customer.customerId}">View All Transactions</a>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>