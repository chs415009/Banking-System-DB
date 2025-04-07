<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Edit Loan</title>
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

    <h2>Edit Loan</h2>
    <a href="${pageContext.request.contextPath}/loans">Back to List</a> |
    <a href="${pageContext.request.contextPath}/loans/${loan.instrumentId}">View Details</a>
    
    <c:if test="${not empty errorMessage}">
        <div style="color: red; margin: 10px 0;">
            ${errorMessage}
        </div>
    </c:if>
    
    <form:form action="${pageContext.request.contextPath}/loans/${loan.instrumentId}" method="post" modelAttribute="loan">
        <form:hidden path="instrumentId"/>
        <form:hidden path="instrumentType"/>
        <form:hidden path="startDate"/>
        <form:hidden path="endDate"/>
        
        <table>
            <tr>
                <td>Processed By Employee:</td>
                <td>
                    <form:select path="processedByEmployee.employeeId" required="true">
                        <c:forEach items="${employees}" var="employee">
                            <form:option value="${employee.employeeId}" label="${employee.firstName} ${employee.lastName}"/>
                        </c:forEach>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td>Loan Type:</td>
                <td>
                    <form:select path="loanType" required="true">
                        <form:option value="Student" label="Student Loan"/>
                        <form:option value="Vehicle" label="Vehicle Loan"/>
                        <form:option value="Mortgage" label="Mortgage Loan"/>
                        <form:option value="Business" label="Business Loan"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td>Loan Amount:</td>
                <td><form:input path="loanAmount" required="true" type="number" step="0.01"/></td>
            </tr>
            <tr>
                <td>Interest Rate (%):</td>
                <td><form:input path="interestRate" required="true" type="number" step="0.01"/></td>
            </tr>
            <tr>
                <td>Term (Months):</td>
                <td><form:input path="term" required="true" type="number"/></td>
            </tr>
            <tr>
                <td>Loan Status:</td>
                <td>
                    <form:select path="loanStatus" required="true">
                        <form:option value="Active" label="Active"/>
                        <form:option value="Closed" label="Closed"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Update Loan</button>
                    <a href="${pageContext.request.contextPath}/loans/${loan.instrumentId}">Cancel</a>
                </td>
            </tr>
        </table>
    </form:form>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>