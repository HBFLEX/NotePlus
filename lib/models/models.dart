import 'package:objectbox/objectbox.dart';


@Entity()
class Todo{
  @Id()
  int id;

  String title;
  String content;
  bool isCompleted;

  Todo({
    this.id = 0,
    required this.title,
    required this.content,
    required this.isCompleted,
  });
}



