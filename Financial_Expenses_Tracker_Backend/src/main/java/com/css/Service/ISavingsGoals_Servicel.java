package com.css.Service;

import java.util.List;
import java.util.Optional;

import com.css.Entity.Savings_goal;

public interface ISavingsGoals_Servicel {

	public Savings_goal addSavedAmount(Long goalId, Double amount);
	
	 public List<Double> getSavingsHistory(Long goalId);
	 
	public Savings_goal create_Savings_Goal(Savings_goal saving_goal);
	
	public Optional<Savings_goal> get_Savings_Goal();
	
	public Double get_Savings_Progress();
	
	public Savings_goal update_Saved_Amount(Double amountToAdd);
	
	public List<Savings_goal> get_All_Savings_Goals();
	
}
