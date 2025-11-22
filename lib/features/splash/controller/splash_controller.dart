import 'package:get/get.dart';
import 'package:qr_code_app/core/routes/routes.dart';

class SplashController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    redirectToNextScreen();
  }


  Future<void> redirectToNextScreen()async{
    await Future.delayed( const Duration(seconds: 2));
    Get.offNamed(AppRoutes.onboarding);
  }
}


