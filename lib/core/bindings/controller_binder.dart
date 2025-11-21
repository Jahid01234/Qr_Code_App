import 'package:get/get.dart';
import 'package:qr_code_app/features/qr_generate/controller/qr_code_generate_controller.dart';
import 'package:qr_code_app/features/qr_scan/controller/qr_code_scanner_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(QrCodeGenerateController());
    Get.put(QrCodeScannerController());
  }

}