package com.mycompany.BankingSystemDB.Controllers;

import com.mycompany.BankingSystemDB.POJOs.Loan;
import com.mycompany.BankingSystemDB.Repositories.CustomerRepository;
import com.mycompany.BankingSystemDB.Repositories.EmployeeRepository;
import com.mycompany.BankingSystemDB.Services.LoanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/loans")
public class LoanController {

    private final LoanService loanService;
    private final CustomerRepository customerRepository;
    private final EmployeeRepository employeeRepository;

    @Autowired
    public LoanController(LoanService loanService, CustomerRepository customerRepository, EmployeeRepository employeeRepository) {
        this.loanService = loanService;
        this.customerRepository = customerRepository;
        this.employeeRepository = employeeRepository;
    }

    // List all loans
    @GetMapping
    public String listLoans(Model model) {
        List<Loan> loans = loanService.getAllLoans();
        model.addAttribute("loans", loans);
        return "loans/list";
    }

    // Show loan details
    @GetMapping("/{id}")
    public String viewLoan(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Loan> loan = loanService.getLoanById(id);
        if (loan.isPresent()) {
            model.addAttribute("loan", loan.get());
            return "loans/details";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Loan not found");
            return "redirect:/loans";
        }
    }

    // Show form to create a new loan
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("loan", new Loan());
        model.addAttribute("customers", customerRepository.findAll());
        model.addAttribute("employees", employeeRepository.findAll());
        return "loans/create";
    }

    // Handle loan creation
    @PostMapping
    public String createLoan(@ModelAttribute Loan loan, RedirectAttributes redirectAttributes) {
        try {
            loanService.saveLoan(loan);
            redirectAttributes.addFlashAttribute("successMessage", "Loan created successfully");
            return "redirect:/loans";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to create loan: " + e.getMessage());
            return "redirect:/loans/create";
        }
    }

    // Show form to edit an existing loan
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Loan> loan = loanService.getLoanById(id);
        model.addAttribute("loan", loan.get());
        model.addAttribute("employees", employeeRepository.findAll());
        return "loans/edit";
//        if (loan.isPresent()) {
//            model.addAttribute("loan", loan.get());
//            return "loans/edit";
//        } else {
//            redirectAttributes.addFlashAttribute("errorMessage", "Loan not found");
//            return "redirect:/loans";
//        }
    }

    // Handle loan update
    @PostMapping("/{id}")
    public String updateLoan(@PathVariable("id") Integer id, @ModelAttribute Loan loan, RedirectAttributes redirectAttributes) {
        try {
        	Optional<Loan> LoanOpt = loanService.getLoanById(id);
        	Loan selectedLoan = LoanOpt.get();
        	loan.setStartDate(selectedLoan.getStartDate());
            loan.setEndDate(selectedLoan.getEndDate());
            loan.setStatus(selectedLoan.getStatus());
        	
            loan.setInstrumentId(id);
            loanService.updateLoan(loan);
            redirectAttributes.addFlashAttribute("successMessage", "Loan updated successfully");
            return "redirect:/loans/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update loan: " + e.getMessage());
            return "redirect:/loans/" + id + "/edit";
        }
    }

    // Handle loan deletion
    @GetMapping("/{id}/delete")
    public String deleteLoan(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            loanService.deleteLoan(id);
            redirectAttributes.addFlashAttribute("successMessage", "Loan deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete loan: " + e.getMessage());
        }
        return "redirect:/loans";
    }

    // List loans by customer
    @GetMapping("/customer/{customerId}")
    public String listLoansByCustomer(@PathVariable("customerId") Integer customerId, Model model) {
        List<Loan> loans = loanService.findLoansByCustomerId(customerId);
        model.addAttribute("loans", loans);
        model.addAttribute("customerId", customerId);
        return "loans/list";
    }

    // Filter loans by type
    @GetMapping("/filter")
    public String filterLoans(@RequestParam("loanType") String loanType, Model model) {
        List<Loan> loans = loanService.findByLoanType(loanType);
        model.addAttribute("loans", loans);
        model.addAttribute("loanType", loanType);
        return "loans/list";
    }

    // Filter loans by status
    @GetMapping("/status")
    public String loansByStatus(@RequestParam("status") String status, Model model) {
        List<Loan> loans = loanService.findByLoanStatus(status);
        model.addAttribute("loans", loans);
        model.addAttribute("status", status);
        return "loans/list";
    }
}