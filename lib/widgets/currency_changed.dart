import 'package:currency_exchange/api_hub.dart';
import 'package:currency_exchange/models/currency.dart';
import 'package:currency_exchange/models/currency_fluctuation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class CurrencyChanged extends StatefulWidget {
  const CurrencyChanged({Key? key}) : super(key: key);

  @override
  State<CurrencyChanged> createState() => _CurrencyChangedState();
}

class _CurrencyChangedState extends State<CurrencyChanged> {
  final _formKey = GlobalKey<FormBuilderState>();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  Currency _currency = Currency.EUR;
  Future<CurrencyFluctuation> _fetchFlucattion(
      {required DateTime startDate,
      required DateTime endDate,
      required Currency currency}) async {
    return await ApiHub().fetchFluctuation(
        currency,
        endDate, //teraz
        startDate, //kiedys
        Currency.PLN);
  }

  @override
  void initState() {
    _fetchFlucattion(
        startDate: _startDate, endDate: _endDate, currency: _currency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 500,
      child: Column(
        children: [
          const Text('Pick Dates'),
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderDateTimePicker(
                  name: 'startDate',
                  enabled: true,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                  ),
                  initialValue: DateTime.now(),
                  inputType: InputType.date,
                  format: DateFormat('yyyy-MM-dd'),
                ),
                FormBuilderDateTimePicker(
                  name: 'endDate',
                  enabled: true,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                  ),
                  initialValue: DateTime.now(),
                  inputType: InputType.date,
                  format: DateFormat('yyyy-MM-dd'),
                ),
                FormBuilderDropdown(
                  name: 'currency',
                  decoration: const InputDecoration(labelText: 'To'),
                  items: Currency.values.map((currency) {
                    return DropdownMenuItem(
                      value: currency.name,
                      child: Text(currency.name.toString()),
                    );
                  }).toList(),
                  validator: FormBuilderValidators.required(),
                ),
                ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      _formKey.currentState!.save();
                      setState(() {
                        _startDate = _formKey.currentState!.value['startDate'];
                        _endDate = _formKey.currentState!.value['endDate'];
                        _currency = Currency.values.firstWhere((element) =>
                            element.name ==
                            _formKey.currentState!.value['currency']);
                      });
                    }),
                FutureBuilder<CurrencyFluctuation>(
                  future: _fetchFlucattion(
                      startDate: _startDate,
                      endDate: _endDate,
                      currency: _currency),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      CurrencyFluctuation data = snapshot.data!;
                      return Column(children: [
                        Text(data.startDate.toString()),
                        Text(data.endDate.toString()),
                        Text(
                          data.rates.startRate.toStringAsFixed(4),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          data.rates.endRate.toStringAsFixed(4),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          ((data.rates.endRate - data.rates.startRate) /
                                  data.rates.startRate)
                              .toStringAsFixed(4),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          "${((((data.rates.endRate - data.rates.startRate) / data.rates.startRate) * 100)).toStringAsFixed(2)}%",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ]);
                    } else if (snapshot.hasError) {
                      return Text(
                        snapshot.error.toString(),
                        style: Theme.of(context).textTheme.headline6,
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
