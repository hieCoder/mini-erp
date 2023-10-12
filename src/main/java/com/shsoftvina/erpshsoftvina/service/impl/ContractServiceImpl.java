package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.ContractConstant;
import com.shsoftvina.erpshsoftvina.converter.ContractConverter;
import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.enums.contract.InsuranceTypeEnum;
import com.shsoftvina.erpshsoftvina.enums.contract.StatusContractEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.ContractMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.contract.CreateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.contract.UpdateContractRequest;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;
import com.shsoftvina.erpshsoftvina.service.ContractService;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

@Service
public class ContractServiceImpl implements ContractService {

    @Autowired
    private ContractConverter contractConverter;

    @Autowired
    private ContractMapper contractMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private HttpServletRequest request;

    @Override
    public int addContract(CreateContractRequest createContractRequest) {

        String userId = createContractRequest.getUserId();
        if(userMapper.findById(userId) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        if(!EnumUtils.isExistInEnum(InsuranceTypeEnum.class, createContractRequest.getInsuranceType()))
            throw new NotFoundException(MessageErrorUtils.notFound("insuranceType"));

        MultipartFile contract = createContractRequest.getContract();
        String fileNameContract = FileUtils.formatNameImage(contract);
        boolean isSaveContractSuccess = FileUtils.saveImageToServer(
                request, ContractConstant.UPLOAD_FILE_DIR, createContractRequest.getContract(), fileNameContract);
        if(isSaveContractSuccess){
            Contract c = contractConverter.toEntity(createContractRequest, fileNameContract);
            try {
                contractMapper.addContract(c);
                return 1;
            } catch (Exception e){
                FileUtils.deleteImageFromServer(request, ContractConstant.UPLOAD_FILE_DIR, fileNameContract);
                return 0;
            }
        }
        return 0;
    }

    @Override
    public ContractResponse findById(String id) {
        return contractConverter.toResponse(contractMapper.findById(id));
    }

    @Override
    public int updateContract(UpdateContractRequest updateContractRequest) {

        Contract contract = contractMapper.findById(updateContractRequest.getId());

        if(contract == null) throw new NotFoundException("id");

        if(!EnumUtils.isExistInEnum(InsuranceTypeEnum.class, updateContractRequest.getInsuranceType()))
            throw new NotFoundException(MessageErrorUtils.notFound("insuranceType"));

        MultipartFile contractFile = updateContractRequest.getContract();
        String fileNameContract = FileUtils.formatNameImage(contractFile);
        boolean isSaveContractSuccess = FileUtils.saveImageToServer(
                request, ContractConstant.UPLOAD_FILE_DIR, updateContractRequest.getContract(), fileNameContract);
        if(isSaveContractSuccess){
            Contract c = contractConverter.toEntity(updateContractRequest, fileNameContract);
            try {
                contractMapper.updateContract(c);
                FileUtils.deleteImageFromServer(request, ContractConstant.UPLOAD_FILE_DIR, contract.getContract());
                return 1;
            } catch (Exception e){
                FileUtils.deleteImageFromServer(request, ContractConstant.UPLOAD_FILE_DIR, fileNameContract);
                return 0;
            }
        }
        return 0;
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
}