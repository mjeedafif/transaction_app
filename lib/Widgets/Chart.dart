// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './Chart_Bar.dart';

import '../Moduls/Transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart({Key? key, required this.transactions}) : super(key: key);

  List<Map<String, Object>> get _groupOfTransactionsValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (int i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalSum += transactions[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "total": totalSum
      };
    }).reversed.toList();
  }

  double get _getTotalSpending {
    final double totalSpending = transactions.fold(0.0, (sum, item) {
      return ((sum) + item.amount);
    });

    return totalSpending;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _groupOfTransactionsValue
            .map(
              (tx) => ChartBar(
                  label: tx["day"] as String,
                  amount: tx["total"] as double,
                  percentageAmount: _getTotalSpending == 0
                      ? 0.0
                      : ((tx["total"] as double) / _getTotalSpending)),
            )
            .toList(),
      ),
    );
  }
}
