package com.css.Entity;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "Savings_Transaction")
public class SavingsTransaction {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "Amount", nullable = false)
    private Double amount;

    @Column(name = "Created_At")
    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "Savings_Goal_Id")
    private Savings_goal savingsGoal;
}
