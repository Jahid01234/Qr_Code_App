import 'package:flutter/material.dart';
import 'package:qr_code_app/core/conts/app_texts.dart';


class OnboardingModel{
  final String title;
  final String subTitle;
  final IconData icon;

  OnboardingModel({
    required this.title,
    required this.subTitle,
    required this.icon,
  });

}

List<OnboardingModel> onboardingItemsListData = [
  OnboardingModel(
    title: AppTexts.onboardingTitle1,
    subTitle: AppTexts.onboardingSubtitle1,
    icon: Icons.qr_code_scanner,
  ),

  OnboardingModel(
    title: AppTexts.onboardingTitle2,
    subTitle: AppTexts.onboardingSubtitle2,
    icon: Icons.qr_code,
  ),

  OnboardingModel(
    title: AppTexts.onboardingTitle3,
    subTitle: AppTexts.onboardingSubtitle3,
    icon: Icons.qr_code_2_sharp,
  ),
];