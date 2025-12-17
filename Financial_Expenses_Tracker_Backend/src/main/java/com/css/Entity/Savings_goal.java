package com.css.Entity;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "Savings_Goal")
public class Savings_goal {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @JsonProperty("title")
    @Column(name = "Goal_Name")
    private String goal_name;

    @Column(name = "Subtitle")
    private String subtitle;

    @JsonProperty("targetAmount")
    @Column(name = "Target_Amount")
    private Double target_amount;

    @JsonProperty("saved")
    @Column(name = "Saved_Amount")
    private Double saved_amount;

    @Column(name = "Created_At")
    private LocalDateTime created_at;

    @JsonProperty("iconCode")
    private Integer iconCode;

    @JsonProperty("colorValue")
    private Integer colorValue;

    @JsonProperty("progress")
    public double getProgress() {
        if (target_amount == null || target_amount == 0) return 0.0;
        return (saved_amount != null ? saved_amount : 0) / target_amount;
    }
}
