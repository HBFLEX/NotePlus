import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';



// ignore: must_be_immutable
class TodoCard extends StatelessWidget {
  String title;
  String content;
  bool isCompleted;
  void Function(bool?)? toggleCheckbox;
  void Function(BuildContext)? removeTodoItem;

  TodoCard({
    super.key,
    required this.title,
    required this.content,
    required this.isCompleted,
    required this.toggleCheckbox,
    required this.removeTodoItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: removeTodoItem,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: isCompleted
                ? const Color.fromARGB(255, 211, 117, 63)
                : Colors.grey.shade900,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 180,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: isCompleted ? Colors.black87 : Colors.grey,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 220,
                    child: Text(
                      content,
                      style: TextStyle(
                        color: isCompleted ? Colors.black45 : Colors.grey,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              Transform.scale(
                scale: 1.7,
                child: Checkbox(
                  value: isCompleted,
                  onChanged: toggleCheckbox,
                  activeColor: Colors.black,
                  checkColor: const Color.fromARGB(255, 240, 238, 238),
                  side: const BorderSide(color: Colors.grey, width: 1.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
