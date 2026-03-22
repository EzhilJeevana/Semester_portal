<%@ page import="java.sql.*, com.edutrack.portal.db.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Attendance | EduTrack Admin</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
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
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
        }

        header {
            margin-bottom: 32px;
            text-align: left;
            border-bottom: 1px solid var(--border);
            padding-bottom: 20px;
        }

        h2 {
            font-size: 24px;
            font-weight: 700;
            margin: 0;
            letter-spacing: -0.025em;
        }

        p {
            color: var(--text-muted);
            font-size: 14px;
            margin-top: 4px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 14px;
        }

        th {
            background-color: #f1f5f9;
            color: var(--text-muted);
            font-weight: 600;
            padding: 12px 16px;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.05em;
        }

        td {
            padding: 16px;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        tr:hover {
            background-color: #f8fafc;
        }

        input[type="number"] {
            width: 70px;
            padding: 8px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            outline: none;
            font-family: inherit;
        }

        input[type="number"]:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        input[type="submit"] {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: background 0.2s;
        }

        input[type="submit"]:hover {
            background-color: var(--primary-hover);
        }

        .back-link {
            display: inline-block;
            margin-top: 24px;
            text-decoration: none;
            color: var(--text-muted);
            font-size: 14px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: var(--primary);
        }

        .badge {
            font-family: monospace;
            background: #f1f5f9;
            padding: 2px 6px;
            border-radius: 4px;
            color: #475569;
        }
    </style>
</head>
<body>

<div class="container">
    <header>
        <h2>Update Attendance Records</h2>
        <p>Modify percentage logs for active students in the current semester.</p>
    </header>

    <%
        try {
            Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM attendance");
    %>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Student ID</th>
                <th>Subject</th>
                <th>Attendance %</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
        while(rs.next()){
        %>
        <tr>
            <form action="UpdateAttendanceServlet" method="post">
                <td>
                    <span class="badge"><%=rs.getInt("id")%></span>
                    <input type="hidden" name="id" value="<%=rs.getInt("id")%>">
                </td>
                <td style="font-weight: 500;"><%=rs.getString("student_id")%></td>
                <td><%=rs.getString("subject")%></td>
                <td>
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <input type="number" name="attendance_percentage" value="<%=rs.getInt("attendance_percentage")%>" min="0" max="100">
                        <span style="color: #94a3b8;">%</span>
                    </div>
                </td>
                <td><input type="submit" value="Update Record"></td>
            </form>
        </tr>
        <%
        }
        rs.close();
        st.close();
        con.close();
        } catch(Exception e) {
            out.println("<p style='color:red;'>Error loading records: " + e.getMessage() + "</p>");
        }
        %>
        </tbody>
    </table>

    <a href="admin.jsp" class="back-link">← Return to Admin Dashboard</a>
</div>

</body>
</html>