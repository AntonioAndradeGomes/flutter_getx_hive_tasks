import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/app/data/models/task.dart';
import 'package:getx_hive/app/modules/home/controllers/dialog_controller.dart';
import 'package:getx_hive/app/modules/home/controllers/home_controller.dart';

class DialogTodo extends GetView<DialogController> {
  final TaskModel? task;
  DialogTodo({
    Key? key,
    this.task,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final titleTextController = TextEditingController(
      text: task == null ? '' : task!.title,
    );
    final descriptionTextController = TextEditingController(
      text: task == null ? '' : task?.description ?? '',
    );
    controller.taskCheck.value = task == null ? false : task!.done;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            'Adicione uma tarefa!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleTextController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: descriptionTextController,
                    minLines: 2,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      isDense: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Obx(
                      () => CheckboxListTile(
                        title: const Text('Tarefa está finalizada?'),
                        value: controller.taskCheck.value,
                        checkboxShape: const CircleBorder(),
                        onChanged: (newVal) {
                          controller.taskCheck.value = newVal!;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: ElevatedButton(
                      child: Text(
                        task != null ? 'Atualizar' : 'Adicionar',
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (task == null) {
                            Get.find<HomeController>().addTask(
                              title: titleTextController.text,
                              description: descriptionTextController.text,
                              done: controller.taskCheck.value,
                            );
                          } else {
                            Get.find<HomeController>().updateTask(
                              task,
                              title: titleTextController.text,
                              description: descriptionTextController.text,
                              done: controller.taskCheck.value,
                            );
                          }
                          Get.close(0);
                        }
                      },
                    ),
                  ),
                  if (task != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: ElevatedButton(
                        child: const Text('Deletar Tarefa'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Get.find<HomeController>().deleteTask(
                              task,
                            );
                            Get.close(0);
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
