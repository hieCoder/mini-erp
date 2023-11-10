package com.shsoftvina.erpshsoftvina.service.impl;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.shsoftvina.erpshsoftvina.model.request.qrcode.GenerateQRCodeRequest;
import com.shsoftvina.erpshsoftvina.service.QRCodeService;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

@Service
public class QRCodeServiceImpl implements QRCodeService {

    @Override
    public byte[] generateQRCode(GenerateQRCodeRequest generateQRCodeRequest) throws WriterException, IOException {
        BitMatrix matrix = new MultiFormatWriter().encode(generateQRCodeRequest.getContent(), BarcodeFormat.QR_CODE, 300, 300);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        MatrixToImageWriter.writeToStream(matrix, "png", outputStream);
        return outputStream.toByteArray();
    }
}
