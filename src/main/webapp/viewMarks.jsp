<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    if(user == null){ 
        response.sendRedirect("login.jsp"); 
        return;
    }

    ArrayList<String[]> list = (ArrayList<String[]>) request.getAttribute("marksList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Results | EduTrack</title>
    
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
            max-width: 850px;
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

        .marks-display {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .progress-bg {
            width: 100px;
            height: 6px;
            background: #e2e8f0;
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: var(--primary);
            border-radius: 10px;
        }

        .grade-badge {
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 700;
            background: #f1f5f9;
            color: #475569;
        }

        .nav-footer {
            margin-top: 32px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
            font-size: 14px;
            display: flex;
            gap: 15px;
        }

        .btn-link {
            text-decoration: none;
            color: var(--primary);
            font-weight: 600;
            transition: color 0.2s;
        }

        .btn-link:hover { text-decoration: underline; }

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
        <h2>Academic Performance Records</h2>
    </header>

    <table>
        <thead>
            <tr>
                <th>Student ID</th>
                <th>Subject</th>
                <th>Obtained Marks</th>
                <th>Performance</th>
            </tr>
        </thead>
        <tbody>
        <%
        if(list != null && !list.isEmpty()){
            for(String[] row : list){
                int marksValue = 0;
                try { marksValue = Integer.parseInt(row[2].trim()); } catch(Exception e) {}
                
                // Simple grade logic for UI flair
                String grade = (marksValue >= 95) ? "O" :(marksValue >= 90) ? "A+" : (marksValue >= 75) ? "A" : (marksValue >= 60) ? "B" : "C";
        %>
        <tr>
            <td style="font-weight: 600; color: #475569;"><%= row[0] %></td>
            <td><%= row[1] %></td>
            <td>
                <span style="font-weight: 700; color: var(--text-main);"><%= row[2] %></span>
                <span style="color: #94a3b8; font-size: 12px;"> / 100</span>
            </td>
            <td>
                <div class="marks-display">
                    <div class="progress-bg">
                        <div class="progress-fill" style="width: <%= marksValue %>%;"></div>
                    </div>
                    <span class="grade-badge"><%= grade %></span>
                </div>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" class="empty-state">No marks records available at this time.</td>
        </tr>
        <%
        }
        %>
        </tbody>
    </table>

    <div class="nav-footer">
        <% if("admin".equals(role)){ %>
            <a href="admin.jsp" class="btn-link">Back to Dashboard</a>
            <span style="color: #e2e8f0;">|</span>
            <a href="UpdateMarks.jsp" class="btn-link">Manage Marks</a>
        <% } else { %>
            <a href="student.jsp" class="btn-link">← Back to Dashboard</a>
        <% } %>
    </div>
</div>

</body>
</html>