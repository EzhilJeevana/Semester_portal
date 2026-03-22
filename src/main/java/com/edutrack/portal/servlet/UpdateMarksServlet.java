package com.edutrack.portal.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.edutrack.portal.db.DBConnection;

@WebServlet("/UpdateMarksServlet")
public class UpdateMarksServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String marks = request.getParameter("marks");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE marks SET marks=? WHERE id=?"
            );
            ps.setInt(1, Integer.parseInt(marks));
            ps.setInt(2, Integer.parseInt(id));

            ps.executeUpdate();
            ps.close();
            con.close();

            response.sendRedirect("UpdateMarks.jsp");

        } catch(Exception e){
            e.printStackTrace();
            response.sendRedirect("UpdateMarks.jsp?msg=error");
        }
    }
}