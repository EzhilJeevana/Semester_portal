<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String user = (String) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Records | EduTrack Admin</title>
    
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
            height: 100vh;
            color: var(--text-main);
        }

        .form-card {
            background: white;
            width: 100%;
            max-width: 450px;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
        }

        header {
            text-align: center;
            margin-bottom: 32px;
        }

        h2 {
            font-size: 22px;
            font-weight: 700;
            margin: 0;
            letter-spacing: -0.025em;
        }

        .subtitle {
            font-size: 14px;
            color: var(--text-muted);
            margin-top: 6px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-main);
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
            transition: all 0.2s ease;
            outline: none;
            background-color: #ffffff;
        }

        input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .btn-submit {
            width: 100%;
            background: var(--primary);
            color: white;
            border: none;
            padding: 14px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.2s ease;
            margin-top: 10px;
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.2);
        }

        .btn-submit:hover {
            background: var(--primary-hover);
            transform: translateY(-1px);
        }

        .back-nav {
            text-align: center;
            margin-top: 24px;
        }

        .back-link {
            text-decoration: none;
            font-size: 14px;
            color: var(--text-muted);
            font-weight: 500;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: var(--primary);
        }
    </style>
</head>

<body>

<div class="form-card">
    <header>
        <h2>Record Student Marks</h2>
        <p class="subtitle">Enter internal or external examination scores.</p>
    </header>

    <form action="<%=request.getContextPath()%>/addMarks" method="post">
        
        <div class="form-group">
            <label for="student_id">Student ID</label>
            <input type="text" id="student_id" name="student_id" placeholder="e.g. STU_2026_01" required>
        </div>

        <div class="form-group">
            <label for="subject">Subject</label>
            <input type="text" id="subject" name="subject" placeholder="e.g. Database Management" required>
        </div>

        <div class="form-group">
            <label for="marks">Obtained Marks</label>
            <input type="number" id="marks" name="marks" min="0" max="100" placeholder="0 - 100" required>
        </div>

        <input type="submit" class="btn-submit" value="Save Performance Data">

    </form>

    <div class="back-nav">
        <a href="admin.jsp" class="back-link">← Return to Admin Dashboard</a>
    </div>
</div>

</body>
</html>