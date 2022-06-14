import 'dart:convert';
import 'package:currency_exchange/models/currency.dart';
import 'package:currency_exchange/models/rate_timeseries.dart';

class CurrencyTimeseries {
  CurrencyTimeseries({
    required this.base,
    required this.endDate,
    required this.rates,
    required this.startDate,
    required this.success,
    required this.timeseries,
  });

  Currency base;
  DateTime endDate;
  Map<DateTime, Rate> rates;
  DateTime startDate;
  bool success;
  bool timeseries;
  @override
  String toString() {
    return 'CurrencyTimeseries{base: $base, endDate: $endDate, rates: $rates, startDate: $startDate, success: $success, timeseries: $timeseries}';
  }

  factory CurrencyTimeseries.fromJson(Map<String, dynamic> jsonix) =>
      CurrencyTimeseries(
        base: Currency.values
            .firstWhere((element) => element.name == jsonix['base']),
        endDate: DateTime.parse(jsonix["end_date"]),
        rates: Map.fromIterable(jsonix["rates"].keys,
            key: (k) => DateTime.parse(k),
            value: (v) {
              return Rate.fromJson(jsonix["rates"][v]);
            }),
        success: jsonix["success"] == "true",
        startDate: DateTime.parse(jsonix["start_date"]),
        timeseries: jsonix["timeseries"],
      );
}
