package com.digicode.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.digicode.model.EmployeeModel;
import com.digicode.model.TicketsModel;

public class LoginServiceImpl {
	
	String user_role=null;
	
    Configuration configuration = new Configuration().configure();
    SessionFactory sessionFactory = configuration.buildSessionFactory();

    public boolean chkcredentials(String user, String pass) {
        boolean res = false;
        Session session = null;
        Transaction transaction = null;
        
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            Query query = session.createQuery("from EmployeeModel where userId=:username and password=:pass");
            query.setParameter("username", user);
            query.setParameter("pass", pass);
            EmployeeModel usrModelObj = (EmployeeModel) query.uniqueResult();

            if (usrModelObj != null) {
                res = true;
                
                System.out.println("User: " + usrModelObj.getUserId());
                user_role= usrModelObj.getPosition();
                
            } else {
                System.out.println("User: err");
                res = false;
            }
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            System.out.println(e.getMessage());
            System.out.println("error");
        } finally {
            if (session != null) session.close();
        }
        return res;
    }
    
    public EmployeeModel getUserById(String userId) {
        Session session = null;
        EmployeeModel user = null;
        try {
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            Object result = session.get(EmployeeModel.class, userId);
            transaction.commit();

            if (result != null && result instanceof EmployeeModel) {
                user = (EmployeeModel) result;
            }
        } catch (HibernateException e) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }

        return user;
    }


    @SuppressWarnings("unchecked")
    public List<EmployeeModel> listAllEmployee() {
        List<EmployeeModel> usrModelObj = new ArrayList<>();
        Session session = null;
        Transaction transaction = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            Query query = session.createQuery("from EmployeeModel");
            usrModelObj = query.list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            System.out.println(e.getMessage());
        } finally {
            if (session != null) session.close();
        }
        return usrModelObj;
    }

    @SuppressWarnings("unchecked")
    public List<TicketsModel> listAllTasks() {
        List<TicketsModel> taskModelObj = new ArrayList<>();
        Session session = null;
        Transaction transaction = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            Query query = session.createQuery("from TicketsModel");
            taskModelObj = query.list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            System.out.println(e.getMessage());
        } finally {
            if (session != null) session.close();
        }
        return taskModelObj;
    }
    
    public String getUserRole() {
        return user_role;
    }

	@SuppressWarnings("unchecked")
	public List<EmployeeModel> listEmployeesByAdmin(String adminId) {
		List<EmployeeModel> usrModelObj = new ArrayList<>();
        Session session = null;
        Transaction transaction = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            Query query = session.createQuery("from EmployeeModel where employer=:admin");
            query.setParameter("admin", adminId);
            usrModelObj = query.list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            System.out.println(e.getMessage());
        } finally {
            if (session != null) session.close();
        }
        return usrModelObj;
	}
}



