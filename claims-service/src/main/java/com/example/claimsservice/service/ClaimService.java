package com.example.claimsservice.service;

import com.example.claimsservice.model.Claim;
import com.example.claimsservice.repository.ClaimRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
public class ClaimService {

    @Autowired
    private ClaimRepository claimRepository;

    public Claim createClaim(Claim claim) {
        claim.setStatus("Filed");
        return claimRepository.save(claim);
    }

    public List<Claim> getAllClaims() {
        return claimRepository.findAll();
    }

    public Claim getClaimById(Long id) {
        return claimRepository.findById(id).orElse(null);
    }

    public Claim updateClaimStatus(Long id, String status) {
        Claim claim = getClaimById(id);
        if (claim != null) {
            claim.setStatus(status);
            return claimRepository.save(claim);
        }
        return null;
    }

    public Claim uploadFile(Long id, MultipartFile file) throws IOException {
        Claim claim = getClaimById(id);
        if (claim != null) {
            String fileName = file.getOriginalFilename();
            Path path = Paths.get("uploads/" + fileName);
            Files.write(path, file.getBytes());
            claim.setFileUrl("/uploads/" + fileName);
            return claimRepository.save(claim);
        }
        return null;
    }

    public String getClaimStatus(Long id) {
        Claim claim = getClaimById(id);
        return claim != null ? claim.getStatus() : null;
    }
}
