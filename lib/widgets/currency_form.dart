import 'package:currency_exchange/api_hub.dart';
import 'package:currency_exchange/consts.dart';
import 'package:currency_exchange/models/currency_exchange.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../models/currency.dart';

class CurrencyForm extends StatefulWidget {
  const CurrencyForm({Key? key}) : super(key: key);

  @override
  State<CurrencyForm> createState() => _CurrencyFormState();
}

class _CurrencyFormState extends State<CurrencyForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool shouldDisplay = false;

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
      width: 500,
      height: 800,
      child: Column(
        children: [
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
                shouldDisplay
                    ? Text(_formKey.currentState!.value['amount'].toString())
                    : Container(),
                shouldDisplay
                    ? Text(_formKey.currentState!.value['from'])
                    : Container(),
                shouldDisplay
                    ? Text(_formKey.currentState!.value['to'])
                    : Container(),
                shouldDisplay
                    ? FutureBuilder<CurrencyExchange>(
                        future: _convertData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            CurrencyExchange data = snapshot.data!;
                            return Text(data.result.toString());
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
