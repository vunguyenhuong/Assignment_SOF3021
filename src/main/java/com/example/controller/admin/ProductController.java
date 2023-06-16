package com.example.controller.admin;

import com.example.model.Brand;
import com.example.model.Category;
import com.example.model.Product;
import com.example.model.Users;
import com.example.service.IBrandService;
import com.example.service.ICategoryService;
import com.example.service.IProductService;
import com.example.utils.UploadService;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;

@Controller("AdminProductController")
@RequestMapping("/admin/product")
public class ProductController {
    @Autowired
    private IProductService productService;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IBrandService brandService;
    @Autowired
    private UploadService uploadService;
    @Autowired
    HttpServletRequest request;

    @GetMapping
    public String getAll(Model model, @RequestParam(required = false, defaultValue = "1") Integer page,
                         @RequestParam(required = false, defaultValue = "5") Integer size,
                         @RequestParam(required = false, defaultValue = "") String name,
                         @RequestParam(required = false, defaultValue = "0") BigDecimal minPrice,
                         @RequestParam(required = false, defaultValue = "999999999") BigDecimal maxPrice,
                         @RequestParam(required = false) Category category,
                         @RequestParam(required = false) String vanhXe,
                         @RequestParam(required = false) Brand brand) {
        if(page < 1) page = 1;
        Pageable pageable = PageRequest.of(page-1, size);
        Page<Product> productPage = productService.filterProduct(name, minPrice, maxPrice, category, brand,vanhXe, pageable);
        model.addAttribute("page", productPage);
        model.addAttribute("currentPage", page-1);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("listCategory", categoryService.getAll());
        model.addAttribute("listBrand", brandService.getAll());
        return "/admin/product";
    }

    @PostMapping("")
    public String add(RedirectAttributes redirectAttributes, @RequestParam("hinhAnh") MultipartFile hinhAnh) {
        String timeStamp = String.valueOf(System.currentTimeMillis());
        Integer idCate = Integer.parseInt(request.getParameter("id_cate"));
        Integer idBrand = Integer.parseInt(request.getParameter("id_brand"));
        Product product = new Product();
        try {
            product.setCategory(categoryService.getOne(idCate).orElse(null));
            product.setBrand(brandService.getOne(idBrand).orElse(null));
            product.setDonGiaKhiGiam(BigDecimal.valueOf(0));
            if (hinhAnh.getOriginalFilename().isEmpty()) {
                product.setHinhAnh("default.jpg");
            } else {
                product.setHinhAnh(timeStamp + hinhAnh.getOriginalFilename());
                uploadService.save(timeStamp, hinhAnh, "/resources/images/products/");
            }
            BeanUtils.populate(product, request.getParameterMap());
            if (productService.save(product)) {
                redirectAttributes.addFlashAttribute("successMessage", "Thêm mới thành công!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/product";
    }

    @GetMapping("/{id}")
    public String detailProduct(Model model, @PathVariable Integer id) {
        model.addAttribute("listCategory", categoryService.getAll());
        model.addAttribute("listBrand", brandService.getAll());
        model.addAttribute("product", productService.getOne(id).orElse(null));
        return "/admin/detail-product";
    }

    @PostMapping("/update/{id}")
    public String updateProduct(RedirectAttributes redirectAttributes,
                                @PathVariable Integer id,
                                @RequestParam("hinhAnh") MultipartFile hinhAnh) {
        String timeStamp = String.valueOf(System.currentTimeMillis());
        Integer idCate = Integer.parseInt(request.getParameter("id_cate"));
        Integer idBrand = Integer.parseInt(request.getParameter("id_brand"));
        Product product = productService.getOne(id).orElse(null);
        String oldImg = product.getHinhAnh();
        try {
            product.setCategory(categoryService.getOne(idCate).orElse(null));
            product.setBrand(brandService.getOne(idBrand).orElse(null));
            if (hinhAnh.getOriginalFilename() == "") {
                product.setHinhAnh(oldImg);
            } else {
                if (!product.getHinhAnh().equals("default.jpg")) {
                    uploadService.delete(product.getHinhAnh(), "/resources/images/products/");
                }
                product.setHinhAnh(timeStamp + hinhAnh.getOriginalFilename());
                uploadService.save(timeStamp, hinhAnh, "/resources/images/products/");
            }
            BeanUtils.populate(product, request.getParameterMap());
            if (productService.save(product)) {
                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thành công!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/product";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(RedirectAttributes redirectAttributes, @PathVariable Integer id) {
        Product product = productService.getOne(id).get();
        if (productService.delete(id)) {
            if (!product.getHinhAnh().equals("default.jpg")) {
                uploadService.delete(product.getHinhAnh(), "/resources/images/products/");
            }
            redirectAttributes.addFlashAttribute("successMessage", "Xóa thành công!");
        }else {
            redirectAttributes.addFlashAttribute("errorMessage", "Xóa thất bại!!");
        }
        return "redirect:/admin/product";
    }
}
