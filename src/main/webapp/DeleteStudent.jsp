<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Session Security Check
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");

    if(user == null || !"admin".equals(role)){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terminate Account | EduTrack Pro</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4f46e5;
            --bg-gray: #f8fafc;
            --text-main: #0f172a;
            --danger: #ef4444;
            --border: #e2e8f0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-gray);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .delete-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            border: 1px solid var(--border);
        }

        .header { text-align: center; margin-bottom: 30px; }
        .header h2 { color: var(--danger); margin: 0; font-size: 24px; font-weight: 800; }
        .header p { color: #64748b; font-size: 14px; margin-top: 8px; }

        .warning-box {
            background: #fff1f2;
            border-left: 4px solid var(--danger);
            padding: 15px;
            margin-bottom: 25px;
            font-size: 13px;
            color: #991b1b;
            border-radius: 4px;
        }

        .form-group { margin-bottom: 20px; }
        label { display: block; font-size: 14px; font-weight: 600; margin-bottom: 8px; }
        
        input {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        input:focus { outline: none; border-color: var(--danger); }

        .btn-delete {
            width: 100%;
            padding: 14px;
            background: var(--danger);
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 700;
            cursor: pointer;
            transition: opacity 0.2s;
        }

        .btn-delete:hover { opacity: 0.9; }
        
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #64748b;
            font-size: 14px;
            font-weight: 500;
        }
        
        .back-link:hover { color: var(--text-main); }
    </style>
</head>
<body>

    <div class="delete-card">
        <div class="header">
            <h2>Terminate Student</h2>
            <p>Permanent Account Deletion</p>
        </div>

        <div class="warning-box">
            <strong>Warning:</strong> Deleting this user will automatically wipe all associated <strong>Marks</strong>, <strong>Attendance</strong>, and <strong>Hall Ticket</strong> data.
        </div>

        <form action="DeleteRecordServlet" method="post" onsubmit="return confirm('CRITICAL: Are you absolutely sure you want to wipe this student?')">
            <div class="form-group">
                <label for="student_id">Student ID</label>
                <input type="text" name="student_id" id="student_id" required placeholder="e.g., STU12345" autofocus>
            </div>

            <button type="submit" class="btn-delete">Confirm Permanent Delete</button>
        </form>

        <a href="admin.jsp" class="back-link">← Cancel and Return to Dashboard</a>
    </div>

</body>
</html>