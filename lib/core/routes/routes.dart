import 'package:get/get.dart';
import 'package:qr_code_app/features/home/view/home_screen.dart';

class AppRoutes{
  // Get routes name here.................
  static const String splash = '/splash';
  static const String home = '/home';



  // Get routes here.................
  static List<GetPage> routes = [
    // GetPage(
    //   name: splash,
    //   page: () {
    //    //............
    //   },
    //   transition: Transition.leftToRight,
    //   )
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transition: Transition.leftToRight,
      ),
  ];


}