// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import '../Moduls/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String id) deleteItem;

  const TransactionsList(
      {required this.transactions, required this.deleteItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No transactions added yet !",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset(
                    "Assets/Images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) => Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "\$${transactions[index].amount.toStringAsFixed(2)}"),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    onPressed: () => deleteItem(transactions[index].id),
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
              itemCount: transactions.length,
            ),
    );
  }
}
