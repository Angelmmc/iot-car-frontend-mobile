import 'package:flutter/material.dart';
import 'package:front_end_iot/screens/home_screen.dart';
//My widget

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carro IoT',
      home: HomeScreen(),
    );
  }
}
