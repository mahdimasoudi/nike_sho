import 'package:flutter/material.dart';
import 'package:nike_shop/screen/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          onSecondary: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: Directionality(textDirection: TextDirection.rtl, child: Home()),
    );
  }
}
