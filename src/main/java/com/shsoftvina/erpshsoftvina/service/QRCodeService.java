package com.shsoftvina.erpshsoftvina.service;

import com.google.zxing.WriterException;
import com.shsoftvina.erpshsoftvina.model.request.qrcode.GenerateQRCodeRequest;

import java.io.IOException;

public interface QRCodeService {
    byte[] generateQRCode(GenerateQRCodeRequest generateQRCodeRequest) throws WriterException, IOException;
}
