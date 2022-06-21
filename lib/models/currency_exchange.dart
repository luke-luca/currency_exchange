import 'dart:convert';
import 'package:currency_exchange/models/info.dart';
import 'package:currency_exchange/models/query.dart';

//Model of CurrencyExchange to retrive data to convert currency
class CurrencyExchange {
  CurrencyExchange({
    required this.date,
    required this.historical,
    required this.info,
    required this.query,
    required this.result,
    required this.success,
  });

  DateTime date;
  bool historical;
  Info info;
  Query query;
  double result;
  bool success;

  factory CurrencyExchange.fromRawJson(String str) =>
      CurrencyExchange.fromJson(json.decode(str));

  factory CurrencyExchange.fromJson(Map<String, dynamic> json) =>
      CurrencyExchange(
        date: DateTime.parse(json["date"]),
        historical: json["historical"],
        info: Info.fromJson(json["info"]),
        query: Query.fromJson(json["query"]),
        result: json["result"].toDouble(),
        success: json["success"],
      );
}
