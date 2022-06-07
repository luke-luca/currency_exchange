import 'package:currency_exchange/widgets/currency_changed.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
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
          children: const [
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     height: double.infinity,
            //     child: CurrencyTop(),
            //   ),
            // ),
            // Expanded(
            //   flex: 4,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text('Broke Currency Exchange'),
            //       //CurrencyForm(),
            //     ],
            //   ),
            // ),
            Expanded(
              child: CurrencyChanged(),
            )
          ],
        ),
      ),
    );
  }
}
