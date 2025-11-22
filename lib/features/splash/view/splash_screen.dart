import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/core/conts/app_colors.dart';
import 'package:qr_code_app/core/conts/app_size.dart';
import 'package:qr_code_app/core/conts/app_texts.dart';
import 'package:qr_code_app/core/style/global_text_style.dart';
import 'package:qr_code_app/features/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  final SplashController controllers = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                gradient: AppColors.appGradient,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                  Icons.qr_code,
                  size: 70,
                  color: AppColors.white,
              ),
            ),
            SizedBox(height: getHeight(20)),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: AppTexts.qr,
                style: globalTextStyle(
                  color: AppColors.orangeAccent,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
                children: [
                  TextSpan(
                    text: AppTexts.codePro,
                    style: globalTextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
