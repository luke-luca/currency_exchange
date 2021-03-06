import 'package:currency_exchange/api_hub.dart';
import 'package:currency_exchange/consts.dart';
import 'package:currency_exchange/models/chart_data.dart';
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
  late Future<CurrencyTimeseries> currencyTimeseries;

  late DateTime _startDate;
  late DateTime _endDate;
  int position = 0;
  //Fetch data from API to build weekly chart
  Future<CurrencyTimeseries> _fetchData(
      {required DateTime startDate, required DateTime endDate}) async {
    return await ApiHub().fetchTimeseries(
      Currency.EUR,
      endDate,
      startDate,
      [Currency.GBP, Currency.USD, Currency.PLN],
    );
  }

  //Setup initial state of the widget
  @override
  void initState() {
    _startDate = DateTime.now().subtract(const Duration(days: 6));
    _endDate = DateTime.now();
    currencyTimeseries = _fetchData(startDate: _startDate, endDate: _endDate);
    chartData = [];
    super.initState();
  }

  //Build the widget that contain the chart
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: elevatedButtonStyle,
              onPressed: () {
                setState(() {
                  _startDate = _startDate.subtract(const Duration(days: 7));
                  _endDate = _endDate.subtract(const Duration(days: 7));
                  currencyTimeseries = currencyTimeseries =
                      _fetchData(startDate: _startDate, endDate: _endDate);
                  position--;
                });
              },
              child: const Text(
                'Previous Week',
                style: boldFont,
              ),
            ),
            const Text('Weekly Chart', style: boldFontBlack),
            ElevatedButton(
              style: elevatedButtonStyle,
              onPressed: position < 0
                  ? () {
                      setState(() {
                        _startDate = _startDate.add(const Duration(days: 6));
                        _endDate = _endDate.add(const Duration(days: 6));
                        currencyTimeseries = currencyTimeseries = _fetchData(
                            startDate: _startDate, endDate: _endDate);
                        position++;
                      });
                    }
                  : null,
              child: const Text(
                'Next Week',
                style: boldFont,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        FutureBuilder<CurrencyTimeseries>(
          future: currencyTimeseries,
          builder: chartBuilder,
        ),
      ],
    );
  }

  //Build the chart
  Widget chartBuilder(context, snapshot) {
    if (snapshot.hasData) {
      CurrencyTimeseries data = snapshot.data!;
      chartData = getChartData(data);
      return SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat('yMd'),
        ),
        enableAxisAnimation: true,
        series: <ChartSeries>[
          LineSeries<ChartData, DateTime>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: lightVioletColor,
          ),
        ],
      );
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    } else {
      return const CircularProgressIndicator();
    }
  }

  List<ChartData> getChartData(CurrencyTimeseries data) {
    int index = 0;
    chartData.clear();
    for (Rate rate in data.rates.values) {
      chartData.add(ChartData(
        data.rates.keys.toList()[index],
        rate.pln,
      ));
      index++;
    }

    chartData.sort((a, b) => (a.x).compareTo(b.x));
    return chartData;
  }
}
