import 'package:currency_exchange/api_hub.dart';
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
  Stream<List<CurrencyExchange>> _fetchData({required DateTime date}) async* {
    List<CurrencyExchange> data = [];
    for (Currency currency
        in Currency.values.sublist(0, Currency.values.length - 1)) {
      data.add(
          await ApiHub().fetchData(Currency.PLN, currency, 1, date: _date));
      yield data;
    }
  }

  @override
  void initState() {
    _fetchData(date: _date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Broke Currency Exchange'),
        FormBuilder(
          key: _formKey,
          child: FormBuilderDateTimePicker(
            name: 'date',
            enabled: true,
            decoration: const InputDecoration(
              labelText: 'Date',
            ),
            initialValue: DateTime.now(),
            inputType: InputType.date,
            format: DateFormat('yyyy-MM-dd'),
            onChanged: (value) {
              _formKey.currentState!.save();
              setState(() {
                _date = _formKey.currentState!.value['date'];
              });
            },
          ),
        ),
        StreamBuilder<List<CurrencyExchange>>(
          stream: _fetchData(date: _date),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CurrencyExchange> data = snapshot.data!;
              return DataTable(
                columns: const [
                  DataColumn(
                    label: Text('From'),
                  ),
                  DataColumn(
                    label: Text('To'),
                  ),
                  DataColumn(
                    label: Text('Result'),
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
                              Text(currencyExchange.result.toString()),
                            ),
                          ],
                        ))
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
