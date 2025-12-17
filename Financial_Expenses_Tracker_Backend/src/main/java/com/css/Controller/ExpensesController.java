package com.css.Controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.css.Entity.Expenses;
import com.css.Service.IExpenses_Service;

@RestController
@RequestMapping("/api/expenses")
@CrossOrigin(origins = "*") 
public class ExpensesController {

    @Autowired
    private IExpenses_Service expensesService;

    
    @PostMapping
    public ResponseEntity<Expenses> addExpense(@RequestBody Expenses expenses) {
        Expenses savedExpense = expensesService.add_Expense(expenses);
        return new ResponseEntity<>(savedExpense, HttpStatus.CREATED);
    }

    
    @GetMapping
    public ResponseEntity<List<Expenses>> getAllExpenses() {
        List<Expenses> expensesList = expensesService.get_All_Expenses();
        return ResponseEntity.ok(expensesList);
    }

    
    @GetMapping("/date/{date}")
    public ResponseEntity<List<Expenses>> getExpensesByDate(
            @PathVariable
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
            LocalDate date) {

        List<Expenses> expenses = expensesService.get_Expenses_By_Date(date);
        return ResponseEntity.ok(expenses);
    }

    
    @GetMapping("/total/today")
    public ResponseEntity<Double> getTodayTotalExpense() {
        Double total = expensesService.get_Today_Total_Expense();
        return ResponseEntity.ok(total);
    }

    
    @GetMapping("/total/month")
    public ResponseEntity<Double> getCurrentMonthTotalExpense() {
        Double total = expensesService.get_Current_Month_Total_Expense();
        return ResponseEntity.ok(total);
    }
}
