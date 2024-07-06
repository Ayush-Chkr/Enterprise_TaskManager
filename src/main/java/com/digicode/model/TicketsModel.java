package com.digicode.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

@Entity
@Table(name = "tickets")
public class TicketsModel implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "ticket_name")
    private String ticketName;

    @Column(name = "ticket_description")
    private String ticketDescription;

    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "updated_by")
    private String updatedBy;

    @Column(name = "updated_at")
    private Date updatedAt;

    @Column(name = "assignee")
    private String assignee;

    @Column(name = "severity")
    private String severity;

    @Column(name = "remark")
    private String remark;

    @Column(name = "status")
    private String status;

    @Column(name = "manager")
    private String manager;

    // One-to-many relationship with TicketLogs
    @OneToMany(mappedBy = "ticketModel", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<TicketLogs> ticketLogList = new ArrayList<>();

    // Many-to-one relationship with TaskSubgroupModel
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "subgroup_id")
    private TaskSubgroupModel taskSubgroup;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private EmployeeModel employee;


    // Getters and Setters
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTicketName() {
        return ticketName;
    }

    public void setTicketName(String ticketName) {
        this.ticketName = ticketName;
    }

    public String getTicketDescription() {
        return ticketDescription;
    }

    public void setTicketDescription(String ticketDescription) {
        this.ticketDescription = ticketDescription;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getAssignee() {
        return assignee;
    }

    public void setAssignee(String assignee) {
        this.assignee = assignee;
    }

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public List<TicketLogs> getTicketLogList() {
        return ticketLogList;
    }

    public void setTicketLogList(List<TicketLogs> ticketLogList) {
        this.ticketLogList = ticketLogList;
    }

    public TaskSubgroupModel getTaskSubgroup() {
        return taskSubgroup;
    }

    public void setTaskSubgroup(TaskSubgroupModel taskSubgroup) {
        this.taskSubgroup = taskSubgroup;
    }
}