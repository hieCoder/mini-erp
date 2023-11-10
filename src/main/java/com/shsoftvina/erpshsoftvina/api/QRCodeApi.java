package com.shsoftvina.erpshsoftvina.api;

import com.google.zxing.WriterException;
import com.shsoftvina.erpshsoftvina.model.request.qrcode.GenerateQRCodeRequest;
import com.shsoftvina.erpshsoftvina.service.QRCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/api/v1/qrcode")
public class QRCodeApi {
    @Autowired
    QRCodeService qrCodeService;

    @PostMapping()
    public ResponseEntity<?> generateQRCode(@RequestBody GenerateQRCodeRequest generateQRCodeRequest) throws IOException, WriterException {
        return ResponseEntity.ok(qrCodeService.generateQRCode(generateQRCodeRequest));
    }

}
