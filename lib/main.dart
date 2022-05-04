import 'package:flutter/material.dart';
import 'package:todo_app/shared/styles/themes.dart';

import 'layout/app_layout.dart';

 void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: const TodoMain() ,
    );
  }
}

