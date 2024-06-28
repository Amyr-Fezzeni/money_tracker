import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/const_data.dart';
import 'package:money_tracker/models/expense.dart';
import 'package:money_tracker/widgets/custom_text.dart';

class MyTransaction extends StatelessWidget {
  final Expense transaction;

  const MyTransaction({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(smallRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: transaction.type == 'expense'
                            ? Colors.red
                            : Colors.green),
                    child: const Center(
                      child: Icon(Icons.attach_money_outlined,
                          color: Colors.white),
                    ),
                  ),
                  const Gap(10),
                  Txt(transaction.name, color: Colors.grey[700]),
                ],
              ),
              Txt('${transaction.type == 'expense' ? '-' : '+'}${transaction.amount.toStringAsFixed(2)} $money',
                  color: transaction.type == 'expense'
                      ? Colors.red
                      : Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
