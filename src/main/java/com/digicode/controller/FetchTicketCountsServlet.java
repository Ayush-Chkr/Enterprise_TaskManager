package com.digicode.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

@WebServlet("/fetchTicketCounts")
public class FetchTicketCountsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String plantName = request.getParameter("plantName");
        System.out.println("PLANT NAME:"+ plantName);
        Configuration configuration = new Configuration().configure();
        SessionFactory sessionFactory = configuration.buildSessionFactory();
        Session session = null;
        Transaction transaction = null;

        Map<String, Long> ticketCounts = new HashMap<>();

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            
            if(!"global".equals(plantName)) {
            // Assuming plantHead is fetched based on plantName
            String plantHead = getPlantHeadByPlantName(session, plantName);
            System.out.println("PLANT HEAD:"+ plantHead);

            // Fetch ticket counts
            ticketCounts.put("highSeverityCount", (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TicketsModel WHERE severity = 'High' AND status != 'Completed' AND assignee = :plantHead")
                    .setParameter("plantHead", plantHead)
                    .uniqueResult());

            ticketCounts.put("mediumSeverityCount", (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TicketsModel WHERE severity = 'Medium' AND status != 'Completed' AND assignee = :plantHead")
                    .setParameter("plantHead", plantHead)
                    .uniqueResult());

            ticketCounts.put("lowSeverityCount", (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TicketsModel WHERE severity = 'Low' AND status != 'Completed' AND assignee = :plantHead")
                    .setParameter("plantHead", plantHead)
                    .uniqueResult());

            ticketCounts.put("completedCount", (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TicketsModel WHERE status = 'Completed' AND assignee = :plantHead")
                    .setParameter("plantHead", plantHead)
                    .uniqueResult());

            ticketCounts.put("totalTicketsCount", (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TicketsModel WHERE assignee = :plantHead")
                    .setParameter("plantHead", plantHead)
                    .uniqueResult());

            ticketCounts.put("pendingTicketsCount", (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TicketsModel WHERE status != 'Completed' AND assignee = :plantHead")
                    .setParameter("plantHead", plantHead)
                    .uniqueResult());
            
            }else{
            	ticketCounts.put("highSeverityCount", (Long) session.createQuery(
                        "SELECT COUNT(*) FROM TicketsModel WHERE severity = 'High' AND status != 'Completed' AND created_by = 'Super_Admin' ")
                        .uniqueResult());

                ticketCounts.put("mediumSeverityCount", (Long) session.createQuery(
                        "SELECT COUNT(*) FROM TicketsModel WHERE severity = 'Medium' AND status != 'Completed' AND created_by = 'Super_Admin'")
                        .uniqueResult());

                ticketCounts.put("lowSeverityCount", (Long) session.createQuery(
                        "SELECT COUNT(*) FROM TicketsModel WHERE severity = 'Low' AND status != 'Completed' AND created_by = 'Super_Admin' ")
                        .uniqueResult());

                ticketCounts.put("completedCount", (Long) session.createQuery(
                        "SELECT COUNT(*) FROM TicketsModel WHERE status = 'Completed' AND created_by = 'Super_Admin'")
                        .uniqueResult());

                ticketCounts.put("totalTicketsCount", (Long) session.createQuery(
                        "SELECT COUNT(*) FROM TicketsModel WHERE created_by = 'Super_Admin' ")
                        .uniqueResult());

                ticketCounts.put("pendingTicketsCount", (Long) session.createQuery(
                        "SELECT COUNT(*) FROM TicketsModel WHERE status != 'Completed' AND created_by = 'Super_Admin'")
                        .uniqueResult());
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        Gson gson = new Gson();
        String json = gson.toJson(ticketCounts);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }

    private String getPlantHeadByPlantName(Session session, String plantName) {
        return (String) session.createQuery(
                "SELECT plantHead FROM PlantModel WHERE plantName = :plantName")
                .setParameter("plantName", plantName)
                .uniqueResult();
    }
}
