import 'package:isar/isar.dart';
part 'todo_model.g.dart';

@collection
class Todo {
  Id id = Isar.autoIncrement;
  String? text;
  DateTime dateTime = DateTime.now();

  bool isDone = false;

  //dart run build_runner build komutunu run ettik ve .g.dart oluştu
}
