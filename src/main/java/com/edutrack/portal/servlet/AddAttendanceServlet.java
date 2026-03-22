package com.edutrack.portal.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.edutrack.portal.db.DBConnection;

@WebServlet("/addAttendance")
public class AddAttendanceServlet extends HttpServlet {

    // ADD THIS: Handles the "View" request to prevent 404/405 errors
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirecting to the JSP page if someone tries to 'GET' this URL
        response.sendRedirect("addAttendance.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("student_id");
        String subject = request.getParameter("subject");
        String percentageStr = request.getParameter("attendance_percentage");

        // Use try-with-resources for better memory management (Professional standard)
        try (Connection con = DBConnection.getConnection()) {
            int percentage = Integer.parseInt(percentageStr);

            // 1. Check for existing record
            String checkQuery = "SELECT id FROM attendance WHERE student_id=? AND subject=?";
            try (PreparedStatement checkPs = con.prepareStatement(checkQuery)) {
                checkPs.setString(1, studentId);
                checkPs.setString(2, subject);
                
                if(checkPs.executeQuery().next()){
                    // CHANGE THIS: Instead of redirecting to Update, 
                    // stay on the page and show a message
                    request.setAttribute("error", "Record already exists for this subject. Use 'Update' instead.");
                    request.getRequestDispatcher("addAttendance.jsp").forward(request, response);
                    return;
                }
            }

            // 2. Insert new attendance
            String query = "INSERT INTO attendance(student_id, subject, attendance_percentage) VALUES (?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, studentId);
                ps.setString(2, subject);
                ps.setInt(3, percentage);

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    // Redirect back to dashboard with a success flag
                    response.sendRedirect(request.getContextPath() + "/admin.jsp?status=success");
                } else {
                    response.sendRedirect(request.getContextPath() + "/addAttendance.jsp?status=fail");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Professional error handling: don't just print to writer, redirect with error
            response.sendRedirect(request.getContextPath() + "/addAttendance.jsp?status=error");
        }
    }
}