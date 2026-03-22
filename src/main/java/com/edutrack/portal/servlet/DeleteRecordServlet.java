package com.edutrack.portal.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.edutrack.portal.db.DBConnection;

@WebServlet("/DeleteRecordServlet")
public class DeleteRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the ID and remove any accidental spaces
        String studentId = request.getParameter("student_id");
        
        if (studentId == null || studentId.trim().isEmpty()) {
            response.sendRedirect("admin.jsp?msg=invalid");
            return;
        }

        // 2. Database Operation
        String query = "DELETE FROM users WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, studentId.trim());
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                // SUCCESS: Database automatically wipes marks/attendance now
                response.sendRedirect("admin.jsp?msg=deleted");
            } else {
                // FAIL: No student with that exact ID exists
                response.sendRedirect("admin.jsp?msg=notfound");
            }

        } catch (SQLException e) {
            // Log the actual error to your IDE console for debugging
            System.err.println("CRITICAL DELETE ERROR: " + e.getMessage());
            e.printStackTrace(); 
            response.sendRedirect("admin.jsp?msg=error");
        }
    }
}