<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Edit Account</title>
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

    <h2>Edit Account</h2>
    <a href="${pageContext.request.contextPath}/accounts">Back to List</a> |
    <a href="${pageContext.request.contextPath}/accounts/${account.instrumentId}">View Details</a>
    
    <c:if test="${not empty errorMessage}">
        <div style="color: red; margin: 10px 0;">
            ${errorMessage}
        </div>
    </c:if>
    
    <form:form action="${pageContext.request.contextPath}/accounts/${account.instrumentId}" method="post" modelAttribute="account">
        <form:hidden path="instrumentId"/>
        <form:hidden path="instrumentType"/>
        
        <table>
            <tr>
                <td>Branch:</td>
                <td>
                    <form:select path="branch.branchId" required="true">
                        <c:forEach items="${branches}" var="branch">
                            <form:option value="${branch.branchId}" label="${branch.branchName}"/>
                        </c:forEach>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td>Account Number:</td>
                <td><form:input path="accountNumber" required="true" readonly="true"/></td>
            </tr>
            <tr>
                <td>Account Type:</td>
                <td>
                    <form:select path="accountType" required="true">
                        <form:option value="Savings" label="Savings"/>
                        <form:option value="Checking" label="Checking"/>
                        <form:option value="Money Market" label="Money Market"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td>Balance:</td>
                <td><form:input path="balance" required="true" type="number" step="0.01"/></td>
            </tr>
            <tr>
                <td>Interest Rate (%):</td>
                <td><form:input path="interestRate" required="true" type="number" step="0.01"/></td>
            </tr>
            <tr>
                <td>Status:</td>
                <td>
                    <form:select path="status" required="true">
                        <form:option value="Active" label="Active"/>
                        <form:option value="Inactive" label="Inactive"/>
                        <form:option value="Closed" label="Closed"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Update Account</button>
                    <a href="${pageContext.request.contextPath}/accounts/${account.instrumentId}">Cancel</a>
                </td>
            </tr>
        </table>
    </form:form>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>