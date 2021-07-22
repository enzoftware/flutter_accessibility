/* Copyright (c) 2021 Razeware LLC

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom
the Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify,
merge, publish, distribute, sublicense, create a derivative work,
and/or sell copies of the Software in any work that is designed,
intended, or marketed for pedagogical or instructional purposes
related to programming, coding, application development, or
information technology. Permission for such use, copying,
modification, merger, publication, distribution, sublicensing,
creation of derivative works, or sale is expressly withheld.

This project and source code may use libraries or frameworks
that are released under various Open-Source licenses. Use of
those libraries and frameworks are governed by their own
individual licenses.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE. */

import 'package:flutter/material.dart';
import 'domain/transaction.dart';
import 'utils.dart';

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
                    value!.isNotEmpty ? null : 'This field cant be empty',
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
                    return 'This field cant be empty';
                  }
                },
              ),
              const SizedBox(height: 8),
              TransactionTextFormField(
                label: 'Date',
                inputType: TextInputType.datetime,
                controller: dateController,
                validator: (value) =>
                    value!.isNotEmpty ? null : 'This field cant be empty',
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save entry'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('object');
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
              // TODO: Add semanticsLabel
              // TODO: Add fontSize
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
              // TODO: Add semanticsLabel
              // TODO: Add fontSize
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
