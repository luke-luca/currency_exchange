import 'package:currency_exchange/api_hub.dart';
import 'package:currency_exchange/consts.dart';
import 'package:currency_exchange/models/currency_exchange.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../models/currency.dart';

class CurrencyForm extends StatefulWidget {
  const CurrencyForm({Key? key}) : super(key: key);

  @override
  State<CurrencyForm> createState() => _CurrencyFormState();
}

//Widget to convert data and display result in container
class _CurrencyFormState extends State<CurrencyForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool shouldDisplay = false;
//Fetch data from API
  Future<CurrencyExchange> _convertData() async {
    return await ApiHub().fetchData(
        Currency.values.firstWhere(
            (element) => element.name == _formKey.currentState!.value['from']),
        Currency.values.firstWhere(
            (element) => element.name == _formKey.currentState!.value['to']),
        double.parse(_formKey.currentState!.value['amount']));
  }

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
            'Currency Converter',
            style: boldBigFont,
          ),
          const SizedBox(height: 20),
          FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FormBuilderTextField(
                  name: 'amount',
                  decoration: inputDecoration.copyWith(
                    labelText: 'amount',
                  ),
                  //Validate input to allow only digits and comma
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(',',
                        replacementString: '.'),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],

                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(70),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                FormBuilderDropdown(
                  name: 'from',
                  decoration: inputDecoration.copyWith(labelText: 'from'),
                  items: Currency.values.map((currency) {
                    return DropdownMenuItem(
                      value: currency.name,
                      child: Text('${currency.flag} ${currency.name}'),
                    );
                  }).toList(),
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 10),
                FormBuilderDropdown(
                  name: 'to',
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
                  child: (ElevatedButton(
                    style: elevatedButtonStyle,
                    onPressed: () {
                      _formKey.currentState!.save();
                      setState(() {
                        shouldDisplay = true;
                      });
                    },
                    child: const Text(
                      'Submit',
                      style: boldFont,
                    ),
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                shouldDisplay
                    ? FutureBuilder<CurrencyExchange>(
                        future: _convertData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            CurrencyExchange data = snapshot.data!;
                            //Display result in container
                            return Container(
                                width: 500,
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
                                          Text(
                                            data.query.from.name,
                                            style: boldBigFont,
                                          ),
                                          Text(
                                            data.query.amount
                                                    .toStringAsFixed(2) +
                                                data.query.from.symbol,
                                            style: regularBlackFont,
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 60,
                                        ),
                                      ],
                                    )),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            data.query.to.name,
                                            style: boldBigFont,
                                          ),
                                          Text(
                                            data.result.toStringAsFixed(2) +
                                                data.query.to.symbol,
                                            style: regularBlackFont,
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return const CircularProgressIndicator();
                          }
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
