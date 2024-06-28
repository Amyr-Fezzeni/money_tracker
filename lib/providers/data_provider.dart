import 'package:flutter/material.dart';
import 'package:money_tracker/models/expense.dart';
import 'package:money_tracker/service/local_data.dart';
import 'package:money_tracker/service/navigation_service.dart';

class DataProvider with ChangeNotifier {
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  List<Expense> transactions = [];
  DateTime currentMonth = DateTime.now();

  init({bool notify = true}) {
    transactions = LocalData.getExpenses();
    if (notify) {
      notifyListeners();
    }
  }

  addTransaction(Expense expense) async {
    LocalData.saveExpense(expense);
    init();
  }

  updateTransaction(Expense expense) {
    LocalData.updateExpense(expense);
    init();
  }

  deleteTransaction(Expense expense) {
    LocalData.deleteExpense(expense);
    init();
  }

  List<Expense> getIncomes() =>
      transactions.where((t) => t.type == ExpenseType.income.name).toList();

  List<Expense> getExpenses() =>
      transactions.where((t) => t.type == ExpenseType.expense.name).toList();
}
