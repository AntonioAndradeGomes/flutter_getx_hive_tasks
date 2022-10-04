import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/app/modules/home/controllers/home_controller.dart';
import 'package:getx_hive/app/modules/home/pages/widgets/dialog_todo.dart';
import 'package:getx_hive/app/modules/home/pages/widgets/tile_task.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tarefas',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            Dialog(
              child: DialogTodo(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: controller.obx(
        (todoList) => ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          itemCount: todoList!.length,
          itemBuilder: (_, index) => TileTask(
            task: todoList[index],
          ),
          separatorBuilder: (_, __) => const Divider(),
        ),
        onEmpty: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Não há nada na sua lista de tarefas',
              ),
              Text(
                'Adicione algumas tarefas para você!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
