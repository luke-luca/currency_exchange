import 'package:currency_exchange/api_hub.dart';
import 'package:currency_exchange/models/currency.dart';
import 'package:currency_exchange/models/currency_timeseries.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/rate_timeseries.dart';

class CurrencyChartWeek extends StatefulWidget {
  const CurrencyChartWeek({Key? key}) : super(key: key);

  @override
  State<CurrencyChartWeek> createState() => _CurrencyChartWeekState();
}

class _CurrencyChartWeekState extends State<CurrencyChartWeek> {
  late List<ChartData> chartData;
  late Future<CurrencyTimeseries> currencyTimeseriesWeekly;
  late Future<CurrencyTimeseries> currencyTimeseriesMonthly;

  int _dayMinus = 8;
  int _dayMinusWeekly = 0;
  int _dayMinusMonthly = 0;
  int _dayMinuss = 31;

  late DateTime _startDateWeekly;
  late DateTime _endDateWeekly;

  late DateTime _startDateMonthly;
  late DateTime _endDateMonthly;

  Future<CurrencyTimeseries> _fetchDataWeekly(
      {required DateTime startDateWeekly,
      required DateTime endDateWeekly}) async {
    return await ApiHub().fetchTimeseries(
      Currency.EUR,
      endDateWeekly,
      startDateWeekly,
      [Currency.GBP, Currency.USD, Currency.PLN],
    );
  }

  Future<CurrencyTimeseries> _fetchDataMonthly(
      {required DateTime startDateMonthly, required endDateMonthly}) async {
    return await ApiHub().fetchTimeseries(
      Currency.EUR,
      endDateMonthly,
      startDateMonthly,
      [Currency.GBP, Currency.USD, Currency.PLN],
    );
  }

  @override
  void initState() {
    super.initState();
    _startDateWeekly = DateTime.now().subtract(Duration(days: _dayMinus));
    _endDateWeekly = DateTime.now().subtract(Duration(days: _dayMinusWeekly));
    _startDateMonthly = DateTime.now().subtract(Duration(days: _dayMinuss));
    _endDateMonthly = DateTime.now().subtract(Duration(days: _dayMinusWeekly));
    chartData = [];
    currencyTimeseriesWeekly = _fetchDataWeekly(
        startDateWeekly: _startDateWeekly, endDateWeekly: _endDateWeekly);
    currencyTimeseriesMonthly = _fetchDataMonthly(
        startDateMonthly: _startDateMonthly, endDateMonthly: _endDateMonthly);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Wykres Tygodniowy
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _dayMinus = _dayMinus + 8;
                  _dayMinusWeekly = _dayMinusWeekly + 8;
                  _startDateWeekly =
                      DateTime.now().subtract(Duration(days: _dayMinus));
                  _endDateWeekly =
                      DateTime.now().subtract(Duration(days: _dayMinusWeekly));
                });
              },
              child: const Text('Poprzedni Tydzien'),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _dayMinus = _dayMinus - 8;
                    _dayMinusWeekly = _dayMinusWeekly - 8;
                    _startDateWeekly =
                        DateTime.now().subtract(Duration(days: _dayMinus));
                    _endDateWeekly = DateTime.now()
                        .subtract(Duration(days: _dayMinusWeekly));
                  });
                },
                child: const Text('Nastepny Tydzien')),
          ],
        ),
        FutureBuilder<CurrencyTimeseries>(
            future: currencyTimeseriesWeekly,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                CurrencyTimeseries data = snapshot.data!;
                int index = 0;
                for (Rate rate in data.rates.values) {
                  chartData.add(ChartData(
                    DateFormat.yMd().format(data.rates.keys.toList()[index]),
                    rate.pln,
                  ));
                  index++;
                }
                return SfCartesianChart(
                  title: ChartTitle(text: 'Weekly Currency Exchange'),
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    LineSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData sales, _) => sales.x,
                      yValueMapper: (ChartData sales, _) => sales.y,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            }),
        //Wykres miesięczny
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _dayMinus = _dayMinus + 8;
                  _dayMinusWeekly = _dayMinusWeekly + 8;
                  _startDateWeekly =
                      DateTime.now().subtract(Duration(days: _dayMinus));
                  _endDateWeekly =
                      DateTime.now().subtract(Duration(days: _dayMinusWeekly));
                });
              },
              child: const Text('Poprzedni Miesiac'),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _dayMinus = _dayMinus - 8;
                    _dayMinusWeekly = _dayMinusWeekly - 8;
                    _startDateWeekly =
                        DateTime.now().subtract(Duration(days: _dayMinus));
                    _endDateWeekly = DateTime.now()
                        .subtract(Duration(days: _dayMinusWeekly));
                  });
                },
                child: const Text('Nastepny Tydzien')),
          ],
        ),
        FutureBuilder<CurrencyTimeseries>(
            future: currencyTimeseriesMonthly,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                CurrencyTimeseries data = snapshot.data!;
                int index = 0;
                for (Rate rate in data.rates.values) {
                  chartData.add(ChartData(
                    DateFormat.yMd().format(data.rates.keys.toList()[index]),
                    rate.pln,
                  ));
                  index++;
                }
                return SfCartesianChart(
                  title: ChartTitle(text: 'Weekly Currency Exchange'),
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    LineSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData sales, _) => sales.x,
                      yValueMapper: (ChartData sales, _) => sales.y,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
  @override
  String toString() => '$x, $y';
}
