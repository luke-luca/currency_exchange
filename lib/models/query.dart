import 'dart:convert';

import 'package:currency_exchange/models/currency.dart';

class Query {
  Query({
    required this.amount,
    required this.from,
    required this.to,
  });

  double amount;
  Currency from;
  Currency to;

  factory Query.fromRawJson(String str) => Query.fromJson(json.decode(str));

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        amount: json["amount"],
        from: Currency.values
            .firstWhere((element) => element.name == json['from']),
        to: Currency.values.firstWhere((element) => element.name == json['to']),
      );
}
