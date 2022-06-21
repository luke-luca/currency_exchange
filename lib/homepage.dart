import 'package:currency_exchange/widgets/currency_changed.dart';
import 'package:currency_exchange/widgets/currency_chart_month.dart';
import 'package:currency_exchange/widgets/currency_chart_week.dart';
import 'package:currency_exchange/widgets/currency_form.dart';
import 'package:currency_exchange/widgets/currency_top.dart';
import 'package:flutter/material.dart';

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
        child: Stack(children: [
          Align(
            alignment: Alignment.topRight,
            child: Opacity(
              opacity: 0.5,
              child: SizedBox(
                width: 800,
                child: Image.asset(
                  '/img/background.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          //Set up media query to make the app responsive
          MediaQuery.of(context).size.width >= 900
              ? const ContentRow()
              : const ContentColumn(),
        ]),
      ),
    );
  }
}

//Stateless widget of main page
class ContentRow extends StatelessWidget {
  const ContentRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          flex: 1,
          child: CurrencyTop(),
        ),
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25,
                left: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: CurrencyChanged(),
                  ),
                  const Expanded(
                    child: CurrencyForm(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(
                        child: CurrencyChartWeek(),
                      ),
                      Expanded(
                        child: CurrencyChartMonth(),
                      )
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class ContentColumn extends StatelessWidget {
  const ContentColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Expanded(
        //   flex: 1,
        //   child: CurrencyTop(),
        // ),
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25,
                left: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CurrencyChanged(),
                  ),
                  Expanded(
                    child: CurrencyForm(),
                  ),
                  Expanded(
                    child: CurrencyChartWeek(),
                  ),
                  Expanded(
                    child: CurrencyChartMonth(),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
