<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");

    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<String[]> list = (ArrayList<String[]>) request.getAttribute("attendanceList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance Records | EduTrack</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #4f46e5;
            --bg-gray: #f8fafc;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-gray);
            margin: 0;
            padding: 40px 20px;
            color: var(--text-main);
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
        }

        header {
            margin-bottom: 24px;
            text-align: left;
            border-bottom: 1px solid var(--border);
            padding-bottom: 16px;
        }

        h2 {
            font-size: 22px;
            font-weight: 700;
            margin: 0;
            letter-spacing: -0.025em;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            margin-top: 20px;
        }

        th {
            background-color: #f1f5f9;
            color: var(--text-muted);
            font-weight: 600;
            padding: 12px 16px;
            text-transform: uppercase;
            font-size: 11px;
            letter-spacing: 0.05em;
        }

        td {
            padding: 16px;
            border-bottom: 1px solid var(--border);
            font-size: 14px;
        }

        .pct-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 12px;
        }

        .pct-high { background: #ecfdf5; color: #059669; }
        .pct-low { background: #fef2f2; color: #dc2626; }

        .nav-footer {
            margin-top: 32px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
            font-size: 14px;
        }

        .btn-link {
            text-decoration: none;
            color: var(--primary);
            font-weight: 600;
            transition: color 0.2s;
        }

        .btn-link:hover { color: #4338ca; text-decoration: underline; }

        .empty-state {
            padding: 40px;
            text-align: center;
            color: var(--text-muted);
            font-style: italic;
        }
    </style>
</head>
<body>

<div class="container">
    <header>
        <h2>Attendance Report</h2>
    </header>

    <table>
        <thead>
            <tr>
                <th>Student ID</th>
                <th>Subject Name</th>
                <th>Attendance %</th>
            </tr>
        </thead>
        <tbody>
        <%
        if(list != null && !list.isEmpty()){
            for(String[] row : list){
                int pct = 0;
                try { pct = Integer.parseInt(row[2].replace("%", "").trim()); } catch(Exception e) {}
                String badgeClass = (pct >= 75) ? "pct-high" : "pct-low";
        %>
        <tr>
            <td style="font-weight: 600;"><%= row[0] %></td>
            <td><%= row[1] %></td>
            <td>
                <span class="pct-badge <%= badgeClass %>">
                    <%= row[2] %>%
                </span>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="3" class="empty-state">No attendance records found for this user.</td>
        </tr>
        <%
        }
        %>
        </tbody>
    </table>

    <div class="nav-footer">
        <% if("admin".equals(role)) { %>
            <a href="admin.jsp" class="btn-link">Back to Dashboard</a>
            <span style="color: #cbd5e1; margin: 0 10px;">|</span>
            <a href="UpdateAttendance.jsp" class="btn-link">Update Records</a>
        <% } else { %>
            <a href="student.jsp" class="btn-link">Back to Dashboard</a>
        <% } %>
    </div>
</div>

</body>
</html>