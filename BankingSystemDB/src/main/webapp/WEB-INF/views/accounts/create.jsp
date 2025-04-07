<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Create Account</title>
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

    <h2>Create New Account</h2>
    <a href="${pageContext.request.contextPath}/accounts">Back to List</a>
    
    <c:if test="${not empty errorMessage}">
        <div style="color: red; margin: 10px 0;">
            ${errorMessage}
        </div>
    </c:if>
    
    <form:form action="${pageContext.request.contextPath}/accounts" method="post" modelAttribute="account">
        <form:hidden path="instrumentType" value="Account"/>
        <form:hidden path="status" value="Active"/>
        
        <table>
            <tr>
                <td>Branch:</td>
                <td>
                    <form:select path="branch.branchId" required="true">
                        <form:option value="" label="-- Select Branch --"/>
                        <c:forEach items="${branches}" var="branch">
                            <form:option value="${branch.branchId}" label="${branch.branchName}"/>
                        </c:forEach>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td>Customer:</td>
                <td>
                    <select name="customerId" required>
                        <option value="">-- Select Customer --</option>
                        <c:forEach items="${customers}" var="customer">
                            <option value="${customer.customerId}">${customer.firstName} ${customer.lastName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Account Type:</td>
                <td>
                    <form:select path="accountType" required="true">
                        <form:option value="" label="-- Select Type --"/>
                        <form:option value="Savings" label="Savings"/>
                        <form:option value="Checking" label="Checking"/>
                        <form:option value="Money Market" label="Money Market"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td>Account Number:</td>
                <td><form:input path="accountNumber" required="true" type="number"/></td>
            </tr>
            <tr>
                <td>Initial Balance:</td>
                <td><form:input path="balance" required="true" type="number" step="0.01"/></td>
            </tr>
            <tr>
                <td>Interest Rate (%):</td>
                <td><form:input path="interestRate" required="true" type="number" step="0.01"/></td>
            </tr>
            <tr>
                <td>Opening Date:</td>
                <td><form:input path="openingDate" type="date" required="true"/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Create Account</button>
                    <a href="${pageContext.request.contextPath}/accounts">Cancel</a>
                </td>
            </tr>
        </table>
    </form:form>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>