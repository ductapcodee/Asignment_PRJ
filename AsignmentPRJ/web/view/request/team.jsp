<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Team Overview</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 30px;
                background: #eef1f7;
            }

            h2, h3 {
                color: #333;
            }

            .container {
                max-width: 1100px;
                margin: auto;
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 2px 12px rgba(0,0,0,0.1);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                border-radius: 10px;
                overflow: hidden;
            }

            th {
                background: #4b67e2;
                color: white;
                padding: 12px;
                text-align: center;
            }

            td {
                background: white;
                padding: 10px;
                border-bottom: 1px solid #ddd;
                text-align: center;
            }

            tr:hover td {
                background: #f1f4ff;
            }

            .badge {
                padding: 6px 10px;
                border-radius: 6px;
                color: white;
                font-size: 12px;
            }

            .approved {
                background: #28a745;
            }
            .pending  {
                background: #ffba00;
            }
            .denied   {
                background: #d9534f;
            }

            .btn-primary-home {
                background: linear-gradient(135deg, #6a5af9 0%, #836fff 100%);
                color: white;
                padding: 10px 22px;
                border-radius: 999px; /* bo tròn đẹp */
                border: none;
                cursor: pointer;
                font-size: 14px;
                font-weight: 600;
                text-decoration: none;
                box-shadow: 0 3px 8px rgba(106, 90, 249, 0.3);
                transition: 0.25s ease;
                display: inline-block;
            }

            /* Hover: sáng hơn + nổi lên */
            .btn-primary-home:hover {
                background: linear-gradient(135deg, #7c6cfa 0%, #9a82ff 100%);
                transform: translateY(-2px);
                box-shadow: 0 7px 18px rgba(106, 90, 249, 0.45);
            }

            ul {
                padding-left: 20px;
            }
        </style>
    </head>

    <body>
        <div class="container">


            <h2>Team Overview</h2>
            <div style="display: flex; justify-content: flex-end; margin-bottom: 16px;">
                <a href="${pageContext.request.contextPath}/home" class="btn-primary-home">
                    Về Trang Chủ
                </a>
            </div>
            <!-- Team Members Table -->
            <h3>Team Members</h3>
            <table>
                <tr>
                    <th>Name</th>
                    <th>Division</th>
                    <th>Supervisor</th>
                    <th>Total Requests</th>
                    <th>Approved</th>
                    <th>Pending</th>
                    <th>Leave Days</th>
                    <th>On Leave Today</th>
                </tr>

                <c:forEach var="emp" items="${teamMembers}">
                    <c:set var="m" value="${metricsMap[emp.id]}" />
                    <tr>
                        <td>${emp.name}</td>
                        <td>${emp.division.dname}</td>
                        <td>
                            <c:choose>
                                <c:when test="${emp.supervisor != null}">${emp.supervisor.name}</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${m.totalRequests}</td>
                        <td><span class="badge approved">${m.approvedRequests}</span></td>
                        <td><span class="badge pending">${m.pendingRequests}</span></td>
                        <td>${m.totalLeaveDays}</td>
                        <td>
                            <c:if test="${m.onLeaveToday}">
                                <span class="badge approved">Yes</span>
                            </c:if>
                            <c:if test="${!m.onLeaveToday}">
                                No
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <!-- Employees On Leave -->
            <h3>Employees On Leave Today</h3>
            <c:if test="${empty onLeaveToday}">
                <p>No one is on leave today ✅</p>
            </c:if>
            <c:if test="${not empty onLeaveToday}">
                <ul>
                    <c:forEach var="e" items="${onLeaveToday}">
                        <li>${e.name}</li>
                        </c:forEach>
                </ul>
            </c:if>

        </div>
    </body>
</html>
