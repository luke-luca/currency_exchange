import 'package:currency_exchange/api_hub.dart';
import 'package:currency_exchange/models/currency.dart';
import 'package:currency_exchange/models/rate.dart';
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

  Future<Rate> _fetchFlucattion() async {
    return await ApiHub()
        .fetchFluctuation(Currency.PLN, DateTime.now(), DateTime.now());
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
                  decoration: const InputDecoration(labelText: 'Pick Date'),
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2050),
                  format: DateFormat('yyyy-MM-dd'),
                  onChanged: (value) {
                    _formKey.currentState!.save();
                  },
                ),
                FormBuilderDateTimePicker(
                  name: 'endDate',
                  decoration: const InputDecoration(labelText: 'Pick End Date'),
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2050),
                  format: DateFormat('yyyy-MM-dd'),
                  onChanged: (value) {
                    _formKey.currentState!.save();
                  },
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
                FutureBuilder<Rate>(
                  future: _fetchFlucattion(),
                  builder: (context, snapshot) {
                    Rate data = snapshot.data!;
                    if (snapshot.hasData) {
                      return Text(data.changePct.toString());
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return const CircularProgressIndicator();
                    }
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
