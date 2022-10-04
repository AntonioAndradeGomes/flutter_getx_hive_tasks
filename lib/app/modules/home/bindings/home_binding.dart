import 'package:get/get.dart';
import 'package:getx_hive/app/modules/home/controllers/dialog_controller.dart';
import 'package:getx_hive/app/modules/home/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(),
      permanent: true,
    );
    Get.put<DialogController>(
      DialogController(),
      permanent: true,
    );
  }
}
