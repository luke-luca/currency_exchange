//Rate class to store data to calculate currency timeseries and get specific rate of currency
class Rate {
  Rate({
    required this.pln,
  });

  double pln;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        pln: json["PLN"],
      );
}
