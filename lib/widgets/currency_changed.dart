import 'package:currency_exchange/api_hub.dart';
import 'package:currency_exchange/consts.dart';
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
  bool shouldDisplay = false;
  //Fetch data from API
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

  //Initialize
  @override
  void initState() {
    _fetchFlucattion(
        startDate: _startDate, endDate: _endDate, currency: _currency);
    super.initState();
  }

  //Build widget to get result of the form as a currency fluctuation
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Currency Fluctuation',
            style: boldBigFont,
          ),
          const SizedBox(height: 20),
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderDateTimePicker(
                  name: 'startDate',
                  enabled: true,
                  lastDate: DateTime.now(),
                  decoration: inputDecoration.copyWith(labelText: 'startDate'),
                  initialValue: DateTime.now(),
                  inputType: InputType.date,
                  format: DateFormat('yyyy-MM-dd'),
                ),
                const SizedBox(height: 10),
                FormBuilderDateTimePicker(
                  name: 'endDate',
                  enabled: true,
                  lastDate: DateTime.now(),
                  decoration: inputDecoration.copyWith(labelText: 'endDate'),
                  initialValue: DateTime.now(),
                  inputType: InputType.date,
                  format: DateFormat('yyyy-MM-dd'),
                ),
                const SizedBox(height: 10),
                FormBuilderDropdown(
                  name: 'currency',
                  decoration: inputDecoration.copyWith(labelText: 'to'),
                  items: Currency.values.map((currency) {
                    return DropdownMenuItem(
                      value: currency.name,
                      child: Text('${currency.flag} ${currency.name}'),
                    );
                  }).toList(),
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: elevatedButtonStyle,
                    onPressed: () {
                      _formKey.currentState!.save();
                      setState(() {
                        _startDate = _formKey.currentState!.value['startDate'];
                        _endDate = _formKey.currentState!.value['endDate'];
                        _currency = Currency.values.firstWhere((element) =>
                            element.name ==
                            _formKey.currentState!.value['currency']);
                        shouldDisplay = true;
                      });
                    },
                    child: const Text('Submit', style: boldFont),
                  ),
                ),
                const SizedBox(height: 10),
                shouldDisplay
                    ? FutureBuilder<CurrencyFluctuation>(
                        future: _fetchFlucattion(
                            startDate: _startDate,
                            endDate: _endDate,
                            currency: _currency),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            CurrencyFluctuation data = snapshot.data!;
                            double fluc =
                                (data.rates.endRate - data.rates.startRate) /
                                    data.rates.startRate;

                            return Container(
                                width: 500,
                                height: 150,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        Colors.white,
                                        Color.fromARGB(140, 255, 255, 255),
                                        Color.fromARGB(138, 255, 255, 255),
                                        Colors.white10,
                                        Colors.white,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Start Rate:',
                                            style: boldFontBlack,
                                          ),
                                          Text(
                                              '${data.rates.startRate} ${DateFormat.yMd().format(data.startDate)}'),
                                          const Text(
                                            'End Rate:',
                                            style: boldFontBlack,
                                          ),
                                          Text(
                                              '${data.rates.endRate} ${DateFormat.yMd().format(data.endDate)}'),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('${fluc.toStringAsFixed(2)}%',
                                              style: TextStyle(
                                                  color: fluc > 0
                                                      ? Colors.green
                                                      : fluc < 0
                                                          ? Colors.red
                                                          : Colors.black,
                                                  fontSize: 32)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return const CircularProgressIndicator();
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
