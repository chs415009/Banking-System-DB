package com.mycompany.BankingSystemDB.Controllers;

import com.mycompany.BankingSystemDB.POJOs.Transaction;
import com.mycompany.BankingSystemDB.POJOs.TransactionPK;
import com.mycompany.BankingSystemDB.Services.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/transactions")
public class TransactionController {

    private final TransactionService transactionService;

    @Autowired
    public TransactionController(TransactionService transactionService) {
        this.transactionService = transactionService;
    }

    // List all transactions
    @GetMapping
    public String listTransactions(Model model) {
        List<Transaction> transactions = transactionService.getAllTransactions();
        model.addAttribute("transactions", transactions);
        return "transactions/list";
    }

    // Show transaction details
    @GetMapping("/{transactionId}/{instrumentId}")
    public String viewTransaction(
            @PathVariable("transactionId") Integer transactionId,
            @PathVariable("instrumentId") Integer instrumentId,
            Model model,
            RedirectAttributes redirectAttributes) {
        
        TransactionPK id = new TransactionPK(transactionId, instrumentId);
        Optional<Transaction> transaction = transactionService.getTransactionById(id);
        
        if (transaction.isPresent()) {
            model.addAttribute("transaction", transaction.get());
            return "transactions/details";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Transaction not found");
            return "redirect:/transactions";
        }
    }

    // Show form to create a new transaction
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("transaction", new Transaction());
        return "transactions/create";
    }

    // Handle transaction creation
    @PostMapping
    public String createTransaction(@ModelAttribute Transaction transaction, RedirectAttributes redirectAttributes) {
        try {
            // Set current date if not provided
            if (transaction.getDateTime() == null) {
                transaction.setDateTime(new Date());
            }
            
            transactionService.saveTransaction(transaction);
            redirectAttributes.addFlashAttribute("successMessage", "Transaction created successfully");
            return "redirect:/transactions";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to create transaction: " + e.getMessage());
            return "redirect:/transactions/create";
        }
    }

    // List transactions by customer
    @GetMapping("/customer/{customerId}")
    public String listTransactionsByCustomer(@PathVariable("customerId") Integer customerId, Model model) {
        List<Transaction> transactions = transactionService.findTransactionsByCustomerId(customerId);
        model.addAttribute("transactions", transactions);
        model.addAttribute("customerId", customerId);
        return "transactions/list";
    }

    // List transactions by instrument
    @GetMapping("/instrument/{instrumentId}")
    public String listTransactionsByInstrument(@PathVariable("instrumentId") Integer instrumentId, Model model) {
        List<Transaction> transactions = transactionService.findByInstrumentId(instrumentId);
        model.addAttribute("transactions", transactions);
        model.addAttribute("instrumentId", instrumentId);
        return "transactions/list";
    }

    // Filter transactions by type
    @GetMapping("/filter")
    public String filterTransactions(@RequestParam("transactionType") String transactionType, Model model) {
        List<Transaction> transactions = transactionService.findByTransactionType(transactionType);
        model.addAttribute("transactions", transactions);
        model.addAttribute("transactionType", transactionType);
        return "transactions/list";
    }

    // Show recent transactions (last 30 days)
    @GetMapping("/recent")
    public String recentTransactions(Model model) {
        List<Transaction> transactions = transactionService.findRecentTransactions();
        model.addAttribute("transactions", transactions);
        model.addAttribute("title", "Recent Transactions (Last 30 Days)");
        return "transactions/list";
    }
}