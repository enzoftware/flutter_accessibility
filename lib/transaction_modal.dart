import 'package:flutter/material.dart';

import 'domain/transaction.dart';
import 'utils/utils.dart';

typedef TransactionVoidCallback = void Function(Transaction transaction);
typedef TransactionTypeCallback = void Function(TransactionType? type);

class TransactionModal extends StatelessWidget {
  final TransactionVoidCallback onButtonPressed;

  const TransactionModal({Key? key, required this.onButtonPressed})
      : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required TransactionVoidCallback onButtonPressed,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: barrierDismissible,
      builder: (context) => Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TransactionModal(
            onButtonPressed: (transaction) {
              onButtonPressed.call(transaction);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateController = TextEditingController();
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    var _transactionType;

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: Text(
                    'Add an entry',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TransactionTypeRadioForm(
                callback: (value) {
                  _transactionType = value;
                },
              ),
              const SizedBox(height: 8),
              TransactionTextFormField(
                label: 'Description',
                controller: descriptionController,
                validator: (value) =>
                    value!.isNotEmpty ? null : 'This field can\'t be empty',
              ),
              const SizedBox(height: 8),
              TransactionTextFormField(
                label: 'Amount',
                inputType: TextInputType.number,
                controller: amountController,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return isNumeric(value) ? null : 'The value is not numeric';
                  } else {
                    return 'This field can\'t be empty';
                  }
                },
              ),
              const SizedBox(height: 8),
              TransactionTextFormField(
                label: 'Date',
                inputType: TextInputType.datetime,
                controller: dateController,
                validator: (value) =>
                    value!.isNotEmpty ? null : 'This field can\'t be empty',
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save entry'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final amountText = amountController.text.trim();
                      final dateText = dateController.text.trim();
                      final descriptionText = descriptionController.text.trim();
                      final transaction = Transaction(
                        amount: double.tryParse(amountText) ?? 0.0,
                        date: dateText,
                        description: descriptionText,
                        type: _transactionType ?? TransactionType.income,
                      );
                      onButtonPressed(transaction);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionTextFormField extends StatelessWidget {
  const TransactionTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.inputType = TextInputType.text,
    required this.validator,
  }) : super(key: key);
  final String label;
  final TextEditingController controller;
  final TextInputType inputType;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}

class TransactionTypeRadioForm extends StatefulWidget {
  const TransactionTypeRadioForm({Key? key, required this.callback})
      : super(key: key);
  final TransactionTypeCallback callback;

  @override
  _TransactionTypeRadioFormState createState() =>
      _TransactionTypeRadioFormState();
}

class _TransactionTypeRadioFormState extends State<TransactionTypeRadioForm> {
  TransactionType? _type = TransactionType.income;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RadioListTile<TransactionType>(
            title: const Text(
              'Income',
              semanticsLabel: 'Transaction type income',
              style: TextStyle(fontSize: 14),
            ),
            value: TransactionType.income,
            groupValue: _type,
            onChanged: (value) {
              setState(() {
                _type = value;
                widget.callback(value);
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<TransactionType>(
            title: const Text(
              'Expense',
              semanticsLabel: 'Transaction type expense',
              style: TextStyle(fontSize: 14),
            ),
            value: TransactionType.expense,
            groupValue: _type,
            onChanged: (value) {
              setState(() {
                _type = value;
                widget.callback(value);
              });
            },
          ),
        ),
      ],
    );
  }
}
