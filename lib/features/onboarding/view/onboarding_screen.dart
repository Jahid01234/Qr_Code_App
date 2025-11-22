import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/core/conts/app_colors.dart';
import 'package:qr_code_app/core/conts/app_size.dart';
import 'package:qr_code_app/core/conts/app_texts.dart';
import 'package:qr_code_app/core/global_widgets/custom_button.dart';
import 'package:qr_code_app/core/routes/routes.dart';
import 'package:qr_code_app/core/style/global_text_style.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: getHeight(30)),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: controller.skip,
                child: Text(
                  AppTexts.skip,
                  style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) => controller.currentIndex.value = index,
                itemCount: controller.onboardingPage.length,
                itemBuilder: (context, index) {
                  final item = controller.onboardingPage[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.icon,color: AppColors.white,size: 80,),
                      SizedBox(height: getHeight(48)),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: globalTextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: getHeight(15)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          item.subTitle,
                          textAlign: TextAlign.center,
                          style: globalTextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: getHeight(25)),
            // Dot Indicators
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.onboardingPage.length,
                      (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: controller.currentIndex.value == index ? 25 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                      controller.currentIndex.value == index
                          ?  AppColors.shadow.withValues(alpha: 0.7)
                          : AppColors.grey.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: getHeight(24)),
            // Next Button
            Obx(() {
              bool isLast = controller.currentIndex.value ==
                  controller.onboardingPage.length - 1;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: isLast
                    ? CustomButton(
                  title: AppTexts.getStarted,
                  icon: Icons.arrow_forward,
                  onTap: () => Get.offNamed(AppRoutes.home),
                )
                    : GestureDetector(
                  onTap: () {
                    controller.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: AppColors.appGradient2,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: getHeight(35)),
          ],
        ),
      ),
    );
  }
}