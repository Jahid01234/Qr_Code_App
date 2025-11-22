import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/core/bindings/controller_binder.dart';
import 'package:qr_code_app/core/conts/app_colors.dart';
import 'package:qr_code_app/core/conts/app_size.dart';
import 'package:qr_code_app/core/routes/routes.dart';


class QrCodeApp extends StatelessWidget {
  const QrCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return GetMaterialApp(
      title: 'QR Code Pro',
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.appPrimary,
      ),
    );
  }
}