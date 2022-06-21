import 'package:currency_exchange/consts.dart';
import 'package:currency_exchange/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Exchanger',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: lightVioletColor,
        ),
        fontFamily: 'Neue Plak Regular',
      ),
      home: const HomePage(),
    );
  }
}
