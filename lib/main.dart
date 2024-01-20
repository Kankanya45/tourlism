import 'package:flutter/material.dart';
import 'package:tourlism_root_641463010/flash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlashScreen(), //เรียกใช้หน้าsplash_screen.dart เป็นหน้าเเรก
    );
  }
}
