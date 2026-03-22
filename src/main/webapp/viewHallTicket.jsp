<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.ArrayList" %>
<%
    String studentId = (String) session.getAttribute("student_id");
    if(studentId == null) { 
        response.sendRedirect("login.jsp"); 
        return;
    }

    ArrayList<String[]> infoList = new ArrayList<>();
    String email = "Not Found";
    
    try {
        Connection con = com.edutrack.portal.db.DBConnection.getConnection();
        
        PreparedStatement psUser = con.prepareStatement("SELECT email FROM users WHERE student_id=?");
        psUser.setString(1, studentId);
        ResultSet rsUser = psUser.executeQuery();
        if(rsUser.next()){ email = rsUser.getString("email"); }
        rsUser.close(); psUser.close();

        // Note: If you add a 'session_time' column to your DB, fetch it here
        PreparedStatement psInfo = con.prepareStatement("SELECT subject, exam_date FROM hall_ticket_info WHERE student_id=?");
        psInfo.setString(1, studentId);
        ResultSet rsInfo = psInfo.executeQuery();
        while(rsInfo.next()){
            infoList.add(new String[]{
                rsInfo.getString("subject"), 
                rsInfo.getDate("exam_date").toString()
            });
        }
        rsInfo.close(); psInfo.close();
        con.close();
    } catch(Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hall Ticket | EduTrack</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #4f46e5; --bg-gray: #f8fafc; --text-main: #1e293b; --text-muted: #64748b; --border: #e2e8f0; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-gray); margin: 0; padding: 40px 20px; color: var(--text-main); }
        .hall-ticket { max-width: 800px; margin: 0 auto; background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08); border: 1px solid var(--border); }
        .official-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid var(--primary); padding-bottom: 20px; margin-bottom: 30px; }
        .branding h1 { font-size: 24px; font-weight: 800; margin: 0; color: var(--primary); text-transform: uppercase; }
        .branding p { margin: 2px 0 0 0; font-size: 12px; color: var(--text-muted); letter-spacing: 0.1em; }
        .student-meta { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; background: #f1f5f9; padding: 20px; border-radius: 8px; }
        .meta-item label { display: block; font-size: 11px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; margin-bottom: 4px; }
        .meta-item span { font-size: 15px; font-weight: 600; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { background-color: #f8fafc; color: var(--text-muted); font-weight: 700; padding: 12px 16px; text-transform: uppercase; font-size: 11px; border-bottom: 2px solid var(--border); text-align: left; }
        td { padding: 16px; border-bottom: 1px solid var(--border); font-size: 14px; }
        .actions { margin-top: 30px; display: flex; justify-content: space-between; align-items: center; }
        .btn-print { padding: 12px 24px; background: var(--primary); color: white; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: all 0.2s; }
        .btn-print:hover { background: #4338ca; }
        .back-link { text-decoration: none; font-size: 14px; color: var(--text-muted); font-weight: 500; }
        @media print { body { background: white; padding: 0; } .hall-ticket { box-shadow: none; border: 1px solid #000; width: 100%; } .actions { display: none; } .official-header { border-bottom: 2px solid #000; } }
    </style>
</head>
<body>

<div class="hall-ticket">
    <div class="official-header">
        <div class="branding">
            <h1>EduTrack Portal</h1>
            <p>Official Examination Admit Card</p>
        </div>
        <div style="text-align: right; font-size: 12px; color: #64748b;">Academic Year 2026</div>
    </div>

    <div class="student-meta">
        <div class="meta-item">
            <label>Registration ID</label>
            <span><%=studentId%></span>
        </div>
        <div class="meta-item">
            <label>Registered Email</label>
            <span><%=email%></span>
        </div>
        <div class="meta-item">
            <label>Verification Status</label>
            <span style="color: #059669;">&bull; Authenticated Profile</span>
        </div>
        <div class="meta-item">
            <label>Academic Session</label>
            <span>Spring Semester</span>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th>Subject Name</th>
                <th>Scheduled Date</th>
                <th>Session (FN/AN)</th>
            </tr>
        </thead>
        <tbody>
            <% if(infoList.isEmpty()){ %>
                <tr><td colspan="3" style="text-align:center;">No Exam Schedule Found.</td></tr>
            <% } else { 
                for(String[] row: infoList){ %>
                <tr>
                    <td style="font-weight: 600;"><%=row[0]%></td>
                    <td><%=row[1]%></td>
                    <td style="font-weight: 500; color: var(--primary);">FN</td> 
                </tr>
            <%  } 
               } %>
        </tbody>
    </table>

    <div class="actions">
        <a href="student.jsp" class="back-link">Back to Dashboard</a>
        <button class="btn-print" onclick="window.print()">Print Hall Ticket</button>
    </div>
</div>

</body>
</html>