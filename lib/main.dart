import 'package:currency_exchange/widgets/currency_changed.dart';
import 'package:currency_exchange/widgets/currency_chart_week.dart';
import 'package:currency_exchange/widgets/currency_form.dart';
import 'package:currency_exchange/widgets/currency_top.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CurrencyTop(),
            ),
            Expanded(
              child: CurrencyForm(),
            ),
            Expanded(
              child: CurrencyChanged(),
            ),
            Expanded(
              child: CurrencyChartWeek(),
            ),
          ],
        ),
      ),
    );
  }
}
