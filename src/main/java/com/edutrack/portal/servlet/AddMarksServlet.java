package com.edutrack.portal.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.edutrack.portal.db.DBConnection;

@WebServlet("/addMarks")
public class AddMarksServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("student_id");
        String subject = request.getParameter("subject");
        String marksStr = request.getParameter("marks");

        try {
            int marks = Integer.parseInt(marksStr);

            Connection con = DBConnection.getConnection();

            // Insert new marks
            String query = "INSERT INTO marks(student_id, subject, marks) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, studentId);
            ps.setString(2, subject);
            ps.setInt(3, marks);

            int rows = ps.executeUpdate();
            ps.close();
            con.close();

            if(rows > 0){
                response.sendRedirect("admin.jsp");
            } else {
                response.getWriter().println("Failed to insert marks");
            }

        } catch(Exception e){
            e.printStackTrace();
            response.getWriter().println("Error while inserting marks");
        }
    }
}