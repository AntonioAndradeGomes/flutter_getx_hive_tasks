import 'package:get/get.dart';
import 'package:getx_hive/app/data/models/task.dart';
import 'package:hive_flutter/adapters.dart';

class HomeController extends GetxController with StateMixin<List<TaskModel>?> {
  final _todoList = <TaskModel>[];
  final _boxTask = Get.find<Box<TaskModel>>();

  @override
  void onInit() {
    super.onInit();
    _buildTasks();
  }

  Future<void> _buildTasks() async {
    if (_boxTask.isEmpty) {
      change(
        null,
        status: RxStatus.empty(),
      );
    } else {
      _todoList.clear();
      _todoList.addAll(
        _boxTask.toMap().values.toList(),
      );
      change(
        _todoList,
        status: RxStatus.success(),
      );
    }
  }

  Future<void> addTask({
    required String title,
    String? description,
    String? tag,
    bool done = false,
  }) async {
    int id = DateTime.now().millisecond;
    final task = TaskModel(
      id: id,
      title: title,
      description: description ?? '',
      done: done,
    );
    _todoList.add(task);
    await _boxTask.add(task);
    change(
      _todoList,
      status: RxStatus.success(),
    );
  }

  void changeStatus(
    TaskModel task,
    bool newValue,
  ) async {
    final todo = _todoList[_todoList.indexOf(task)];
    todo.done = newValue;
    await todo.save();
    change(
      _todoList,
      status: RxStatus.success(),
    );
  }

  Future<void> updateTask(
    TaskModel? todo, {
    required String title,
    String? description,
    String? tag,
    required bool done,
  }) async {
    int index = _todoList.indexOf(todo!);
    final task = _todoList[index];
    task.title = title;
    task.description = description;
    task.done = done;
    await task.save();
    change(
      _todoList,
      status: RxStatus.success(),
    );
  }

  Future<void> deleteTask(
    TaskModel? todo,
  ) async {
    int index = _todoList.indexOf(todo!);
    final task = _todoList[index];
    await task.delete();
    _todoList.remove(task);
    if (_todoList.isEmpty) {
      change(
        null,
        status: RxStatus.empty(),
      );
    } else {
      change(
        _todoList,
        status: RxStatus.success(),
      );
    }
  }
}
