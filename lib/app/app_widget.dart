import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/app/routes/app_pages.dart';
import 'package:getx_hive/app/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo - Hive',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
    );
  }
}
