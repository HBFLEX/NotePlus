
import 'package:note_plus/models/models.dart';
import 'package:note_plus/objectbox.g.dart';


class ObjectBox{
  late final Store _store;
  late final Box<Todo> _todoBox; 

  ObjectBox._init(this._store){
    _todoBox = Box<Todo>(_store);
  }

  static Future<ObjectBox> init() async{
    final store = await openStore();
    return ObjectBox._init(store);
  }

  Todo? getTodo(int id) => _todoBox.get(id);
  int insertTodo(Todo todo) => _todoBox.put(todo);
  bool deleteTodo(int index) => _todoBox.remove(index);

  Stream<List<Todo>> getAllTodos() => _todoBox
  .query()
  .watch(triggerImmediately: true)
  .map((query) => query.find());
}

