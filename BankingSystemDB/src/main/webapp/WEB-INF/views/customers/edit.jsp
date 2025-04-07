<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking System - Edit Customer</title>
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

    <h2>Edit Customer</h2>
    <a href="${pageContext.request.contextPath}/customers">Back to List</a> |
    <a href="${pageContext.request.contextPath}/customers/${customer.customerId}">View Details</a>
    
    <c:if test="${not empty errorMessage}">
        <div style="color: red; margin: 10px 0;">
            ${errorMessage}
        </div>
    </c:if>
    
    <form:form action="${pageContext.request.contextPath}/customers/${customer.customerId}" method="post" modelAttribute="customer">
        <form:hidden path="customerId"/>
        
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
                <td>Customer Type:</td>
                <td>
                    <form:select path="customerType" required="true">
                        <form:option value="Individual" label="Individual"/>
                        <form:option value="Business" label="Business"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td>First Name:</td>
                <td><form:input path="firstName" required="true"/></td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td><form:input path="lastName" required="true"/></td>
            </tr>
            <tr>
				<td>Date of Birth:</td>
				<td><form:input path="dateOfBirth" type="date" required="true"/></td>
            </tr>
            <tr>
                <td>SSN:</td>
                <td><form:input path="ssn" maxlength="11"/></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><form:input path="email" type="email"/></td>
            </tr>
            <tr>
                <td>Phone Number:</td>
                <td><form:input path="phoneNumber" maxlength="15"/></td>
            </tr>
            <tr>
                <td>Address Line 1:</td>
                <td><form:input path="addressLine1"/></td>
            </tr>
            <tr>
                <td>Address Line 2:</td>
                <td><form:input path="addressLine2"/></td>
            </tr>
            <tr>
                <td>Zip Code:</td>
                <td><form:input path="zipCode" maxlength="10"/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Update Customer</button>
                    <a href="${pageContext.request.contextPath}/customers/${customer.customerId}">Cancel</a>
                </td>
            </tr>
        </table>
    </form:form>
    
    <footer>
        <p>Banking System Database &copy; 2025</p>
    </footer>
</body>
</html>