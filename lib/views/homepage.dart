import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_tracker/service/context_extention.dart';
import 'package:money_tracker/widgets/add_transaction.dart';
import '../widgets/top_card.dart';
import '../widgets/transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
          backgroundColor: context.primaryColor,
          child: Icon(Icons.add, color: Colors.white, size: 30.sp),
          onPressed: () => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => const AddTransaction())),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Builder(builder: (context) {
              double income = context.dataRead
                  .getIncomes()
                  .map((e) => e.amount)
                  .reduce((a, b) => a + b);
              double expense = context.dataRead
                  .getExpenses()
                  .map((e) => e.amount)
                  .reduce((a, b) => a + b);
              return TopNeuCard(
                balance: (income - expense).toStringAsFixed(2),
                income: income.toStringAsFixed(2),
                expense: expense.toStringAsFixed(2),
              );
            }),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: context.dataWatch.transactions.length,
                          itemBuilder: (context, index) {
                            return MyTransaction(
                                transaction:
                                    context.dataWatch.transactions[index]);
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
