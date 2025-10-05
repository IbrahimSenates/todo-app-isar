import 'package:database_work/models/todo_model.dart';
import 'package:database_work/services/database_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _databaseService = DatabaseService();
  final _textFieldController = TextEditingController();

  void _getTodoList() async {
    await _databaseService.fetchTodos();
    setState(() {});
  }

  void _addTodo() async {
    await _databaseService.addTodo(_textFieldController.text);
    _textFieldController.clear();
    _getTodoList();
    setState(() {});
  }

  void _updateTodo(Todo todo) async {
    await _databaseService.updateTodo(
      id: todo.id,
      text: todo.text!,
      isDone: todo.isDone,
    );
    setState(() {});
  }

  @override
  void initState() {
    _getTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Görev Uygulaması'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Column(children: [_addTodoWidget(), _todoListWidget()]),
      ),
    );
  }

  Expanded _todoListWidget() {
    return Expanded(
      child: ListView.separated(
        itemCount: _databaseService.currentTodos.length,
        itemBuilder: (context, index) {
          final Todo todo = _databaseService.currentTodos[index];
          return ListTile(
            title: Text(
              todo.text!,
              style: TextStyle(
                decoration: todo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(todo.dateTime.toString()),
            trailing: Checkbox(
              value: todo.isDone,
              onChanged: (isDone) {
                todo.isDone = isDone!;
                _updateTodo(todo);
              },
            ),
            tileColor: Colors.grey.shade100,
          );
        },
        separatorBuilder: (context, index) =>
            Divider(height: 0, color: Colors.blueGrey.shade100),
      ),
    );
  }

  Container _addTodoWidget() {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: _addTodo, icon: Icon(Icons.add)),
          border: OutlineInputBorder(),
          isDense: true,
          hintText: 'Bir şeyler yazın',
        ),
      ),
    );
  }
}
