import 'package:flutter/material.dart';
import 'package:machine_test_kawika_technologies/screens/users_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const UsersPage(title: 'Users'),
    );
  }
}
