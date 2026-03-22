package com.edutrack.portal.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Destroy session
        HttpSession session = request.getSession(false);

        if(session != null){
            session.invalidate();
        }

        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
}