import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QrCodeGenerateController extends GetxController{
  final TextEditingController textEditingController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();
  RxString qrData = ''.obs;
  RxString selectedTye = 'text'.obs;

  final Map<String,TextEditingController> controller = {
    "name": TextEditingController(),
    "phone": TextEditingController(),
    "email": TextEditingController(),
    "url": TextEditingController(),
  };

  String generateQRData (){
    switch (selectedTye.value){
      case 'contact':
        return '''BEGIN:VCARD
        VERSION: 3.0
        FN: ${controller['name']?.text}
        TEL: ${controller['phone']?.text}
        EMAIL: ${controller['email']?.text}
        END:VCARD''';

      case 'url':
        String url = controller['url']?.text ?? "";
        if(!url.startsWith('http://') && !url.startsWith('https://')){
          url = 'https://$url';
        }
        return url;

      default :
        return textEditingController.text;
    }
  }



  Future<void> shareQRCode() async{
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/qr_code.png';
    final capture = await screenshotController.capture();
    if(capture == null) return;

    File imageFile = File(imagePath);
    await imageFile.writeAsBytes(capture);
    await Share.shareXFiles([XFile(imagePath)],text: "Share QR Code");
  }


}