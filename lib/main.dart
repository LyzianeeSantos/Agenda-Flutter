import 'package:flutter/material.dart';
import 'contact_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Agenda',
      theme: ThemeData.dark(),  // Dark mode enabled
      home: ContactListScreen(),
    );
  }
}