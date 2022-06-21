import 'package:currency_exchange/models/currency.dart';
import 'package:currency_exchange/models/currency_exchange.dart';
import 'package:currency_exchange/models/currency_timeseries.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'models/currency_fluctuation.dart';

//Singleton to send request to API
class ApiHub {
  ApiHub._internal();

  factory ApiHub() {
    return _instance;
  }
  //Connection info to API
  static final _instance = ApiHub._internal();
  static const _apiKey = 'kzrVtT0F0ki4s99wSI7Iz0L0UP81NByz';
  static const _apiUrl = 'https://api.apilayer.com/exchangerates_data';
  //Initialize dio
  final Dio _dio = Dio();
  //Fetch data for currency exchange to convert currency
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

  //Fetch data for currency fluctuation
  Future<CurrencyFluctuation> fetchFluctuation(
    Currency base,
    DateTime endDate,
    DateTime startDate,
    Currency symbol,
  ) async {
    RequestOptions req = RequestOptions(
      path: '/fluctuation',
      queryParameters: {
        'base': base.name,
        'end_date': DateFormat('yyyy-MM-dd').format(endDate),
        'start_date': DateFormat('yyyy-MM-dd').format(startDate),
        'symbols': symbol.name,
      },
      baseUrl: _apiUrl,
      headers: {'apikey': _apiKey},
      method: 'GET',
    );

    Response response = await _dio.fetch(req);
    return CurrencyFluctuation.fromJson(response.data, symbol);
  }

  //Fetch data for currency timeseries
  Future<CurrencyTimeseries> fetchTimeseries(
    Currency base,
    DateTime endDate,
    DateTime startDate,
    List<Currency> symbol,
  ) async {
    RequestOptions req = RequestOptions(
      path: '/timeseries',
      queryParameters: {
        'base': base.name,
        'end_date': DateFormat('yyyy-MM-dd').format(endDate),
        'start_date': DateFormat('yyyy-MM-dd').format(startDate),
        'symbols': symbol.map((e) => e.name).join(','),
      },
      baseUrl: _apiUrl,
      headers: {'apikey': _apiKey},
      method: 'GET',
    );

    Response response = await _dio.fetch(req);
    return CurrencyTimeseries.fromJson(
      response.data,
    );
  }
}
