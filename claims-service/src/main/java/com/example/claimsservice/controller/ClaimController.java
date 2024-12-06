package com.example.claimsservice.controller;

import com.example.claimsservice.model.Claim;
import com.example.claimsservice.service.ClaimService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;
import org.springframework.http.ResponseEntity;

import java.io.IOException;

@RestController
@RequestMapping("/claims")
public class ClaimController {

    @Autowired
    private ClaimService claimService;

    @GetMapping
    public ResponseEntity<List<Claim>> getAllClaims() {
        return ResponseEntity.ok(claimService.getAllClaims());
    }

    @PostMapping
    public ResponseEntity<Claim> createClaim(@RequestBody Claim claim) {
        return ResponseEntity.ok(claimService.createClaim(claim));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Claim> getClaimById(@PathVariable Long id) {
        Claim claim = claimService.getClaimById(id);
        if (claim != null) {
            return ResponseEntity.ok(claim);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Claim> updateClaimStatus(@PathVariable Long id, @RequestParam String status) {
        Claim updatedClaim = claimService.updateClaimStatus(id, status);
        if (updatedClaim != null) {
            return ResponseEntity.ok(updatedClaim);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("/{id}/file")
    public ResponseEntity<Claim> uploadFile(@PathVariable Long id, @RequestParam("file") MultipartFile file) {
        try {
            Claim updatedClaim = claimService.uploadFile(id, file);
            if (updatedClaim != null) {
                return ResponseEntity.ok(updatedClaim);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (IOException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/status/{id}")
    public ResponseEntity<String> getClaimStatus(@PathVariable Long id) {
        String status = claimService.getClaimStatus(id);
        if (status != null) {
            return ResponseEntity.ok(status);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
