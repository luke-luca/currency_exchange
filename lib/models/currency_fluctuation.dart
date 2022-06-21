import 'package:currency_exchange/models/currency.dart';
import 'package:currency_exchange/models/rate_fluctuation.dart';

//Model of CurrencyFluctuation to retrive data to calculate currency fluctuation
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

  factory CurrencyFluctuation.fromJson(
          Map<String, dynamic> json, Currency symbol) =>
      CurrencyFluctuation(
        base: Currency.values
            .firstWhere((element) => element.name == json['base']),
        endDate: DateTime.parse(json["end_date"]),
        fluctuation: json["fluctuation"],
        rates: Rate.fromJson(json["rates"][symbol.name]),
        success: json["success"] == "true",
        startDate: DateTime.parse(json["start_date"]),
      );
}
