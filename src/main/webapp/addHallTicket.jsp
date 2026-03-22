<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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
    <title>Exam Management | EduTrack Admin</title>
    
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
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            color: var(--text-main);
            padding: 20px;
        }

        .form-card {
            background: white;
            width: 100%;
            max-width: 480px;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
        }

        header {
            text-align: center;
            margin-bottom: 32px;
        }

        h2 { font-size: 24px; font-weight: 700; margin: 0; letter-spacing: -0.025em; }
        .subtitle { font-size: 14px; color: var(--text-muted); margin-top: 6px; }

        .form-group { margin-bottom: 18px; text-align: left; }

        label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 8px;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        input[type="text"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #d1d5db;
            border-radius: 10px;
            font-size: 14px;
            box-sizing: border-box;
            transition: all 0.2s ease;
            outline: none;
            background-color: #ffffff;
            font-family: inherit;
        }

        input:focus, select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        .btn-submit {
            width: 100%;
            background: var(--primary);
            color: white;
            border: none;
            padding: 14px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 15px;
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.2);
        }

        .btn-submit:hover {
            background: var(--primary-hover);
            transform: translateY(-1px);
        }

        .footer-nav { text-align: center; margin-top: 24px; }
        .back-link { text-decoration: none; font-size: 14px; color: var(--text-muted); font-weight: 500; }
        .back-link:hover { color: var(--primary); }
    </style>
</head>

<body>

<div class="form-card">
    <header>
        <h2>Exam Scheduling</h2>
        <p class="subtitle">Authorize and issue hall ticket details.</p>
    </header>

    <form action="AddHallTicketServlet" method="post">
        
        <div class="form-group">
            <label for="student_id">Student Registration ID</label>
            <input type="text" id="student_id" name="student_id" placeholder="e.g. STU001" required>
        </div>

        <div class="form-group">
            <label for="subject">Subject Title</label>
            <input type="text" id="subject" name="subject" placeholder="e.g. Compiler Design" required>
        </div>

        <div class="form-group">
            <label for="academic_session">Academic Year/Session</label>
            <input type="text" id="academic_session" name="academic_session" placeholder="e.g. Spring Semester 2026" required>
        </div>

        <div class="form-group">
            <label for="session_time">Exam Session (FN/AN)</label>
            <select id="session_time" name="session_time" required>
                <option value="" disabled selected>Select Time Slot</option>
                <option value="FN">Forenoon (FN)</option>
                <option value="AN">Afternoon (AN)</option>
            </select>
        </div>

        <div class="form-group">
            <label for="exam_date">Examination Date</label>
            <input type="date" id="exam_date" name="exam_date" required>
        </div>

        <button type="submit" class="btn-submit">Authorize Hall Ticket</button>

    </form>

    <div class="footer-nav">
        <a href="admin.jsp" class="back-link">Return to Dashboard</a>
    </div>
</div>

</body>
</html>