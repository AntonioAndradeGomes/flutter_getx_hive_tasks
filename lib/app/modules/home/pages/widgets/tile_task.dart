import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/app/data/models/task.dart';
import 'package:getx_hive/app/modules/home/controllers/home_controller.dart';
import 'package:getx_hive/app/modules/home/pages/widgets/dialog_todo.dart';

class TileTask extends StatelessWidget {
  final TaskModel task;
  const TileTask({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.dialog(
          Dialog(
            child: DialogTodo(
              task: task,
            ),
          ),
        );
      },
      title: Text(task.title),
      subtitle: Text(
        task.description ?? '',
      ),
      leading: Checkbox(
        shape: const CircleBorder(),
        //tristate: true,
        value: task.done,
        onChanged: (newValue) {
          Get.find<HomeController>().changeStatus(
            task,
            newValue!,
          );
        },
      ),
    );
  }
}
