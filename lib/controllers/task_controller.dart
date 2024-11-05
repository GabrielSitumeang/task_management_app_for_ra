import 'package:get/get.dart';
import 'package:ra_app/models/task.dart';

import '../db/db_helper.dart';

class TaskController extends GetxController {
  //this will hold the data and update the ui

  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  final RxList<Task> taskList = new RxList<Task>();

  // add data to table
  Future<int> addTask(Task task) async {
    return await DBHelper.insert(task);
  }

  // get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  // delete data from table
  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  // update data int table
  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
