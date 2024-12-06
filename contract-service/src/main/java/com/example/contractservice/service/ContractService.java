package com.example.contractservice.service;

import com.example.contractservice.model.Contract;
import com.example.contractservice.repository.ContractRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ContractService {

    @Autowired
    private ContractRepository contractRepository;

    public Contract createContract(Contract contract) {
        return contractRepository.save(contract);
    }

    public Contract getContractById(Long id) {
        return contractRepository.findById(id).orElse(null);
    }

    public List<Contract> getAllContracts() {
        return contractRepository.findAll();
    }
}
