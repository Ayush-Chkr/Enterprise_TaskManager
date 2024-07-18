package com.digicode.controller;

import com.digicode.model.EmployeeModel;
import com.digicode.model.TicketsModel;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.text.ParseException;

@WebServlet("/CreateTaskServlet")
public class CreateTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        // Initialize Hibernate session factory
        sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    }

    @Override
    public void destroy() {
        // Clean up Hibernate session factory
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Process form data
    	
    	Session hibernateSession = sessionFactory.openSession();
    	Transaction transaction = null;
    	
        String groupName = request.getParameter("groupName");
        String subgroupName = request.getParameter("subgroupName");
        String ticketName = request.getParameter("ticketName");
        String dueDateStr = request.getParameter("dueDate");
        String severity = request.getParameter("severity");
        String assignedToId = request.getParameter("assignedTo");

        // Parse due date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date sqlDate = null;
        
        try {
            // Parse the date string to java.util.Date
            Date utilDate = sdf.parse(dueDateStr);
            
            // Convert java.util.Date to java.sql.Date
            sqlDate = new java.sql.Date(utilDate.getTime());
            
        } catch (ParseException e) {
            e.printStackTrace();
        }
       
        org.hibernate.Query query = hibernateSession.createQuery("FROM TicketsModel WHERE ticket_name= :tname and assignee is null ");
        query.setParameter("tname", ticketName);
        TicketsModel default_ticket = (TicketsModel) query.uniqueResult();
        		
        
        // Prepare task object
        TicketsModel task = new TicketsModel();
        task.setTicketName(default_ticket.getTicketName());
        task.setTicketDescription(default_ticket.getTicketDescription());
        task.setCreatedAt(new Date());
        task.setUpdatedAt(new Date());
        task.setCreatedBy("Super_Admin");
        task.setUpdatedBy("Super_Admin");
        task.setManager("Super_Admin");
        task.setSeverity(severity);
        task.setStatus("pending");
        task.setAssignee(assignedToId);
        task.setDueDate(sqlDate);
        

        // Persist task using Hibernate
        Session session = sessionFactory.openSession();
        
        try {
            transaction = session.beginTransaction();
            session.save(task);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }

        // Respond to client
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Task assigned successfully!");
    }
}
