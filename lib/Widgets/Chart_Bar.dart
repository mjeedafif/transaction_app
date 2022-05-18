// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentageAmount;

  const ChartBar({
    Key? key,
    required this.label,
    required this.amount,
    required this.percentageAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(7),
        child: LayoutBuilder(
          builder: (ctx, constrains) {
            return Column(
              children: [
                SizedBox(
                  height: constrains.maxHeight * 0.15,
                  child: FittedBox(
                    child: Text(
                      "\$${amount.toStringAsFixed(0)}",
                      // style: const TextStyle(
                      //   fontSize: 25,
                      // ),
                    ),
                  ),
                ),
                SizedBox(
                  height: constrains.maxHeight * 0.05,
                ),
                SizedBox(
                  height: constrains.maxHeight * 0.6,
                  width: 10,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(197, 197, 197, 1),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: constrains.maxHeight * 0.6,
                        width: 10,
                      ),
                      FractionallySizedBox(
                        heightFactor: percentageAmount,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: constrains.maxHeight * 0.05,
                ),
                SizedBox(
                  child: Text(label),
                  height: constrains.maxHeight * 0.15,
                ),
              ],
            );
          },
        ));
  }
}
