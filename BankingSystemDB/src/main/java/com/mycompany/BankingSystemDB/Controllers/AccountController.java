package com.mycompany.BankingSystemDB.Controllers;

import com.mycompany.BankingSystemDB.POJOs.Account;
import com.mycompany.BankingSystemDB.Repositories.BranchRepository;
import com.mycompany.BankingSystemDB.Repositories.CustomerRepository;
import com.mycompany.BankingSystemDB.Services.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/accounts")
public class AccountController {

    private final AccountService accountService;
    private final BranchRepository branchRepository;
    private final CustomerRepository customerRepository;
    @Autowired
    public AccountController(AccountService accountService, BranchRepository branchRepository, CustomerRepository customerRepository) {
        this.accountService = accountService;
        this.branchRepository = branchRepository;
        this.customerRepository = customerRepository;
    }

    // List all accounts
    @GetMapping
    public String listAccounts(Model model) {
        List<Account> accounts = accountService.getAllAccounts();
        model.addAttribute("accounts", accounts);
        return "accounts/list";
    }

    // Show account details
    @GetMapping("/{id}")
    public String viewAccount(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Account> account = accountService.getAccountById(id);
        if (account.isPresent()) {
            model.addAttribute("account", account.get());
            return "accounts/details";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Account not found");
            return "redirect:/accounts";
        }
    }

    // Show form to create a new account
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("account", new Account());
        model.addAttribute("branches", branchRepository.findAll());
        model.addAttribute("customers", customerRepository.findAll());
        return "accounts/create";
    }

    // Handle account creation
    @PostMapping
    public String createAccount(@ModelAttribute Account account, RedirectAttributes redirectAttributes) {
        try {
            accountService.saveAccount(account);
            redirectAttributes.addFlashAttribute("successMessage", "Account created successfully");
            return "redirect:/accounts";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to create account: " + e.getMessage());
            return "redirect:/accounts/create";
        }
    }

    // Show form to edit an existing account
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Account> account = accountService.getAccountById(id);
        if (account.isPresent()) {
            model.addAttribute("account", account.get());
            model.addAttribute("branches", branchRepository.findAll());
            model.addAttribute("customers", customerRepository.findAll());
            return "accounts/edit";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Account not found");
            return "redirect:/accounts";
        }
    }

    // Handle account update
    @PostMapping("/{id}")
    public String updateAccount(@PathVariable("id") Integer id, @ModelAttribute Account account, RedirectAttributes redirectAttributes) {
        try {
        	//get old opening date
        	Optional<Account> accountOptional = accountService.getAccountById(id);
        	Account selectedAccount = accountOptional.get();
        	account.setOpeningDate(selectedAccount.getOpeningDate());
        	
            account.setInstrumentId(id);
            accountService.updateAccount(account);
            redirectAttributes.addFlashAttribute("successMessage", "Account updated successfully");
            return "redirect:/accounts/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update account: " + e.getMessage());
            return "redirect:/accounts/" + id + "/edit";
        }
    }

    // Handle account deletion
    @GetMapping("/{id}/delete")
    public String deleteAccount(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            accountService.deleteAccount(id);
            redirectAttributes.addFlashAttribute("successMessage", "Account deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete account: " + e.getMessage());
        }
        return "redirect:/accounts";
    }

    // List accounts by customer
    @GetMapping("/customer/{customerId}")
    public String listAccountsByCustomer(@PathVariable("customerId") Integer customerId, Model model) {
        List<Account> accounts = accountService.findAccountsByCustomerId(customerId);
        model.addAttribute("accounts", accounts);
        model.addAttribute("customerId", customerId);
        return "accounts/list";
    }

    // Filter accounts by type
    @GetMapping("/filter")
    public String filterAccounts(@RequestParam("accountType") String accountType, Model model) {
        List<Account> accounts = accountService.findByAccountType(accountType);
        model.addAttribute("accounts", accounts);
        model.addAttribute("accountType", accountType);
        return "accounts/list";
    }
}