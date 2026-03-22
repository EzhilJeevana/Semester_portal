package com.edutrack.portal.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.edutrack.portal.db.DBConnection;

@WebServlet("/AddHallTicketServlet")
public class AddHallTicketServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get all parameters from the updated form
        String studentId = request.getParameter("student_id");
        String subject = request.getParameter("subject");
        String academicSession = request.getParameter("academic_session");
        String sessionTime = request.getParameter("session_time"); // FN or AN
        String examDateStr = request.getParameter("exam_date");

        try {
            // 2. Convert the date string to SQL Date format
            Date examDate = Date.valueOf(examDateStr); 

            // 3. Establish Database Connection
            Connection con = DBConnection.getConnection();
            
            // 4. Updated Query to include new columns
            String query = "INSERT INTO hall_ticket_info(student_id, subject, academic_session, session_time, exam_date) VALUES (?, ?, ?, ?, ?)";
            
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, studentId);
            ps.setString(2, subject);
            ps.setString(3, academicSession);
            ps.setString(4, sessionTime);
            ps.setDate(5, examDate);

            int rows = ps.executeUpdate();

            // 5. Cleanup and Redirect
            ps.close();
            con.close();

            if(rows > 0){
                // Redirecting back to the form with a success flag
                response.sendRedirect("addHallTicket.jsp?status=success");
            } else {
                response.sendRedirect("addHallTicket.jsp?status=failed");
            }

        } catch(Exception e){
            e.printStackTrace();
            // In a real app, you'd log this and show a friendly error page
            response.sendRedirect("addHallTicket.jsp?status=error");
        }
    }
}