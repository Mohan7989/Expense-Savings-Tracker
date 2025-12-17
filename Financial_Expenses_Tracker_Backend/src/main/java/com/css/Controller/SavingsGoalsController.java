package com.css.Controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.css.Entity.Savings_goal;
import com.css.Service.ISavingsGoals_Servicel;

@RestController
@RequestMapping("/api/savings")
@CrossOrigin(origins = "*") 
public class SavingsGoalsController {

    @Autowired
    private ISavingsGoals_Servicel savingsService;

   
    @PostMapping
    public ResponseEntity<Savings_goal> createSavingsGoal(
            @RequestBody Savings_goal savingsGoal) {

        Savings_goal savedGoal = savingsService.create_Savings_Goal(savingsGoal);
        return new ResponseEntity<>(savedGoal, HttpStatus.CREATED);
    }
    
    @PutMapping("/{goalId}/save/{amount}")
    public ResponseEntity<Savings_goal> addSavedAmount(
            @PathVariable Long goalId,
            @PathVariable Double amount) {

        Savings_goal updated =
                savingsService.addSavedAmount(goalId, amount);

        return ResponseEntity.ok(updated);
    }
    @GetMapping("/{goalId}/history")
    public ResponseEntity<List<Double>> getSavingsHistory(
            @PathVariable Long goalId) {

        return ResponseEntity.ok(
                savingsService.getSavingsHistory(goalId)
        );
    }


    @GetMapping("/all")
    public ResponseEntity<List<Savings_goal>> getAllSavingsGoals() {
        return ResponseEntity.ok(savingsService.get_All_Savings_Goals());
    }

    
    @GetMapping
    public ResponseEntity<Savings_goal> getSavingsGoal() {

        Optional<Savings_goal> optionalGoal = savingsService.get_Savings_Goal();

        return optionalGoal
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.noContent().build());
    }

   
    @GetMapping("/progress")
    public ResponseEntity<Double> getSavingsProgress() {
        Double progress = savingsService.get_Savings_Progress();
        return ResponseEntity.ok(progress);
    }

  
    @PutMapping("/add/{amount}")
    public ResponseEntity<Savings_goal> updateSavedAmount(
            @PathVariable Double amount) {

        Savings_goal updatedGoal = savingsService.update_Saved_Amount(amount);
        return ResponseEntity.ok(updatedGoal);
    }
}
