import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/screens/screen_index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shopping mall',
      routes: {
        '/index': (context) => IndexScreen(),
      },
      initialRoute: '/index',
    );
  }
}
