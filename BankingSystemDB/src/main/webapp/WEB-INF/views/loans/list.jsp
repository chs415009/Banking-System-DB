<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Loans</title>
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
                Customer Loans
            </c:when>
            <c:otherwise>
                Loan List
            </c:otherwise>
        </c:choose>
    </h2>
    <a href="${pageContext.request.contextPath}/loans/create">Add New Loan</a>
    
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
        <h3>Filter Loans</h3>
        <form action="${pageContext.request.contextPath}/loans/filter" method="get">
            <select name="loanType">
                <option value="">All Loan Types</option>
                <option value="Student" ${loanType == 'Student' ? 'selected' : ''}>Student</option>
                <option value="Vehicle" ${loanType == 'Vehicle' ? 'selected' : ''}>Vehicle</option>
                <option value="Mortgage" ${loanType == 'Mortgage' ? 'selected' : ''}>Mortgage</option>
                <option value="Business" ${loanType == 'Business' ? 'selected' : ''}>Business</option>
            </select>
            <button type="submit">Filter</button>
        </form>
        
        <form action="${pageContext.request.contextPath}/loans/status" method="get" style="margin-top: 10px;">
            <select name="status">
                <option value="">All Statuses</option>
                <option value="Active" ${status == 'Active' ? 'selected' : ''}>Active</option>
                <option value="Closed" ${status == 'Closed' ? 'selected' : ''}>Closed</option>
            </select>
            <button type="submit">Filter</button>
        </form>
    </div>
    
    <table border="1" style="width: 100%; border-collapse: collapse;">
        <thead>
            <tr>
                <th>Loan ID</th>
                <th>Loan Type</th>
                <th>Amount</th>
                <th>Interest Rate</th>
                <th>Term (Months)</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Status</th>
                <th>Processed By</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${loans}" var="loan">
                <tr>
                    <td>${loan.instrumentId}</td>
                    <td>${loan.loanType}</td>
                    <td><fmt:formatNumber value="${loan.loanAmount}" type="currency"/></td>
                    <td><fmt:formatNumber value="${loan.interestRate}" type="percent" minFractionDigits="2"/></td>
                    <td>${loan.term}</td>
                    <td><fmt:formatDate value="${loan.startDate}" pattern="MM/dd/yyyy" /></td>
                    <td><fmt:formatDate value="${loan.endDate}" pattern="MM/dd/yyyy" /></td>
                    <td>${loan.loanStatus}</td>
                    <td>${loan.processedByEmployee.firstName} ${loan.processedByEmployee.lastName}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/loans/${loan.instrumentId}">View</a> |
                        <a href="${pageContext.request.contextPath}/loans/${loan.instrumentId}/edit">Edit</a> |
                        <a href="${pageContext.request.contextPath}/loans/${loan.instrumentId}/delete" onclick="return confirm('Are you sure you want to delete this loan?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <c:if test="${empty loans}">
        <p>No loans found.</p>
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