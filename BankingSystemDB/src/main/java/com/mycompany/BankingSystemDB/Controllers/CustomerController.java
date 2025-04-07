package com.mycompany.BankingSystemDB.Controllers;

import com.mycompany.BankingSystemDB.POJOs.Customer;
import com.mycompany.BankingSystemDB.Repositories.BranchRepository;
import com.mycompany.BankingSystemDB.Services.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/customers")
public class CustomerController {

    private final CustomerService customerService;
    private final BranchRepository branchRepository;

    @Autowired
    public CustomerController(CustomerService customerService, BranchRepository branchRepository) {
        this.customerService = customerService;
        this.branchRepository = branchRepository;
    }

    // List all customers
    @GetMapping
    public String listCustomers(Model model) {
        List<Customer> customers = customerService.getAllCustomers();
        model.addAttribute("customers", customers);
        return "customers/list";
    }

    // Show customer details
    @GetMapping("/{id}")
    public String viewCustomer(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Customer> customer = customerService.getCustomerById(id);
        if (customer.isPresent()) {
            model.addAttribute("customer", customer.get());
            return "customers/details";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Customer not found");
            return "redirect:/customers";
        }
    }

    // Show form to create a new customer
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("customer", new Customer());
        model.addAttribute("branches", branchRepository.findAll()); // 添加分行數據到模型
        return "customers/create";
    }

    // Handle customer creation
    @PostMapping
    public String createCustomer(@ModelAttribute Customer customer, RedirectAttributes redirectAttributes) {
        try {
            customerService.saveCustomer(customer);
            redirectAttributes.addFlashAttribute("successMessage", "Customer created successfully");
            return "redirect:/customers";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to create customer: " + e.getMessage());
            return "redirect:/customers/create";
        }
    }

    // Show form to edit an existing customer
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Customer> customer = customerService.getCustomerById(id);
        if (customer.isPresent()) {
            model.addAttribute("customer", customer.get());
            model.addAttribute("branches", branchRepository.findAll()); // 添加分行數據到模型
            return "customers/edit";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Customer not found");
            return "redirect:/customers";
        }
    }

    // Handle customer update
    @PostMapping("/{id}")
    public String updateCustomer(@PathVariable("id") Integer id, @ModelAttribute Customer customer, RedirectAttributes redirectAttributes) {
        try {
            customer.setCustomerId(id);
            customerService.updateCustomer(customer);
            redirectAttributes.addFlashAttribute("successMessage", "Customer updated successfully");
            return "redirect:/customers/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update customer: " + e.getMessage());
            return "redirect:/customers/" + id + "/edit";
        }
    }

    // Handle customer deletion
    @GetMapping("/{id}/delete")
    public String deleteCustomer(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            customerService.deleteCustomer(id);
            redirectAttributes.addFlashAttribute("successMessage", "Customer deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete customer: " + e.getMessage());
        }
        return "redirect:/customers";
    }

    // Search customers by last name
    @GetMapping("/search")
    public String searchCustomers(@RequestParam("lastName") String lastName, Model model) {
        List<Customer> customers = customerService.findByLastName(lastName);
        model.addAttribute("customers", customers);
        model.addAttribute("searchTerm", lastName);
        return "customers/list";
    }
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}