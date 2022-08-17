import 'package:currency_exchange/api_hub.dart';
import 'package:currency_exchange/consts.dart';
import 'package:currency_exchange/models/currency.dart';
import 'package:currency_exchange/models/currency_exchange.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class CurrencyTop extends StatefulWidget {
  const CurrencyTop({Key? key}) : super(key: key);

  @override
  State<CurrencyTop> createState() => _CurrencyTopState();
}

class _CurrencyTopState extends State<CurrencyTop> {
  final _formKey = GlobalKey<FormBuilderState>();
  DateTime _date = DateTime.now();
  //Fetch data as stream from API to make top 10 currencies
  Stream<List<CurrencyExchange>> _fetchData({required DateTime date}) async* {
    List<CurrencyExchange> data = [];
    for (Currency currency
        in Currency.values.sublist(0, Currency.values.length - 1)) {
      data.add(
          await ApiHub().fetchData(Currency.PLN, currency, 1, date: _date));
      yield data;
    }
  }

  //Initialize stream with current date
  @override
  void initState() {
    _fetchData(date: _date);
    super.initState();
  }

  //Built container with top 10 currencies and datepick form
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color.fromARGB(140, 255, 255, 255),
              Colors.white30,
              Colors.white10,
              Colors.white,
            ],
          ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ]),
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          DrawerHeader(
            child: Image.asset(
              'assets/img/logo.png',
            ),
          ),
          FormBuilder(
            key: _formKey,
            child: FormBuilderDateTimePicker(
              name: 'date',
              enabled: true,
              lastDate: DateTime.now(),
              decoration: inputDecoration.copyWith(
                labelText: 'date',
              ),
              initialValue: DateTime.now(),
              inputType: InputType.date,
              format: DateFormat('yyyy-MM-dd'),
              onChanged: (value) {
                _formKey.currentState!.save();
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: elevatedButtonStyle,
            onPressed: () {
              setState(() {
                _date = _formKey.currentState!.value['date'];
              });
            },
            child: const Text(
              'Check',
              style: boldFont,
            ),
          ),
          //StreamBuilder to display top 10 currencies in DataTable
          StreamBuilder<List<CurrencyExchange>>(
            stream: _fetchData(date: _date),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CurrencyExchange> data = snapshot.data!;
                return DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'From',
                        style: boldFontBlack,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'To',
                        style: boldFontBlack,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Result',
                        style: boldFontBlack,
                      ),
                    ),
                  ],
                  rows: data
                      .map((currencyExchange) => DataRow(
                            cells: [
                              DataCell(
                                Text(currencyExchange.query.from.flag),
                              ),
                              DataCell(
                                Text(currencyExchange.query.to.flag),
                              ),
                              DataCell(
                                Text(currencyExchange.result.toStringAsFixed(4),
                                    style: boldFontBlack),
                              ),
                            ],
                          ))
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator(
                  strokeWidth: 4.0,
                );
              }
            },
          ),
        ]),
      ),
    );
  }
}
