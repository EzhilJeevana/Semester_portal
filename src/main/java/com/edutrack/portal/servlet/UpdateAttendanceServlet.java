package com.edutrack.portal.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.edutrack.portal.db.DBConnection;

@WebServlet("/UpdateAttendanceServlet")
public class UpdateAttendanceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Fetch parameters
        String idStr = request.getParameter("id");
        String attendanceStr = request.getParameter("attendance_percentage");

        // 2. Use Try-With-Resources (Closes Connection & PS automatically)
        try (Connection con = DBConnection.getConnection()) {
            
            String query = "UPDATE attendance SET attendance_percentage=? WHERE id=?";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                
                // Parse strings to integers
                int attendanceVal = Integer.parseInt(attendanceStr);
                int recordId = Integer.parseInt(idStr);

                ps.setInt(1, attendanceVal);
                ps.setInt(2, recordId);

                int rowsUpdated = ps.executeUpdate();

                if (rowsUpdated > 0) {
                    // Redirect with success message
                    response.sendRedirect("UpdateAttendance.jsp?msg=success");
                } else {
                    response.sendRedirect("UpdateAttendance.jsp?msg=notfound");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Redirect with error message
            response.sendRedirect("UpdateAttendance.jsp?msg=error");
        }
    }
}