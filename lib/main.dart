import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/app/app_widget.dart';
import 'package:getx_hive/app/data/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

//inicializar o hive
Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Box<TaskModel> taskBox = await Hive.openBox<TaskModel>('tasks');
  Get.put<Box<TaskModel>>(
    taskBox,
    permanent: true,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  runApp(const AppWidget());
}
