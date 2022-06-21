import 'dart:convert';

//Rate class to store data to calculate currency fluctuation
class Rate {
  Rate({
    required this.change,
    required this.changePct,
    required this.endRate,
    required this.startRate,
  });

  double change;
  double changePct;
  double endRate;
  double startRate;

  factory Rate.fromRawJson(String str) => Rate.fromJson(json.decode(str));

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
      change: json["change"],
      changePct: json["change_pct"],
      endRate: json["end_rate"],
      startRate: json["start_rate"]);
}
