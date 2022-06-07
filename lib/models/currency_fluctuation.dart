import 'dart:convert';

import 'package:currency_exchange/models/currency.dart';
import 'package:currency_exchange/models/rate.dart';

class CurrencyFluctuation {
  CurrencyFluctuation({
    required this.base,
    required this.endDate,
    required this.fluctuation,
    required this.rates,
    required this.startDate,
    required this.success,
  });

  Currency base;
  DateTime endDate;
  bool fluctuation;
  Rate rates;
  DateTime startDate;
  bool success;

  factory CurrencyFluctuation.fromRawJson(String str) =>
      CurrencyFluctuation.fromJson(json.decode(str));

  factory CurrencyFluctuation.fromJson(Map<Currency, dynamic> json) =>
      CurrencyFluctuation(
        base: Currency.values
            .firstWhere((element) => element.name == json['base']),
        endDate: json["end_date"],
        fluctuation: json["fluctuation"],
        rates: Rate.fromJson(json["rate"]),
        success: json["success"],
        startDate: json["start_date"],
      );
}
