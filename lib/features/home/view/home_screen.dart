import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/core/conts/app_colors.dart';
import 'package:qr_code_app/core/conts/app_size.dart';
import 'package:qr_code_app/core/conts/app_texts.dart';
import 'package:qr_code_app/core/routes/routes.dart';
import 'package:qr_code_app/core/style/global_text_style.dart';
import 'package:qr_code_app/features/home/view/widgets/qr_feature_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: getHeight(80)),
            Center(
              child: Text(
                AppTexts.qrCodePro,
                style: globalTextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: getHeight(100)),
            QrFeatureButton(
              iconData: Icons.qr_code,
                text:  AppTexts.generateQrCode,
              onTap: (){
                Get.toNamed(AppRoutes.qrCodeGenerate);
              },
            ),
            QrFeatureButton(
              iconData: Icons.qr_code_scanner,
              text:  AppTexts.scanQrCode,
              onTap: (){
                Get.toNamed(AppRoutes.qrCodeScanner);
              },
            ),
          ],
        ),
      ),
    );
  }
}

