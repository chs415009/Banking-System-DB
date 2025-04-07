<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Customers</title>
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

    <h2>Customer List</h2>
    <a href="${pageContext.request.contextPath}/customers/create">Add New Customer</a>
    
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
        <h3>Search Customers</h3>
        <form action="${pageContext.request.contextPath}/customers/search" method="get">
            <input type="text" name="lastName" placeholder="Search by last name" value="${searchTerm}">
            <button type="submit">Search</button>
        </form>
    </div>
    
    <table border="1" style="width: 100%; border-collapse: collapse;">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Customer Type</th>
                <th>Branch</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${customers}" var="customer">
                <tr>
                    <td>${customer.customerId}</td>
                    <td>${customer.firstName} ${customer.lastName}</td>
                    <td>${customer.email}</td>
                    <td>${customer.phoneNumber}</td>
                    <td>${customer.customerType}</td>
                    <td>${customer.branch.branchName}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/customers/${customer.customerId}">View</a> |
                        <a href="${pageContext.request.contextPath}/customers/${customer.customerId}/edit">Edit</a> |
                        <a href="${pageContext.request.contextPath}/customers/${customer.customerId}/delete" onclick="return confirm('Are you sure you want to delete this customer?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <c:if test="${empty customers}">
        <p>No customers found.</p>
    </c:if>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>