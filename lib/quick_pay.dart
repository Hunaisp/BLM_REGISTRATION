import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

class QuickPay extends StatelessWidget {
  final String phoneNumber = '9876543210';

  // Replace with the actual phone number
  final String payeeName = 'John Doe'; // Replace with the actual payee name
  final String amount = '1000'; // Replace with the actual amount
  final String currency = 'INR'; // Currency code

  @override
  Widget build(BuildContext context) {
    final String upiLink = 'upi://pay?pa=$phoneNumber@upi&pn=$payeeName&am=$amount&cu=$currency';
    GlobalKey globalKey = new GlobalKey();

    Future<void> _captureAndShareQrCode() async {
      try {
        // Request storage permissions if not granted
        if (await Permission.storage.request().isGranted) {
          RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

          // Ensure the boundary is valid
          if (boundary != null) {
            ui.Image image = await boundary.toImage(pixelRatio: 3.0); // Adjust pixelRatio as needed

            // Check if the image is captured
            if (image != null) {

              ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

              // Check if byteData is not null
              if (byteData != null) {
                Uint8List pngBytes = byteData.buffer.asUint8List();

                final tempDir = await getTemporaryDirectory();
                final file = await new File('${tempDir.path}/qr_code.png').create();
                await file.writeAsBytes(pngBytes);

                // Create XFile object from file path
                XFile xFile = XFile(file.path);

                // Share the QR code image
                Share.shareXFiles([xFile], text: 'Scan this QR code to make a payment using Google Pay');
              } else {
                print('Byte data is null');
              }
            } else {
              print('Failed to capture image');
            }
          } else {
            print('Render boundary is null');
          }
        } else {
          print('Permission denied');
        }
      } catch (e) {
        print('Error capturing QR code: ${e.toString()}');
      }
    }




    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54B435),
        centerTitle: true,
        title: Text('Quick Pay'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scan to Pay with Google Pay',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                key: globalKey,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.r,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImageView(
                    data: upiLink,
                    version: QrVersions.auto,
                    size: 280.sp,
                    gapless: false,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Use Google Pay to scan the QR code and make a quick payment.',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Color(0xFF666666),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              ElevatedButton.icon(
                onPressed: _captureAndShareQrCode,
                icon: Icon(Icons.share),
                label: Text('Share QR Code'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF54B435),
                  textStyle: TextStyle(fontSize: 16.sp),
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
