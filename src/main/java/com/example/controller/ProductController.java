package com.example.controller;

import com.example.model.Brand;
import com.example.model.Category;
import com.example.model.Product;
import com.example.service.IBrandService;
import com.example.service.ICategoryService;
import com.example.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;

@Controller
@RequestMapping("/shop")
public class ProductController {
    @Autowired
    private IProductService productService;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IBrandService brandService;

    @GetMapping
    public String viewShop(Model model,
                           @RequestParam(defaultValue = "1", required = false) Integer page,
                           @RequestParam(required = false) Category category,
                           @RequestParam(required = false) Brand brand) {
        if (page < 1) page = 1;
        Pageable pageable = PageRequest.of(page-1, 4);
        Page<Product> productPage = productService.filterProduct("", BigDecimal.valueOf(0),BigDecimal.valueOf(999999999), category,brand,"",pageable);
        model.addAttribute("page", productPage);
        model.addAttribute("currentPage", page-1);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("listCategory", categoryService.getAll());
        model.addAttribute("listBrand", brandService.getAll());
        return "shop";
    }
}
