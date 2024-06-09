import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_plus/components/todo/todo.dart';


class LocalStorage{
  
  // primary storage
  List<Todo> todos = [];
  // reference to the hive box
  final _box = Hive.box('todosDB');

  void createInitialDataOnAppFirstLoad(){
    // ignore: unused_local_variable
    todos = [
      Todo(title: 'Welcome to To-do+', content: 'Create awesome todo\'s', isCompleted: false, toggleCheckbox: null, removeTodoItem: null,),
      Todo(title: 'Get started', content: 'Click the + button below', isCompleted: false, toggleCheckbox: null, removeTodoItem: null,),
    ];
  }

  void getTodos(){
     todos = _box.get('TODOLIST');
     print(todos);
  }

  void updateTodos(){
    _box.put('TODOLIST', todos);
    print(todos);
  }

}