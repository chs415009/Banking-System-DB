<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Home</title>
</head>
<body>
    <h1>Banking System Database</h1>
    
    <h2>Welcome to Banking System</h2>
    
    <p>Select a module to manage:</p>
    
    <ul>
        <li><a href="${pageContext.request.contextPath}/customers">Customers</a></li>
        <li><a href="${pageContext.request.contextPath}/accounts">Accounts</a></li>
        <li><a href="${pageContext.request.contextPath}/loans">Loans</a></li>
        <li><a href="${pageContext.request.contextPath}/transactions">Transactions</a></li>
    </ul>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>