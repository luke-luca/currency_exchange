import 'package:currency_exchange/api_hub.dart';
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

  Stream<CurrencyExchange> _convertData() async* {
    yield await ApiHub().fetchData(
        Currency.values.firstWhere(
            (element) => element.name == _formKey.currentState!.value['from']),
        Currency.values.firstWhere(
            (element) => element.name == _formKey.currentState!.value['to']),
        double.parse(_formKey.currentState!.value['amount']));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 500,
      child: Column(
        children: [
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'amount',
                  decoration: const InputDecoration(labelText: 'Amount'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(70),
                  ]),
                ),
                FormBuilderDropdown(
                  name: 'from',
                  decoration: const InputDecoration(labelText: 'From'),
                  items: Currency.values.map((currency) {
                    return DropdownMenuItem(
                      value: currency.name,
                      child: Text(currency.name.toString()),
                    );
                  }).toList(),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderDropdown(
                  name: 'to',
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
                  onPressed: () {
                    _formKey.currentState!.save();

                    setState(() {
                      shouldDisplay = true;
                    });
                  },
                  child: const Text('Submit'),
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
                    ? StreamBuilder<CurrencyExchange>(
                        stream: _convertData(),
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
