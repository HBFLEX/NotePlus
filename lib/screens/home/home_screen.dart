import 'package:flutter/material.dart';
import 'package:note_plus/components/floating_button/floating_action_button.dart';
import 'package:note_plus/components/text_input/text_input.dart';
import 'package:note_plus/components/todo/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _todoTitleController = TextEditingController();
  final TextEditingController _todoContentController = TextEditingController();

  List<Todo> _todos = [];

  // first app initial launch state
  @override
  void initState() {
    if (_todos.isEmpty) {
      _todos = [
        Todo(title: 'Welcome to To-do+', content: 'Create awesome todo\'s', isCompleted: false, toggleCheckbox: null, removeTodoItem: null,),
        Todo(title: 'Get started', content: 'Click the + button below', isCompleted: false, toggleCheckbox: null, removeTodoItem: null,),
      ];
    }
    super.initState();
  }

  // dispose text editing controllers
  @override
  void dispose(){
    _todoTitleController.dispose();
    _todoContentController.dispose();
    super.dispose();
  }

  void toggleTodo(bool? value, index) {
    setState(() {
      _todos[index].isCompleted = !_todos[index].isCompleted;
    });
  }

  void closeModalBottomSheet() {
    Navigator.pop(context);
  }

  void saveTodoItem() {
    if (_todoContentController.text.isNotEmpty) {
      setState(() {
        _todos.add(Todo(
          title: _todoTitleController.text,
          content: _todoContentController.text,
          isCompleted: false,
          toggleCheckbox: null,
          removeTodoItem: null,
        ));
      });
      _todoTitleController.text = '';
      _todoContentController.text = '';
      Navigator.pop(context);
    } else {
      _todoContentController.text = 'This field should be set';
    }
  }

  void deleteTodoItem(index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

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
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  return Todo(
                    title: _todos[index].title,
                    content: _todos[index].content,
                    isCompleted: _todos[index].isCompleted,
                    toggleCheckbox: (value) => toggleTodo(value, index),
                    removeTodoItem: (context) => deleteTodoItem(index),
                  );
                },
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
