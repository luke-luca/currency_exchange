class Rate {
  Rate({
    required this.pln,
    required this.gbp,
    required this.usd,
  });

  double pln;
  double gbp;
  double usd;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        pln: json["PLN"],
        gbp: json["GBP"],
        usd: json["USD"],
      );
}
