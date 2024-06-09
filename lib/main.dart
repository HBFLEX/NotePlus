import 'package:flutter/material.dart';
import 'package:note_plus/screens/home/home_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Poppins'
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
