<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome | EduTrack Portal</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --slate-900: #0f172a;
            --slate-600: #475569;
            --slate-400: #94a3b8;
            --bg-gradient: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
        }

        * { box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-gradient);
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            color: var(--slate-900);
            overflow: hidden;
        }

        .hero-card {
            background: #ffffff;
            width: 100%;
            max-width: 420px;
            padding: 60px 40px;
            border-radius: 24px;
            text-align: center;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.8);
            animation: fadeInScale 0.6s ease-out;
        }

        @keyframes fadeInScale {
            0% { opacity: 0; transform: scale(0.95); }
            100% { opacity: 1; transform: scale(1); }
        }

        /* Abstract Logo Icon */
        .logo-mark {
            width: 64px;
            height: 64px;
            background: var(--primary);
            border-radius: 16px;
            margin: 0 auto 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 15px -3px rgba(79, 70, 229, 0.3);
        }

        .logo-mark::after {
            content: '';
            width: 24px;
            height: 24px;
            border: 4px solid white;
            border-radius: 4px;
            transform: rotate(45deg);
        }

        h1 {
            font-size: 32px;
            font-weight: 800;
            margin: 0 0 8px 0;
            letter-spacing: -0.05em;
            color: var(--slate-900);
        }

        .subtitle {
            font-size: 16px;
            color: var(--slate-600);
            margin-bottom: 40px;
            line-height: 1.5;
        }

        .btn-primary {
            display: block;
            text-decoration: none;
            font-size: 16px;
            font-weight: 700;
            background: var(--primary);
            color: white;
            padding: 16px;
            border-radius: 12px;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.2);
        }

        .btn-primary:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(79, 70, 229, 0.4);
        }

        .footer-note {
            margin-top: 32px;
            font-size: 12px;
            font-weight: 600;
            color: var(--slate-400);
            text-transform: uppercase;
            letter-spacing: 0.1em;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .pulse {
            width: 8px;
            height: 8px;
            background: #10b981;
            border-radius: 50%;
            display: inline-block;
            box-shadow: 0 0 0 rgba(16, 185, 129, 0.4);
            animation: pulse-green 2s infinite;
        }

        @keyframes pulse-green {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }
    </style>
</head>

<body>

    <div class="hero-card">
        <div class="logo-mark"></div>
        
        <h1>EduTrack</h1>
        <p class="subtitle">Secure management for academic records and semester tracking.</p>

        <a href="login.jsp" class="btn-primary">Sign In to Portal</a>

        <div class="footer-note">
            <span class="pulse"></span>
            System Online
        </div>
    </div>

</body>
</html>