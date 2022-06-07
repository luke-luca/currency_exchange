import 'package:currency_exchange/models/currency.dart';
import 'package:currency_exchange/models/currency_exchange.dart';
import 'package:currency_exchange/models/rate.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ApiHub {
  ApiHub._internal();

  factory ApiHub() {
    return _instance;
  }

  static final _instance = ApiHub._internal();
  static const _apiKey = 'qm90JCjPOtd2O32EZhTCAfe0phTaXxJO';
  static const _apiUrl = 'https://api.apilayer.com/exchangerates_data';

  final Dio _dio = Dio();
  Future<CurrencyExchange> fetchData(Currency from, Currency to, double amount,
      {DateTime? date}) async {
    date ??= DateTime.now();
    RequestOptions req = RequestOptions(
      path: '/convert',
      queryParameters: {
        'from': from.name,
        'to': to.name,
        'amount': amount.toString(),
        'date': DateFormat('yyyy-MM-dd').format(date),
      },
      baseUrl: _apiUrl,
      headers: {'apikey': _apiKey},
      method: 'GET',
    );
    Response response = await _dio.fetch(req);
    return CurrencyExchange.fromJson(response.data);
  }

  Future<Rate> fetchFluctuation(
    Currency base,
    DateTime endDate,
    DateTime startDate,
  ) async {
    RequestOptions req = RequestOptions(
      path: '/fluctuation',
      queryParameters: {
        'base': base.name,
        'end_date': DateFormat('yyyy-MM-dd').format(endDate),
        'start_date': DateFormat('yyyy-MM-dd').format(startDate),
      },
      baseUrl: _apiUrl,
      headers: {'apikey': _apiKey},
      method: 'GET',
    );
    Response response = await _dio.fetch(req);
    return Rate.fromJson(response.data);
  }
}
