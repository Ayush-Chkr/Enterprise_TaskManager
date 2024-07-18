package com.digicode.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.digicode.model.TaskSubgroupModel;
import com.digicode.model.TasksGroupModel;
import com.digicode.model.TicketsModel;

@WebServlet("/CreateGroupServlet")
public class CreateGroupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        // Initialize Hibernate SessionFactory
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    @Override
    public void destroy() {
        // Close Hibernate SessionFactory
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Session session = null;
        Transaction transaction = null;
        
        try {
            // Retrieve form data
            String groupName = request.getParameter("groupName");
            String subgroupName = request.getParameter("subgroupName");
            String ticketName = request.getParameter("tickets");
            String ticketDescription = request.getParameter("description");
            
            // Testing
            System.out.println("Group: " + groupName);
            System.out.println("SubGroup: " + subgroupName);
            System.out.println("Ticket: " + ticketName);
            System.out.println("Description: " + ticketDescription);

            // Initialize Hibernate session and transaction
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            // Check if group exists
            TasksGroupModel group = fetchOrCreateGroup(session, groupName);

            // Check if subgroup exists under the retrieved group or independently
            TaskSubgroupModel subgroup = fetchOrCreateSubgroup(session, group, subgroupName);
            
            // Check if ticket already exists in the subgroup
            boolean ticketExists = (Long) session.createQuery(
                "SELECT COUNT(*) FROM TicketsModel WHERE ticketName = :ticketName AND taskSubgroup = :subgroup")
                .setParameter("ticketName", ticketName)
                .setParameter("subgroup", subgroup)
                .uniqueResult() > 0;
            
            if (ticketExists) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Ticket '" + ticketName + "' already exists in the subgroup.");
            } else {
                // Create and add ticket to the subgroup
                TicketsModel ticket = new TicketsModel();
                ticket.setTicketName(ticketName.trim());
                ticket.setTicketDescription(ticketDescription.trim());
                ticket.setTaskSubgroup(subgroup);
                
                subgroup.addTicket(ticket);
                session.saveOrUpdate(subgroup);

                // Commit the transaction
                transaction.commit();
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Ticket added successfully.");
            }
            
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("An error occurred while adding the ticket.");
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    private TasksGroupModel fetchOrCreateGroup(Session session, String groupName) {
        TasksGroupModel group = (TasksGroupModel) session.createQuery("FROM TasksGroupModel WHERE groupName = :groupName")
                .setParameter("groupName", groupName)
                .uniqueResult();

        if (group == null) {
            group = new TasksGroupModel();
            group.setGroupName(groupName);
            session.save(group);
        }

        return group;
    }

    private TaskSubgroupModel fetchOrCreateSubgroup(Session session, TasksGroupModel group, String subgroupName) {
        TaskSubgroupModel subgroup = (TaskSubgroupModel) session.createQuery(
                "FROM TaskSubgroupModel WHERE subgroupName = :subgroupName AND parentGroup = :group")
                .setParameter("subgroupName", subgroupName)
                .setParameter("group", group)
                .uniqueResult();
        
        if (subgroup == null) {
            subgroup = new TaskSubgroupModel();
            subgroup.setSubgroupName(subgroupName);
            subgroup.setParentGroup(group);
            session.save(subgroup);
        }

        return subgroup;
    }
}
