// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String title, String amount, DateTime date) addTransaction;

  const NewTransaction({required this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _datePicked;

  void _addNewTransaction() {
    final title = titleController.text;
    final amount = amountController.text;

    if (amount.isEmpty) {
      return;
    }

    if (title.isEmpty || double.parse(amount) <= 0 || _datePicked == null) {
      return;
    }

    widget.addTransaction(title, amount, _datePicked as DateTime);

    Navigator.of(context).pop();
  }

  void _pickedDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _datePicked = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Title",
              ),
              //onChanged: (val) => titleInput = val,
              controller: titleController,
              onSubmitted: (_) => _addNewTransaction(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
              //onChanged: (val) => amountInput = val,
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _addNewTransaction(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      _datePicked == null
                          ? "No Date chosen"
                          : DateFormat.yMd().format(_datePicked as DateTime),
                    ),
                    fit: FlexFit.tight,
                  ),
                  TextButton(
                    onPressed: _pickedDate,
                    child: const Text(
                      "Choose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _addNewTransaction(),
              child: const Text("Add transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
