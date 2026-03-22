<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");

    // Security Check
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
    <title>Admin Dashboard | EduTrack Pro</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --bg-gray: #f8fafc;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --danger: #ef4444;
            --success: #10b981;
            --warning: #f59e0b;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-gray);
            margin: 0;
            color: var(--text-main);
            min-height: 100vh;
        }

        .navbar {
            background: white;
            padding: 16px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .brand { font-size: 20px; font-weight: 800; color: var(--primary); letter-spacing: -0.5px; }

        .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }

        /* Enhanced Alert System */
        .alert {
            padding: 16px;
            border-radius: 12px;
            margin-bottom: 30px;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            animation: slideDown 0.4s ease-out;
        }
        @keyframes slideDown { from { transform: translateY(-20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        
        .alert-success { background: #ecfdf5; color: #065f46; border: 1px solid #a7f3d0; }
        .alert-error { background: #fef2f2; color: #991b1b; border: 1px solid #fecaca; }
        .alert-warning { background: #fffbeb; color: #92400e; border: 1px solid #fef3c7; }

        .welcome-header { margin-bottom: 40px; }
        .welcome-header h2 { font-size: 32px; font-weight: 800; margin: 0; letter-spacing: -1px; }
        .welcome-header p { color: var(--text-muted); margin-top: 8px; font-size: 16px; }

        .module-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
        }

        .module-card {
            background: white;
            padding: 28px;
            border-radius: 20px;
            border: 1px solid var(--border);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .module-card:hover {
            border-color: var(--primary);
            transform: translateY(-6px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
        }

        .category-label { font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 12px; }
        .card-title { font-size: 20px; font-weight: 700; margin-bottom: 24px; }

        .action-list { display: flex; flex-direction: column; gap: 12px; }

        .action-link {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 20px;
            background: #f8fafc;
            color: var(--text-main);
            text-decoration: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            border: 1px solid var(--border);
            transition: all 0.2s;
        }

        .action-link:hover { background: var(--primary); color: white; border-color: var(--primary); }

        .action-link.danger-zone { color: var(--danger); border-color: #fee2e2; }
        .action-link.danger-zone:hover { background: var(--danger); color: white; border-color: var(--danger); }

        .logout-btn { color: var(--danger); text-decoration: none; font-weight: 700; font-size: 14px; padding: 10px 20px; border-radius: 10px; border: 1px solid transparent; transition: 0.2s; }
        .logout-btn:hover { background: #fef2f2; border-color: #fecaca; }
        
        .divider { height: 1px; background: var(--border); margin: 8px 0; opacity: 0.5; }
    </style>
</head>
<body>

    <nav class="navbar">
        <div class="brand">EduTrack Pro</div>
        <div style="display: flex; align-items: center; gap: 20px;">
            <span style="font-size: 13px; font-weight: 600; color: var(--text-muted);">Admin Session Active</span>
            <a href="logout" class="logout-btn">Sign Out</a>
        </div>
    </nav>

    <div class="container">
        
        <% 
            String msg = request.getParameter("msg");
            if("added".equals(msg)) { %> 
                <div class="alert alert-success">✨ User account created successfully!</div> 
            <% } else if("deleted".equals(msg)) { %> 
                <div class="alert alert-success">🗑️ Records wiped successfully (Cascade complete).</div> 
            <% } else if("notfound".equals(msg)) { %> 
                <div class="alert alert-warning">🔍 No records found for that Student ID.</div> 
            <% } else if("error".equals(msg)) { %> 
                <div class="alert alert-error">⚠️ System Error: Could not process request. Check SQL Constraints.</div> 
            <% } else if("invalid".equals(msg)) { %> 
                <div class="alert alert-warning">❗ Please enter a valid Student ID.</div> 
            <% }
        %>

        <header class="welcome-header">
            <h2>System Administration</h2>
            <p>Managing EduTrack ecosystem as <strong><%= (user != null) ? user : "Admin" %></strong></p>
        </header>

        <div class="module-grid">
            
            <div class="module-card">
                <div class="category-label" style="color: #8b5cf6;">Identity</div>
                <div class="card-title">User Accounts</div>
                <div class="action-list">
                    <a href="addStudent.jsp" class="action-link">Add New Student</a>
                    <div class="divider"></div>
                    <a href="DeleteStudent.jsp" class="action-link danger-zone">Terminate Records</a>
                </div>
            </div>

            <div class="module-card">
                <div class="category-label" style="color: #2563eb;">Operations</div>
                <div class="card-title">Attendance</div>
                <div class="action-list">
                    <a href="addAttendance.jsp" class="action-link">Add New Log</a>
                    <a href="UpdateAttendance.jsp" class="action-link">Modify Records</a>
                </div>
            </div>

            <div class="module-card">
                <div class="category-label" style="color: #dc2626;">Academic</div>
                <div class="card-title">Marks & Grades</div>
                <div class="action-list">
                    <a href="AddMarks.jsp" class="action-link">Enter Marks</a>
                    <a href="UpdateMarks.jsp" class="action-link">Edit Grade Data</a>
                </div>
            </div>

            <div class="module-card">
                <div class="category-label" style="color: #16a34a;">Assessment</div>
                <div class="card-title">Hall Tickets</div>
                <div class="action-list">
                    <a href="addHallTicket.jsp" class="action-link">Generate Admit Cards</a>
                </div>
            </div>

        </div> 
    </div>

</body>
</html>