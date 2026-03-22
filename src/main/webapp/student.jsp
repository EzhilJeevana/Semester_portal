<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Using 'user' or 'student_id' based on your session logic
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
    <title>Student Portal | EduTrack</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #4f46e5;
            --primary-soft: #eef2ff;
            --bg-gray: #f8fafc;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-gray);
            margin: 0;
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Top Navbar Style */
        .navbar {
            width: 100%;
            background: #ffffff;
            padding: 16px 0;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: center;
            box-shadow: 0 1px 2px rgba(0,0,0,0.03);
        }

        .nav-content {
            width: 100%;
            max-width: 500px;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand-name {
            font-weight: 800;
            font-size: 18px;
            color: var(--primary);
            letter-spacing: -0.5px;
        }

        .status-pill {
            background: #f0fdf4;
            color: #166534;
            font-size: 11px;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 20px;
            text-transform: uppercase;
            border: 1px solid #bbf7d0;
        }

        /* Hero Header */
        .hero {
            text-align: center;
            margin: 48px 0 32px 0;
        }

        .hero h2 {
            margin: 0;
            font-size: 24px;
            font-weight: 700;
            letter-spacing: -0.025em;
        }

        .hero p {
            color: var(--text-muted);
            font-size: 14px;
            margin-top: 8px;
        }

        .container {
            width: 100%;
            max-width: 500px;
            padding: 0 20px;
            box-sizing: border-box;
        }

        .dashboard-grid {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .card-link {
            background: #ffffff;
            padding: 20px 24px;
            border-radius: 12px;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border: 1px solid var(--border);
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card-link:hover {
            border-color: var(--primary);
            background-color: var(--primary-soft);
            transform: translateX(4px);
        }

        .card-info {
            display: flex;
            flex-direction: column;
        }

        .card-title {
            font-weight: 600;
            font-size: 15px;
            color: var(--text-main);
        }

        .card-desc {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 2px;
        }

        .chevron {
            color: var(--text-muted);
            font-size: 18px;
            transition: transform 0.2s;
        }

        .card-link:hover .chevron {
            color: var(--primary);
            transform: translateX(2px);
        }

        .footer-actions {
            margin-top: 40px;
            text-align: center;
        }

        .logout-link {
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            color: #ef4444;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background 0.2s;
            border: 1px solid transparent;
        }

        .logout-link:hover {
            background: #fef2f2;
            border-color: #fee2e2;
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="nav-content">
        <span class="brand-name">EduTrack</span>
        <span class="status-pill">Active Session</span>
    </div>
</nav>

<div class="container">
    <header class="hero">
        <h2>Hi, <%= user %></h2>
        <p>Access your academic performance and documents.</p>
    </header>

    <div class="dashboard-grid">
        <a href="viewAttendance" class="card-link">
            <div class="card-info">
                <span class="card-title">Attendance Overview</span>
                <span class="card-desc">Check your presence percentage</span>
            </div>
            <span class="chevron">
        </a>

        <a href="viewMarks" class="card-link">
            <div class="card-info">
                <span class="card-title">Academic Results</span>
                <span class="card-desc">View latest subject-wise scores</span>
            </div>
            <span class="chevron">
        </a>

        <a href="viewHallTicket.jsp" class="card-link">
            <div class="card-info">
                <span class="card-title">Exam Admit Card</span>
                <span class="card-desc">Download your official hall ticket</span>
            </div>
            <span class="chevron">
        </a>
    </div>

    <div class="footer-actions">
        <a href="logout" class="logout-link">Sign Out</a>
    </div>
</div>

</body>
</html>