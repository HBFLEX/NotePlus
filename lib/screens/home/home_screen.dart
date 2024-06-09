import 'package:flutter/material.dart';
import 'package:note_plus/components/floating_button/floating_action_button.dart';
import 'package:note_plus/components/text_input/text_input.dart';
import 'package:note_plus/components/todo/todo.dart';
import 'package:note_plus/models/models.dart';
import 'package:note_plus/object_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _todoTitleController = TextEditingController();
  final TextEditingController _todoContentController = TextEditingController();

  late ObjectBox objectBox;
  late Stream<List<Todo>> _todos;

  // first app initial launch state
  @override
  void initState() {
    super.initState();
    _initObjectBox();
  }

  Future<void> _initObjectBox() async {
    objectBox = await ObjectBox.init(); // Ensure this method initializes ObjectBox properly.
    setState(() {
      _todos = objectBox.getAllTodos();
    });
  }

  // dispose text editing controllers
  @override
  void dispose(){
    _todoTitleController.dispose();
    _todoContentController.dispose();
    super.dispose();
  }

  // void toggleTodo(bool? value, index) {
  //   setState(() {
  //     _todos[index].isCompleted = !_todos[index].isCompleted;
  //   });
  // }

  void closeModalBottomSheet() {
    Navigator.pop(context);
  }

  void saveTodoItem() {
    if (_todoContentController.text.isNotEmpty) {
      setState(() {
        Todo todo = Todo(
          title: _todoTitleController.text,
          content: _todoContentController.text,
          isCompleted: false,
        );
        objectBox.insertTodo(todo);
      });
      _todoTitleController.text = '';
      _todoContentController.text = '';
      Navigator.pop(context);
    } else {
      _todoContentController.text = 'This field should be set';
    }
  }

  // void deleteTodoItem(index) {
  //   setState(() {
  //     _todos.removeAt(index);
  //   });
  // }

  void addTodoItem() {
    // display the alert dialog
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: 280,
            decoration: const BoxDecoration(
              color: Colors.black87,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                        onPressed: closeModalBottomSheet,
                      ),
                      const Text(
                        'New To-do',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // text field
                const SizedBox(
                  height: 15,
                ),
                TextInput(
                  controller: _todoTitleController,
                  labelText: 'Todo title',
                  icon: const Icon(
                    Icons.title,
                    color: Colors.black45,
                  ),
                ),
                TextInput(
                  controller: _todoContentController,
                  labelText: 'Todo content',
                  icon: const Icon(
                    Icons.book,
                    color: Colors.black45,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: saveTodoItem,
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(35),
              child: const Row(
                children: [
                  Text(
                    'To-do',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.add, color: Colors.white70),
                ],
              ),
            ),
            // display all the local storage todos here
            Expanded(
              child: StreamBuilder<List<Todo>>(
                stream: _todos,
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  else{
                    final todos = snapshot.data!;
                    return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return TodoCard(
                        title: todos[index].title,
                        content: todos[index].content,
                        isCompleted: todos[index].isCompleted,
                        toggleCheckbox: (value){
                          todos[index].isCompleted = !todos[index].isCompleted;
                          objectBox.insertTodo(todos[index]);
                        },
                        removeTodoItem: (context) =>{
                          objectBox.deleteTodo(todos[index].id)
                        },
                      );
                    },
                  );
                  }
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButtonCustom(
        onPressed: addTodoItem,
      ),
    );
  }
}
