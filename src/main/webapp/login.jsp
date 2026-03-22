<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | EduTrack Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #4f46e5; --primary-hover: #4338ca; --bg-gray: #f8fafc; --text-main: #1e293b; --text-muted: #64748b; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-gray); margin: 0; display: flex; align-items: center; justify-content: center; height: 100vh; color: var(--text-main); }
        .login-card { background: white; width: 100%; max-width: 400px; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05); border: 1px solid #e2e8f0; }
        .header { text-align: center; margin-bottom: 32px; }
        .header h2 { font-size: 24px; font-weight: 700; margin: 0 0 8px 0; }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-size: 14px; font-weight: 500; margin-bottom: 6px; }
        
        input[type="text"], input[type="password"] { 
            width: 100%; padding: 10px 12px; border: 1px solid #d1d5db; border-radius: 8px; 
            font-size: 14px; box-sizing: border-box; outline: none; transition: all 0.2s;
            background-color: white !important; /* Forces background to stay white */
        }
        
        /* 🛑 Fix for browser autofill background colors */
        input:-webkit-autofill,
        input:-webkit-autofill:hover, 
        input:-webkit-autofill:focus {
            -webkit-box-shadow: 0 0 0px 1000px white inset !important;
            -webkit-text-fill-color: var(--text-main) !important;
        }

        input:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1); }
        input[type="submit"] { width: 100%; background: var(--primary); color: white; border: none; padding: 12px; font-size: 15px; font-weight: 600; border-radius: 8px; cursor: pointer; margin-top: 10px; }
        .error-msg { color: #ef4444; background: #fee2e2; padding: 10px; border-radius: 6px; font-size: 13px; margin-bottom: 20px; text-align: center; }
    </style>
</head>
<body>
<div class="login-card">
    <div class="header">
        <h2>EduTrack Portal</h2>
        <p>Please enter your credentials</p>
    </div>

    <% if(request.getParameter("error") != null) { %>
        <div class="error-msg">Invalid Email or Password</div>
    <% } %>

    <form action="login" method="post" autocomplete="off">
        <div class="form-group">
            <label>Email Address</label>
            <input type="text" name="email" placeholder="admin@edutrack.com" autocomplete="new-password" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="••••••••" autocomplete="new-password" required>
        </div>
        <input type="submit" value="Sign In">
    </form>

    <div style="text-align: center; margin-top: 24px; font-size: 13px; color: var(--text-muted);">
        Secure Academic Management System
    </div>
</div>
</body>
</html>