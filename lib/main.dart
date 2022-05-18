// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

//Widgets
import './Widgets/Chart.dart';
import './Widgets/New_transaction.dart';
import './Widgets/Transactions_list.dart';

//Date
import 'Moduls/Transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transaction Application',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: TextTheme().copyWith(
          headline1: TextStyle(
            fontFamily: "Open Sans",
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: TextStyle(
            fontFamily: "Quick Sand",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "t1",
    //   title: "New Shose",
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "New Mobile",
    //   amount: 700,
    //   date: DateTime.now(),
    // ),
  ];

  //To send to the chart just last 7 Tranaction date
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  //To add the transaction in the array with re-render
  void _addTransaction(String title, String amount, DateTime date) {
    setState(() {
      _userTransactions.add(
        Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: double.parse(amount),
          date: date,
        ),
      );
    });
  }

  //To show the bottomModelSheet
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) => NewTransaction(addTransaction: _addTransaction));
  }

  void _deleteItem(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    bool _showChart = false;

    final PreferredSizeWidget appBar = AppBar(
      title: const Text("Personal Expenses"),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
      titleTextStyle: Theme.of(context).appBarTheme.toolbarTextStyle,
    );
    final txLists = SizedBox(
      height: (MediaQuery.of(context).size.height * 0.7) -
          MediaQuery.of(context).padding.top -
          appBar.preferredSize.height,
      child: TransactionsList(
        transactions: _userTransactions,
        deleteItem: _deleteItem,
      ),
    );
    return Scaffold(
      appBar: Platform.isIOS
          ? CupertinoNavigationBar(
              middle: const Text("Personal Expenses"),
              trailing: IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(CupertinoIcons.add),
              ))
          : appBar,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => _startAddNewTransaction(context),
              child: Icon(Icons.add),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (_isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("Show the Chart !"),
                  ),
                  Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  ),
                ],
              ),
            if (_isLandScape)
              _showChart
                  ? SizedBox(
                      height: (MediaQuery.of(context).size.height * 0.7) -
                          MediaQuery.of(context).padding.top -
                          appBar.preferredSize.height,
                      child: Chart(transactions: _recentTransactions),
                    )
                  : txLists,
            if (!_isLandScape)
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.3) -
                    MediaQuery.of(context).padding.top -
                    appBar.preferredSize.height,
                child: Chart(transactions: _recentTransactions),
              ),
            if (!_isLandScape) txLists
          ],
        ),
      ),
    );
  }
}
