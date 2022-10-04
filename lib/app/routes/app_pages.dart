import 'package:get/get.dart';
import 'package:getx_hive/app/modules/home/bindings/home_binding.dart';
import 'package:getx_hive/app/modules/home/pages/home_page.dart';
import 'package:getx_hive/app/routes/app_routes.dart';

abstract class AppPages {
  static const INITIAL = AppRoutes.HOME;

  static final pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    )
  ];
}
