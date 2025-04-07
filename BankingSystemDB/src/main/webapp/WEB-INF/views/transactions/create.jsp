<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Create Transaction</title>
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

    <h2>Create New Transaction</h2>
    <a href="${pageContext.request.contextPath}/transactions">Back to List</a>
    
    <c:if test="${not empty errorMessage}">
        <div style="color: red; margin: 10px 0;">
            ${errorMessage}
        </div>
    </c:if>
    
    <form:form action="${pageContext.request.contextPath}/transactions" method="post" modelAttribute="transaction">
        <table>
            <tr>
                <td>Instrument:</td>
                <td>
                    <select name="instrument.instrumentId" required>
                        <option value="">-- Select Instrument --</option>
                        <optgroup label="Accounts">
                            <c:forEach items="${accounts}" var="account">
                                <option value="${account.instrumentId}">Account #${account.accountNumber} (${account.accountType})</option>
                            </c:forEach>
                        </optgroup>
                        <optgroup label="Loans">
                            <c:forEach items="${loans}" var="loan">
                                <option value="${loan.instrumentId}">Loan #${loan.instrumentId} (${loan.loanType})</option>
                            </c:forEach>
                        </optgroup>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Instrument Type:</td>
                <td>
                    <form:select path="instrumentType" required="true">
                        <form:option value="" label="-- Select Type --"/>
                        <form:option value="Account" label="Account"/>
                        <form:option value="Loan" label="Loan"/>
                        <form:option value="Credit Card" label="Credit Card"/>
                        <form:option value="Insurance" label="Insurance"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td>Transaction Type:</td>
                <td>
                    <form:select path="transactionType" required="true">
                        <form:option value="" label="-- Select Type --"/>
                        <form:option value="Deposit" label="Deposit"/>
                        <form:option value="Withdrawal" label="Withdrawal"/>
                        <form:option value="Payment" label="Payment"/>
                        <form:option value="Transfer" label="Transfer"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td>Amount:</td>
                <td><form:input path="amount" required="true" type="number" step="0.01"/></td>
            </tr>
            <tr>
                <td>Description:</td>
                <td><form:textarea path="description" rows="3" cols="30"/></td>
            </tr>
            <tr>
                <td>Status:</td>
                <td>
                    <form:select path="status" required="true">
                        <form:option value="Pending" label="Pending"/>
                        <form:option value="Completed" label="Completed"/>
                        <form:option value="Failed" label="Failed"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Create Transaction</button>
                    <a href="${pageContext.request.contextPath}/transactions">Cancel</a>
                </td>
            </tr>
        </table>
    </form:form>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>