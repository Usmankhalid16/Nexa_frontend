
import 'package:get/get.dart';

import '../Database/database.dart';
import '../models/tasks.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
    getTasks();
    super.onReady();
  }
  // var taskList = <Task>[].obs;
  final RxList<Task> taskList = List<Task>.empty().obs;

  Future<int> addTask({required Task? task}) async{
    return await DB.insert(task);
  }

  void getTasks() async{
    List<Map<String, dynamic>> tasks = await DB.query();
    taskList.assignAll(tasks.map((data)=> Task.fromJson(data)).toList());
  }

  void delete(Task task){
  DB.delete(task);
  getTasks();
  }
  void markcomp(int id)async{
    await DB.update(id);
    getTasks();
  }
}
