import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_app/core/conts/app_colors.dart';
import 'package:qr_code_app/core/conts/app_size.dart';
import 'package:qr_code_app/core/conts/app_texts.dart';
import 'package:qr_code_app/core/global_widgets/app_back_button.dart';
import 'package:qr_code_app/core/global_widgets/custom_button.dart';
import 'package:qr_code_app/core/style/global_text_style.dart';
import 'package:qr_code_app/features/qr_scan/controller/qr_code_scanner_controller.dart';

class QrCodeScannerScreen extends StatelessWidget {
  QrCodeScannerScreen({super.key});

  final QrCodeScannerController controller =
      Get.find<QrCodeScannerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: getHeight(60)),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AppBackButton(title: AppTexts.qrCodeScanner),
          ),

          SizedBox(height: getHeight(40)),

          Expanded(
            child: Obx(
              () => controller.hasPermission.value
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned.fill(
                                child: MobileScanner(
                                  controller: controller.scannerController,
                                  fit: BoxFit.cover,
                                  onDetect: (capture) {
                                    final barcode =
                                        capture.barcodes.first.rawValue;
                                    controller.processScanData(barcode);
                                  },
                                ),
                              ),

                              // Scanner overlay box
                              Container(
                                width: 270,
                                height: 270,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    width: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        AppTexts.cameraPermission,
                        style: globalTextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => CustomButton(
                    onTap: () {
                      controller.isFlashOn.value = !controller.isFlashOn.value;
                      controller.scannerController.toggleTorch();
                    },
                    title: controller.isFlashOn.value
                        ? AppTexts.flashOn
                        : AppTexts.flashOff,
                    icon: controller.isFlashOn.value
                        ? Icons.flash_on
                        : Icons.flash_off,
                  ),
                ),

                CustomButton(
                  onTap: () {
                    controller.scannerController.start();
                  },
                  title: AppTexts.scanAgain,
                  icon: Icons.share,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
