import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/core/conts/app_colors.dart';
import 'package:qr_code_app/core/conts/app_size.dart';
import 'package:qr_code_app/core/style/global_text_style.dart';

class AppBackButton extends StatelessWidget {
  final String title;

  const AppBackButton({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
              Icons.arrow_back,
              color: AppColors.white,
          ),
        ),
        SizedBox(width: getWidth(30)),
        Text(
          title,
          style: globalTextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}