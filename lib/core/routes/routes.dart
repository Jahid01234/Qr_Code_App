import 'package:get/get.dart';
import 'package:qr_code_app/features/home/view/home_screen.dart';
import 'package:qr_code_app/features/onboarding/view/onboarding_screen.dart';
import 'package:qr_code_app/features/qr_generate/view/qr_code_generate_screen.dart';
import 'package:qr_code_app/features/qr_scan/view/qr_code_scanner_screen.dart';
import 'package:qr_code_app/features/splash/view/splash_screen.dart';

class AppRoutes{
  // Get routes name here.................
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String qrCodeGenerate = '/qrCodeGenerate';
  static const String qrCodeScanner = '/qrCodeScanner';





  // Get routes here.................
  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.leftToRight,
      ),
    GetPage(
      name: onboarding,
      page: () => OnboardingScreen(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transition: Transition.leftToRight,
      ),
    GetPage(
      name: qrCodeGenerate,
      page: () => QrCodeGenerateScreen(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: qrCodeScanner,
      page: () => QrCodeScannerScreen(),
      transition: Transition.leftToRight,
    ),
  ];


}