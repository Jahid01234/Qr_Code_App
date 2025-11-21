import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/core/conts/app_colors.dart';
import 'package:qr_code_app/core/conts/app_size.dart';
import 'package:qr_code_app/core/conts/app_texts.dart';
import 'package:qr_code_app/core/global_widgets/app_back_button.dart';
import 'package:qr_code_app/core/global_widgets/custom_button.dart';
import 'package:qr_code_app/features/qr_generate/controller/qr_code_generate_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrCodeGenerateScreen extends StatelessWidget {
  QrCodeGenerateScreen({super.key});

  final QrCodeGenerateController controllers =
      Get.find<QrCodeGenerateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: getHeight(50)),
            AppBackButton(title: AppTexts.generateQrCode),
            SizedBox(height: getHeight(70)),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: AppColors.appGradient2,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Obx(
                    () => SegmentedButton<String>(
                      segments: const <ButtonSegment<String>>[
                        ButtonSegment(
                          value: "text",
                          label: Text(
                            AppTexts.text,
                            style: TextStyle(
                                color: AppColors.white,
                            ),
                          ),
                          icon: Icon(
                              Icons.text_fields,
                              color: AppColors.white,
                          ),
                        ),
                        ButtonSegment(
                          value: "url",
                          label: Text(
                            AppTexts.url,
                            style: TextStyle(
                                color: AppColors.white,
                            ),
                          ),
                          icon: Icon(
                              Icons.text_fields,
                              color: AppColors.white,
                          ),
                        ),
                        ButtonSegment(
                          value: "contact",
                          label: Text(
                            AppTexts.contact,
                            style: TextStyle(
                                color: AppColors.white,
                            ),
                          ),
                          icon: Icon(
                            Icons.contact_page,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                      selected: <String>{controllers.selectedTye.value},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                              if (states.contains(MaterialState.selected)) {
                                return AppColors.grey;
                              }
                              return Colors.transparent;
                            }),
                      ),
                      onSelectionChanged: (Set<String> selection) {
                        if (selection.isNotEmpty) {
                          controllers.selectedTye.value = selection.first;
                        }
                        controllers.qrData.value = controllers.generateQRData();
                      },
                    ),
                  ),
                  SizedBox(height: getHeight(20)),
                  //Input fields when selected type changes
                  Obx(() => _buildInputFields()),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // show current qrData (for debug / preview)
            Obx(
              () => controllers.qrData.isNotEmpty
                  ? Column(
                      children: [
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Screenshot(
                              controller: controllers.screenshotController,
                              child: QrImageView(
                                data: controllers.qrData.value,
                                size: 200,
                                version: QrVersions.auto,
                                errorCorrectionLevel: QrErrorCorrectLevel.H,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getHeight(50)),
                        CustomButton(
                          onTap: controllers.shareQRCode,
                          title: AppTexts.shareQrCode,
                          icon: Icons.share,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  // Build text field.............................
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: AppColors.white),
          ),
        ),
        onChanged: (_) {
          controllers.qrData.value = controllers.generateQRData();
        },
      ),
    );
  }


  // Build input field.............................
  Widget _buildInputFields() {
    switch (controllers.selectedTye.value) {
      case 'contact':
        return Column(
          children: [
            _buildTextField(controllers.controller['name']!, AppTexts.name),
            _buildTextField(controllers.controller['phone']!, AppTexts.phone),
            _buildTextField(controllers.controller['email']!, AppTexts.email),
          ],
        );

      case 'url':
        return _buildTextField(controllers.controller['url']!, AppTexts.url);

      default:
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextField(
            controller: controllers.textEditingController,
            style: TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              labelText: AppTexts.enterText,
              labelStyle: TextStyle(color: AppColors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide(color: AppColors.white),
              ),
            ),
            onChanged: (value) {
              controllers.qrData.value = controllers.generateQRData();
            },
          ),
        );
    }
  }
}
