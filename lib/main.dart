import 'package:database_work/screens/home_screen.dart';
import 'package:database_work/services/database_service.dart';
import 'package:flutter/material.dart';

void main() async {
  //Flutter ı hazırla
  WidgetsFlutterBinding.ensureInitialized();

  //Veritabanını başlat
  await DatabaseService.initialize();

  //widgetları çiz
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
