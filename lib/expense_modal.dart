import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/domain/expense.dart';
import 'package:flutter_expense_tracker/utils.dart';

typedef ExpenseVoidCallback = void Function(Expense expense);
typedef ExpenseTypeCallback = void Function(ExpenseType type);

class ExpenseModal extends StatelessWidget {
  final ExpenseVoidCallback onButtonPressed;

  const ExpenseModal({Key key, this.onButtonPressed}) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    ExpenseVoidCallback onButtonPressed,
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
          child: ExpenseModal(
            onButtonPressed: (expense) {
              onButtonPressed?.call(expense);
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
    var _expenseType;

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
                  child: ExcludeSemantics(
                    child: Text(
                      'Add an expense',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ExpenseTypeRadioForm(
                callback: (value) {
                  _expenseType = value;
                },
              ),
              const SizedBox(height: 8),
              ExpenseTextFormField(
                label: 'Description',
                controller: descriptionController,
                validator: (value) =>
                    value.isNotEmpty ? null : 'This field cant be empty',
              ),
              const SizedBox(height: 8),
              ExpenseTextFormField(
                label: 'Amount',
                inputType: TextInputType.number,
                controller: amountController,
                validator: (value) {
                  if (value.isNotEmpty) {
                    return isNumeric(value) ? null : 'The value is not numeric';
                  } else {
                    return 'This field cant be empty';
                  }
                },
              ),
              const SizedBox(height: 8),
              ExpenseTextFormField(
                label: 'Date',
                inputType: TextInputType.datetime,
                controller: dateController,
                validator: (value) =>
                    value.isNotEmpty ? null : 'This field cant be empty',
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save expense'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      final amountText = amountController.text.trim();
                      final dateText = dateController.text.trim();
                      final descriptionText = descriptionController.text.trim();
                      final expense = Expense(
                        amount: double.tryParse(amountText) ?? 0.0,
                        date: dateText,
                        description: descriptionText,
                        type: _expenseType ?? ExpenseType.increase,
                      );
                      onButtonPressed(expense);
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

class ExpenseTextFormField extends StatelessWidget {
  const ExpenseTextFormField({
    Key key,
    @required this.label,
    this.controller,
    this.inputType = TextInputType.text,
    this.validator,
  }) : super(key: key);
  final String label;
  final TextEditingController controller;
  final TextInputType inputType;
  final Function(String) validator;
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

class ExpenseTypeRadioForm extends StatefulWidget {
  const ExpenseTypeRadioForm({Key key, this.callback}) : super(key: key);
  final ExpenseTypeCallback callback;

  @override
  _ExpenseTypeRadioFormState createState() => _ExpenseTypeRadioFormState();
}

class _ExpenseTypeRadioFormState extends State<ExpenseTypeRadioForm> {
  ExpenseType _type = ExpenseType.increase;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: MergeSemantics(
            child: RadioListTile<ExpenseType>(
              title: const Text(
                'Increase',
                semanticsLabel: 'Expense type increase',
                style: TextStyle(fontSize: 14),
              ),
              value: ExpenseType.increase,
              groupValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value;
                  widget.callback(value);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: MergeSemantics(
            child: RadioListTile<ExpenseType>(
              title: const Text(
                'Withdrawal',
                semanticsLabel: 'Expense type withdrawal',
                style: TextStyle(fontSize: 14),
              ),
              value: ExpenseType.whitdrawal,
              groupValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value;
                  widget.callback(value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
