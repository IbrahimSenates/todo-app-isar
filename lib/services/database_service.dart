import 'package:database_work/models/todo_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static late Isar isar;

  //Isar başlatılsın
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([TodoSchema], directory: dir.path);
  }

  //Görevler için liste oluştur
  List<Todo> currentTodos = [];

  //Görev ekle
  Future<void> addTodo(String text) async {
    final newTodo = Todo()..text = text;

    isar.writeTxn(() => isar.todos.put(newTodo));

    await fetchTodos();
  }

  //Görevleri getir
  Future<void> fetchTodos() async {
    currentTodos = await isar.todos.where().findAll();
  }

  //Görev güncelle

  Future<void> updateTodo({
    required int id,
    required String text,
    bool isDone = false,
  }) async {
    final existingTodo = await isar.todos.get(id);
    if (existingTodo != null) {
      existingTodo
        ..text = text
        ..isDone = isDone;
      await isar.writeTxn(() => isar.todos.put(existingTodo));
    }
    await fetchTodos();
  }

  //Görev sil

  Future<void> deleteTodo(int id) async {
    await isar.writeTxn(() => isar.todos.delete(id));
    await fetchTodos();
  }
}
