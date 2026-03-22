<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Student | EduTrack Pro</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #4f46e5; --bg: #f8fafc; --border: #e2e8f0; --text: #1e293b; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; }
        .form-card { background: white; padding: 40px; border-radius: 16px; width: 100%; max-width: 450px; border: 1px solid var(--border); box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
        header { text-align: center; margin-bottom: 30px; }
        h2 { margin: 0; font-size: 24px; color: var(--text); }
        .subtitle { color: #64748b; font-size: 14px; margin-top: 8px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-size: 12px; font-weight: 700; text-transform: uppercase; margin-bottom: 8px; color: #94a3b8; letter-spacing: 0.05em; }
        input, select { width: 100%; padding: 12px; border: 1px solid var(--border); border-radius: 10px; box-sizing: border-box; font-family: inherit; font-size: 15px; transition: all 0.2s; }
        input:focus { border-color: var(--primary); outline: none; box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1); }
        .btn-submit { width: 100%; background: var(--primary); color: white; border: none; padding: 16px; border-radius: 10px; font-weight: 700; cursor: pointer; margin-top: 10px; transition: 0.2s; }
        .btn-submit:hover { background: #4338ca; transform: translateY(-1px); }
        .back-link { display: block; text-align: center; margin-top: 20px; font-size: 14px; color: #64748b; text-decoration: none; }
    </style>
</head>
<body>
    <div class="form-card">
        <header>
            <h2>Register New User</h2>
            <p class="subtitle">Add a student to the central database.</p>
        </header>

        <form action="AddUserServlet" method="post" autocomplete="off">
            <div class="form-group">
                <label>Student ID (Primary Key)</label>
                <input type="text" name="student_id" placeholder="e.g. 2024CS01" autocomplete="off" required>
            </div>
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="Enter full name" autocomplete="off" required>
            </div>
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="student@university.com" autocomplete="off" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" autocomplete="new-password" required>
            </div>
            <div class="form-group">
                <label>System Role</label>
                <select name="role">
                    <option value="student">Student</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <button type="submit" class="btn-submit">Save User to System</button>
        </form>
        <a href="admin.jsp" class="back-link">← Return to Dashboard</a>
    </div>
</body>
</html>