package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.ContractConstant;
import com.shsoftvina.erpshsoftvina.converter.ContractConverter;
import com.shsoftvina.erpshsoftvina.entity.AllowanceInsurance;
import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.enums.contract.StatusContractEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.ContractMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.contract.CreateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.contract.UpdateContractRequest;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;
import com.shsoftvina.erpshsoftvina.service.AllowanceInsuranceService;
import com.shsoftvina.erpshsoftvina.service.ContractService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class ContractServiceImpl implements ContractService {

    @Autowired
    private ContractConverter contractConverter;

    @Autowired
    private ContractMapper contractMapper;

    @Autowired
    private UserMapper userMapper;


    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private AllowanceInsuranceService allowanceInsuranceService;

    @Override
    public ContractResponse addContract(CreateContractRequest createContractRequest) {

        MultipartFile contractFile = createContractRequest.getFile();
        if(contractFile!=null) applicationUtils.checkValidateFile(Contract.class, contractFile);

        String fileNameContract = null;
        boolean isSaveContractSuccess = true;

        if(contractFile != null){
            fileNameContract = FileUtils.formatNameImage(contractFile);
            isSaveContractSuccess = FileUtils.saveImageToServer(ContractConstant.UPLOAD_FILE_DIR, createContractRequest.getFile(), fileNameContract);
        }

        if(isSaveContractSuccess){
            Contract c = contractConverter.toEntity(createContractRequest, fileNameContract);
            try {
                contractMapper.addContract(c);

                List<AllowanceInsurance> allowanceInsurances = allowanceInsuranceService.insertAllowanceInsurances(c.getId(), createContractRequest.getAllowanceInsurances());
                if(allowanceInsurances != null){
                    c.setAllowanceInsurances(allowanceInsurances);
                    return contractConverter.toResponse(c);
                } else{
                    contractMapper.deleteById(c.getId());
                    FileUtils.deleteImageFromServer(ContractConstant.UPLOAD_FILE_DIR, fileNameContract);
                }
            } catch (Exception e){
                FileUtils.deleteImageFromServer(ContractConstant.UPLOAD_FILE_DIR, fileNameContract);
            }
        }
        return null;
    }

    @Override
    public ContractResponse findById(String id) {
        return contractConverter.toResponse(contractMapper.findById(id));
    }

    @Override
    public int updateContract(UpdateContractRequest updateContractRequest) {
        Contract contract = contractMapper.findById(updateContractRequest.getId());
        if(contract == null) throw new NotFoundException("id");

        String fileNameContract = null;
        boolean isSaveContractSuccess;

        MultipartFile contractFile = updateContractRequest.getFile();
        if(contractFile!=null) applicationUtils.checkValidateFile(Contract.class, contractFile);
        if(contractFile != null){
            fileNameContract = FileUtils.formatNameImage(contractFile);
            isSaveContractSuccess = FileUtils.saveImageToServer(ContractConstant.UPLOAD_FILE_DIR, updateContractRequest.getFile(), fileNameContract);
        } else isSaveContractSuccess = false;

        Contract c;
        if(isSaveContractSuccess){
            c = contractConverter.toEntity(updateContractRequest, fileNameContract);
            try {
                contractMapper.updateContract(c);
                List<AllowanceInsurance> allowanceInsurances = allowanceInsuranceService.updateAllowanceInsurances(c.getId(), updateContractRequest.getAllowanceInsurances());
                if(allowanceInsurances == null) {
                    contractMapper.deleteById(c.getId());
                    FileUtils.deleteImageFromServer(ContractConstant.UPLOAD_FILE_DIR, fileNameContract);
                    return 0;
                } else{
                    FileUtils.deleteImageFromServer(ContractConstant.UPLOAD_FILE_DIR, contract.getFiles());
                    return 1;
                }
            } catch (Exception e){
                FileUtils.deleteImageFromServer(ContractConstant.UPLOAD_FILE_DIR, fileNameContract);
                return 0;
            }
        } else {
            fileNameContract = contract.getFiles();
            c = contractConverter.toEntity(updateContractRequest, fileNameContract);
            try{
                contractMapper.updateContract(c);
                List<AllowanceInsurance> allowanceInsurances = allowanceInsuranceService.updateAllowanceInsurances(c.getId(), updateContractRequest.getAllowanceInsurances());
                if(allowanceInsurances == null) {
                    contractMapper.deleteById(c.getId());
                    return 0;
                }
            }catch (Exception e) {
                return 0;
            }
            return 1;
        }
    }

    @Override
    public int deleteContract(String id) {
        Contract contract = contractMapper.findById(id);
        if(contract == null) throw new NotFoundException("id");

        try{
            contractMapper.changeStatusContract(id, StatusContractEnum.INACTIVE.toString());
            return 1;
        } catch (Exception e){
            return 0;
        }
    }

    @Override
    public List<ContractResponse> getHistoryContract(String id) {
        return contractConverter.toListResponse(contractMapper.getHistoryContract(id));
    }
}
