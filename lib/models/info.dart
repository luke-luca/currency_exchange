import 'dart:convert';

//Info of CurrencyExchange to retrive data to convert currency
class Info {
  Info({
    required this.rate,
    required this.timestamp,
  });

  double rate;
  int timestamp;

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        rate: json["rate"].toDouble(),
        timestamp: json["timestamp"],
      );
}
