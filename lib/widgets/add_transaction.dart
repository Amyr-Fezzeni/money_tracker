import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:money_tracker/constants/const_data.dart';
import 'package:money_tracker/models/expense.dart';
import 'package:money_tracker/service/context_extention.dart';
import 'package:money_tracker/service/util.dart';
import 'package:money_tracker/widgets/buttons.dart';
import 'package:money_tracker/widgets/custom_text.dart';
import 'package:money_tracker/widgets/popup.dart';

class AddTransaction extends StatefulWidget {
  final Expense? expense;
  const AddTransaction({super.key, this.expense});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final amount = TextEditingController();
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late Expense expense;
  @override
  void initState() {
    super.initState();
    expense = widget.expense ??
        Expense(
            id: generateId(),
            name: '',
            type: ExpenseType.expense.name,
            amount: 0,
            date: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Txt('${widget.expense == null ? 'NEW' : 'EDIT'}  TRANSACTION',
            bold: true),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Txt('Expense'),
                Switch(
                  value: expense.type == ExpenseType.income.name,
                  onChanged: (newValue) {
                    setState(() => expense.type == ExpenseType.expense.name
                        ? expense.type = ExpenseType.income.name
                        : expense.type = ExpenseType.expense.name);
                  },
                ),
                Txt('Income'),
              ],
            ),
            const Gap(5),
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '0.00 $money',
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Enter an amount';
                        }
                        return null;
                      },
                      controller: amount,
                    ),
                  ),
                ),
              ],
            ),
            Gap(20.sp),
            settingsPopup(
                title: 'Type',
                selectedValue: (expense.type == ExpenseType.expense.name
                    ? expensesTypes.first['name']
                    : incomesTypes.first['name']) as String,
                lst: expense.type == ExpenseType.expense.name
                    ? expensesTypes
                    : incomesTypes)
          ],
        ),
      ),
      actions: [
        primaryButton(
            text: 'Cancel',
            color: Colors.red[300],
            function: () => context.pop()),
        primaryButton(
            text: 'Save',
            color: context.primaryColor,
            function: () {
              if (formKey.currentState!.validate()) {
                expense.name = name.text;
                expense.amount = double.parse(amount.text);
                if (widget.expense == null) {
                  context.dataRead.addTransaction(expense);
                } else {
                  context.dataRead.updateTransaction(expense);
                }
                context.pop();
              }
            })
      ],
    );
  }
}
